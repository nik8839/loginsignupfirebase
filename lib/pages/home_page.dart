// import 'dart:html';

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final FirebaseAuth _auth=FirebaseAuth.instance;
  final user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user!.email.toString()),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display user information in the header, such as name and profile picture.
                    Text(user!.email.toString()),
                    SizedBox(height: 8),
                    // Add other user account information or options here.
                  ],
                ),
              ),
              ListTile(
                title: Text('ABC'),
                // Handle the action for Option 1
                onTap: () {
                  // Add your action here.
                },
              ),
              ListTile(
                title: Text('ABC@gmail.com'),
                // Handle the action for Option 2
                onTap: () {
                  // Add your action here.
                },
              ),
              ListTile(
                title: Text('Contact'),
                // Handle the action for Option 1
                onTap: () {
                  // Add your action here.
                },
              ),
              ListTile(
                title: Text('signout'),
                // Handle the action for Option 1
                onTap: () {
                  // Add your action here.
                },
              ),
              ListTile(
                title: Text('Friends'),
                // Handle the action for Option 1
                onTap: () {
                  // Add your action here.
                },
              ),
              // Add more options as needed.
            ],
          ),
        ),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("isLoading");
          }

          return ListView(
            children:
            snapshot.data!.docs.map<Widget>((doc) => _buidUserListItem(doc)).toList(),

          );
        }
    );

  }
  Widget _buidUserListItem(DocumentSnapshot snapshot){
    Map<String,dynamic>data=snapshot.data()! as Map<String,dynamic>;
    if(_auth.currentUser!.email!=data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
            receiverEmailId: data['email'],
            receiveruid: data['uid'],
          )
          ),);
        },

      );
    }
    else
      return Container();


  }
}


