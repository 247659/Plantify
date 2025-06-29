const admin = require("firebase-admin/app");
admin.initializeApp();

const mintSupabaseToken = require("./mint_supabase_token.js");
exports.mintSupabaseToken = mintSupabaseToken.mintSupabaseToken;
