import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/profilescreen.dart';
import 'package:flutter_application_5/views/registrationscreen.dart';
import 'package:flutter_application_5/views/sellerpage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Buyer")),
        body: const Center(child: Text('Buyer')),
        drawer: Drawer(
          child: ListView(
            children: [ 
              UserAccountsDrawerHeader(
           accountEmail: const Text('@gmail.com'), // keep blank text because email is required
          accountName: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.check,
                  ),
                ),
              ),
    
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Unregistered'),
                  Text('Unregistered'),
                ],
              ),
            ],
          ),
        ),
               ListTile(
              title: const Text('Buyer'),
              onTap: () {
                Navigator.push(
                  context,
            MaterialPageRoute(
              builder: (content) => const MainScreen()));
              },
            ),
    
            ListTile(
              title: const Text('Seller'),
              onTap: () {
                Navigator.push(
                  context,
            MaterialPageRoute(
              builder: (content) => const SellerScreen()));
                        
              },
            ),
           ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => const ProfileScreen()));
                  },
                ),
                 ListTile(
                  title: const Text('Register as New User'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => const RegistrationScreen()));
                  },
                ),
            
         ] ),
        ));
  }
}
