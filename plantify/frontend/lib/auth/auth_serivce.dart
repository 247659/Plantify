import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSerivce {
    final SupabaseClient _supabase = Supabase.instance.client;

    Future<void> signInWithEmailPassword(
        String email, String password) async {
      try {
          final AuthResponse response = await _supabase.auth.signInWithPassword(
          email: email,
          password: password,
      );
      final Session? session = response.session; 

  if (session != null) {
        final accessToken = session.accessToken;
        // final refreshToken = session.refreshToken;

        print('Access Token: $accessToken');
        // print('Refresh Token: $refreshToken');
      } else {
        print('Brak sesji - logowanie się nie powiodło.');
      }

      } catch (e) {
        print('Nieoczekiwany błąd: $e');
      }
    }


    Future<AuthResponse> signUpWithEmailPassword(
        String email, String password) async {
      return await _supabase.auth.signUp(
          email: email,
          password: password
      );
    }

    Future<void> signOut() async {
      await _supabase.auth.signOut();
    }

    String? getCurrentUserEmail() {
       final session = _supabase.auth.currentSession;
       final user = session?.user;
       return user?.email;
    }

    String? getCurrentUserAccessToken() {
      final session = _supabase.auth.currentSession;
      final accessToken = session?.accessToken;
      return accessToken;
    }
}

