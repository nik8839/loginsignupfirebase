import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/pages/login_page.dart';

class SignUp extends StatefulWidget {
  final void Function()?onPressed;
  const SignUp({super.key, required this.onPressed});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading=false;

  final _formKey=GlobalKey<FormState>();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  createUserWithEmailAndPassword()async{
    try {
      setState(() {
        isLoading=true;
      });
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading=false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading=false;
      });
      if (e.code == 'weak-password') {
        return  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content:Text('password is weak'),
        ),
        );

       // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content:Text('Already in use'),
        ),
        );
        //print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
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
                        //print("validation done");
                        createUserWithEmailAndPassword();

                      }

                    },
                    child: isLoading?const Center(child: CircularProgressIndicator(color: Colors.white,)):const Text("Signup"),

                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height:45,
                  child: ElevatedButton(
                    onPressed:
                      widget.onPressed,


                   // },
                    child: const Text("Login"),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),



    );
  }
}
