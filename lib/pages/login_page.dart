import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:koko_chat/services/auth/auth_service.dart';
import 'package:koko_chat/components/custom_text.dart';
import 'package:koko_chat/components/my_button.dart';
import 'package:koko_chat/components/my_textfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  //email and password controllers
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwcontroller = TextEditingController();

  //tap to go to register page
  void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailcontroller.text, _pwcontroller.text);
    }

    // catch any errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            //logo------------------------------------------

            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome back message----------------------------

            CText(
              "Welcome Back,You have been missed",
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 25,
            ),

            //email textfield---------------------------------

            MyTextField(
              controller: _emailcontroller,
              hintText: "E-mail",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            //pw textfield ------------------------------------

            MyTextField(
              controller: _pwcontroller,
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 25),

            //login button-------------------------------------

            MyButton(
              text: "LOGIN",
              onTap: () => login(context),
            ),

            SizedBox(
              height: 25,
            ),

            //register now------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  "Not a member? ",
                  color: Theme.of(context).colorScheme.primary,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: CText(
                    "Register Now",
                    weight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
