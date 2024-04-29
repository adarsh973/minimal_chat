import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:koko_chat/services/auth/auth_service.dart';
import 'package:koko_chat/components/my_button.dart';
import 'package:koko_chat/components/my_textfield.dart';
import 'package:koko_chat/components/custom_text.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  //email and password controllers
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwcontroller = TextEditingController();
  TextEditingController _confirmcontroller = TextEditingController();

  //tap to go to login page
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register function
  void register(BuildContext context) {
    //create AuthService
    final authService = AuthService();

    //password match -> create user
    if (_pwcontroller.text == _confirmcontroller.text) {
      try {
        authService.signUpWithEmailPassword(
            _emailcontroller.text, _pwcontroller.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text(e.toString()),
                )));
      }
    }
    // if passes don't match -> show error to user
    // if passes don't match -> show error to user
    else {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("Passwords don't match!"),
              )));
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
              "Let's create an account for you",
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

            //pw textfield-------------------------------------

            MyTextField(
              controller: _pwcontroller,
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 10),

            //confirm pw textfield-----------------------------

            MyTextField(
              controller: _confirmcontroller,
              hintText: "Confirm password",
              obscureText: true,
            ),

            SizedBox(height: 25),

            //login button-------------------------------------

            MyButton(
              text: "REGISTER",
              onTap: () => register(context),
            ),

            SizedBox(
              height: 25,
            ),

            //register now------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  "Already have an account? ",
                  color: Theme.of(context).colorScheme.primary,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: CText(
                    "Login Now",
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
