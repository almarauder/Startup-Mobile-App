/* Auth Gate - Continously listen for auth state change 

unauthenticated -> Login Page 
authenticated -> Profile Page 

*/ 

import 'package:flutter/material.dart';
import 'package:startup_app/pages/login_page.dart';
import 'package:startup_app/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listen to auth state changes 
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // Build appropriate page based on the state 
      builder: (context , snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator())
          ) ; 
        }

        // check if there are valid session currently 
        final session = snapshot.hasData? snapshot.data!.session : null ; 
        if (session != null) {
          return Home() ;
        } else { 
          return LoginPage() ; 
        }
      }
    );
  }
}