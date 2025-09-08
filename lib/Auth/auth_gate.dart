import 'package:flutter/material.dart';
import 'package:link_up/pages/home_page.dart';
import 'package:link_up/pages/welcom_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // ✅ This runs at very first launch
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 17, 35, 22), 
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 88, 236, 130),
              ),
            ),
          );
        }

        final session = snapshot.data?.session;
        if (session == null) {
          return const WelcomPage(); 
        } else {
          return const HomePage(); 
        }
      },
    );
  }
}
