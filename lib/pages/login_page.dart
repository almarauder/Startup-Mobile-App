import 'package:flutter/material.dart';
import 'package:startup_app/auth/auth_service.dart';
import 'package:startup_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {

  // get auth service 
  final authService = AuthService() ; 

  // text controllers 
  final _emailController = TextEditingController() ; 
  final _passwordController = TextEditingController() ; 

  // login button pressed 
  void login() async {
    final email = _emailController.text ; 
    final password = _passwordController.text ; 

    // attempt login 
    try {
      await authService.signInWithEmailPassword(email, password) ; 
    } 
    
    // catch any errors 
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"))) ; 
      }
    }
  }

  // UI part 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Логин") , 
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          // email 
          TextField(
            controller: _emailController , 
            decoration: const InputDecoration(labelText: "Email"),
          ) , 
          
          // password 
          TextField(
            controller: _passwordController ,  
            decoration: const InputDecoration(labelText: "Пароль"),
          ) , 

          const SizedBox(height: 12) , 

          // button 
          ElevatedButton(
            onPressed: login, 
            child: const Text("Логин") , 
          ) , 

          const SizedBox(height: 12) , 

          // go to the register page for signing up 
          GestureDetector(
            onTap: () => Navigator.push(context , MaterialPageRoute(builder: (context) => const RegisterPage()
            )) , 
            child: const Center(child: Text("Нету аккаунта?"))) , 
        ],
      )
    );
  }
}