import 'package:flutter/material.dart';
import 'package:startup_app/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // get auth service 
  final authService = AuthService() ; 

  // text controllers 
  final _emailController = TextEditingController() ; 
  final _passwordController = TextEditingController() ; 
  final _confirmPassword = TextEditingController() ; 

  // sign up button pressed 
  void signUp() async {

    // prepare data 
    final email = _emailController.text ; 
    final password = _passwordController.text ; 
    final confirmPassword = _confirmPassword.text ; 

    // check if passwords match 
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: const Text("Пароли не совпадают!"))) ; 
      return ; 
    }

    // attempt sign up 
    try {
      await authService.signUpWithEmailPassword(email, password) ; 

      // pop register page 
      Navigator.pop(context) ; 
    }

    // catch any errors 
    catch (e) {
      if (mounted) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Ошибка: $e"))) ; 
      return ; 
      }
    }
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Регистрация") , 
        ) , 
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

            // confirm password 
            TextField(
              controller: _confirmPassword ,  
              decoration: const InputDecoration(labelText: " Подтвердите пароль"),
            ) , 

            const SizedBox(height: 12) , 

            // button 
            ElevatedButton(
              onPressed: signUp, 
              child: const Text("Регистрация") , 
            ) , 
          ],
        )
      );
  
  }
}