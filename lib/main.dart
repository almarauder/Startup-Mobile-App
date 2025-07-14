import 'package:flutter/material.dart';
import 'package:startup_app/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //supabase setup 

  await Supabase.initialize(
    url: "https://pjszwzmtjsqvsndpdrvi.supabase.co", 
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqc3p3em10anNxdnNuZHBkcnZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIzMzE0NzgsImV4cCI6MjA2NzkwNzQ3OH0.izN3AAys2WE-6wMjAndRD28yunUvK1rbwIkjhXHMgXY"
  ) ; 

  runApp(const MyApp()) ; 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate() , 
      debugShowCheckedModeBanner: false,
    );
  }
}