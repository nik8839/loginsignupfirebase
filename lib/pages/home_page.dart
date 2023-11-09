import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  HomePage({super.key});
  final user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('homepage'),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text(user!.email.toString())),
    );
  }
}
