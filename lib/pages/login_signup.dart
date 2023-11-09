import 'package:flutter/cupertino.dart';
import 'package:login_signup_firebase/pages/login_page.dart';
import 'package:login_signup_firebase/pages/sign_up.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  bool isLogin=true;
  void togglePage()
  {
    setState(() {

      isLogin=!isLogin;

    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLogin)
      return Login_Page(onPressed: togglePage);
    else
      return SignUp(onPressed: togglePage);
    return const Placeholder();
  }
}
