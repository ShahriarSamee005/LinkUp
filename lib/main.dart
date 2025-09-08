import 'package:flutter/material.dart';
import 'package:link_up/Auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async
{
  await Supabase.initialize(
    url: 'https://sfwcacvvkntgirmndupj.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmd2NhY3Z2a250Z2lybW5kdXBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcyNjYyODYsImV4cCI6MjA3Mjg0MjI4Nn0.2RLsh4BJHxbC9y5AB-J2n9TXWgXnyAgn5Rm7QoV9bdo'
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}