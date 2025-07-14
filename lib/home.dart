import 'package:flutter/material.dart';
import 'package:startup_app/pages/hackaton_page.dart';
import 'package:startup_app/pages/internship_page.dart';
import 'package:startup_app/pages/main_page.dart';
import 'package:startup_app/pages/profile_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // На какой странице находится 
  int _selectedIndex = 0 ; 
  
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index ; 
    });
  }

  // Список всех страниц 
  List<Widget> _pages =  [
    MainPage() , 
    InternshipPage() , 
    HackatonPage() , 
    ProfilePage() , 
  ] ; 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex] ,      
      
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex ,
        onTap: _navigateBottomBar , 
        selectedItemColor: Color.fromARGB(255, 0, 98, 255),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Главная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center), 
            label: 'Стажировка'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot), 
            label: 'Хакатоны'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: 'Профиль'
          ),
        ],
      ),
    );
  }
}