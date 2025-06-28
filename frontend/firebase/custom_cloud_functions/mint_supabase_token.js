const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
const jwt = require("jsonwebtoken");
const logger = require("firebase-functions/logger");

// Initialize Firebase Admin
if (!admin.apps.length) {
  admin.initializeApp();
}

function generateJwt(userId, role = "authenticated") {
  const nowSec = Math.floor(Date.now() / 1000);
  const expSec = nowSec + 2 * 60 * 60; // 2 hours

  const payload = {
    sub: userId,
    user_id: userId,
    iss: "supabase",
    role: role,
    iat: nowSec,
    exp: expSec,
  };

  return jwt.sign(payload, process.env.SUPABASE_JWT_SECRET, {
    algorithm: "HS256",
  });
}

async function getCurrentUserFromHeaders(token) {
  try {
    return await admin.auth().verifyIdToken(token);
  } catch (err) {
    logger.error("Error verifying Firebase ID token:", err);
    throw new Error("Unauthorized");
  }
}

exports.mintSupabaseToken = onRequest(async (req, res) => {
  // Handle CORS preflight manually (if your front-end is calling from a different domain)
  if (req.method === "OPTIONS") {
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Access-Control-Allow-Headers", "Content-Type,Authorization");
    res.set("Access-Control-Allow-Methods", "POST, OPTIONS");
    return res.status(204).send("");
  }

  // Only accept POST for the main flow
  if (req.method !== "POST") {
    return res
      .status(405)
      .json({ error: "Method Not Allowed. Use POST or OPTIONS." });
  }

  // Ensure we have JSON
  if (!req.body) {
    return res.status(400).json({ error: "Missing JSON in request body." });
  }

  // Extract the data portion
  const { data } = req.body;
  if (!data) {
    return res.status(400).json({ error: "Missing 'data' field in request." });
  }

  // Check for the Firebase token
  const { token } = data;
  if (!token) {
    return res.status(400).json({ error: "Missing 'token' in request data." });
  }

  // Verify the Firebase ID token to get the user
  let currentUser;
  try {
    currentUser = await getCurrentUserFromHeaders(token);
  } catch (e) {
    return res.status(401).json({ error: e.message });
  }

  // Generate (or retrieve from cache) the Supabase token
  const mintedToken = generateJwt(currentUser.uid, currentUser.role);

  // Optionally log out the user & minted token (for debugging)
  logger.info(
    `User ${currentUser.uid} minted Supabase token: ${mintedToken.slice(0, 10)}...`,
  );

  // Build the response
  const result = {
    data: {
      status: 200,
      access_token: mintedToken,
    },
  };

  // If needed, return CORS headers
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Headers", "Content-Type,Authorization");
  res.set("Access-Control-Allow-Methods", "POST, OPTIONS");

  return res.status(200).json(result);
});
