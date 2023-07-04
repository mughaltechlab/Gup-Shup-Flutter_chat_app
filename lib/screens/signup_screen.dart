import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen({super.key, required this.onTap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //text editting controller
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Center(
                child: Icon(
                  Icons.account_box,
                  // Icons.lock,
                  size: 120,
                ),
              ),

              // welcome message
              Text(
                'CREATE YOUR ACCOUNT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              // textfields

              // email
              MyTextField(
                  controller: emailC, hintText: 'Email', obscureText: false),
              const SizedBox(height: 10),

              // password
              MyTextField(
                  controller: passwordC,
                  hintText: 'Password',
                  obscureText: true),
              const SizedBox(height: 10),

              //confirm password
              MyTextField(
                  controller: confirmPasswordC,
                  hintText: 'Confirm Password',
                  obscureText: true),
              const SizedBox(height: 10),

              // button
              MyButton(
                onTap: signUp,
                btnName: 'SIGNUP',
                btnNamecolor: Colors.white,
                // btncolor: Colors.black,
                linearGradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.grey.shade700,
                  Colors.black,
                  Colors.grey.shade700,
                  Colors.black,
                ]),
              ),

              const SizedBox(height: 10),

              // text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You haven an account!",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ________-----------____FUNCTION_______---------------________________

  // showing alertbox
  void dialogBox(String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(msg),
            ));
  }

  // sign up

  signUp() async {
    // showing loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // if passwords doesn't match
    if (passwordC.text != confirmPasswordC.text) {
      // pop loading
      Navigator.pop(context);
      // show msg
      dialogBox("Passwords don't match");
    }
    // try creating the user (sign up)
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      // after creating user, we create document in firebase firestore and grab users initial email part
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailC.text.split('@')[0], // grabing initial part before @
        'bio': 'empty bio....' // initially empty
      });

      // pop loading circle

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      // showing error msg
      dialogBox(e.code);
    }
  }
}
