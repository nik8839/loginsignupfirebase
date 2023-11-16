import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/pages/sign_up.dart';

class Login_Page extends StatefulWidget {
  final void Function()?onPressed;
  const Login_Page({super.key,required this.onPressed});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading=false;

  final _formKey=GlobalKey<FormState>();
  final FirebaseFirestore _fireStore=FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();

  Future<UserCredential>signInWithEmailAndPassword()async{
    try {

      setState(() {
        isLoading=true;});
      UserCredential userCredential=
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':userCredential.user!.email,

      },SetOptions(merge: true));
      setState(() {

        isLoading=false;
      });



      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      setState(() {
        isLoading=false;
      }

      );

      // if(e.code=='INVALID_LOGIN_CREDENTIALS'||e.code=='The email address is badly formatted')
      //   {
      //     return  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
      //                content:Text('Wrong Credential'),
      //            ),
      //            );
      //
      //   }

      throw Exception(e.code);
      //}
    }
    //dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing: 20.0,
              children: [
                TextFormField(
                  controller: _email,
                  validator :(text){
                    if(text==null||text.isEmpty)
                    {
                      return 'email is empty';
                    }

                    return null;
                  },

                  decoration:const InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: _password,
                  validator:(text){
                    if(text==null||text.isEmpty)
                    {
                      return ' password is empty';
                    }

                    return null;
                  },

                  decoration:const InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  width: double.infinity,
                  height:45,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                      {
                        signInWithEmailAndPassword();

                      }

                    },
                    child: isLoading?const Center(child: CircularProgressIndicator(color: Colors.white,)):const Text("Login"),

                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height:45,
                  child: ElevatedButton(
                    onPressed:
                      widget.onPressed,

                    //},
                    child: const Text("Signup"),

                  ),
                )
              ],
            ),
          ),
        ),
      ),



    );
  }
}
