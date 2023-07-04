import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editting controller
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

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
                  Icons.lock,
                  size: 120,
                ),
              ),

              // welcome message
              Text(
                'WELCOME\nLOGIN TO YOUR ACCOUNT',
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
                controller: emailC,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // password
              MyTextField(
                  controller: passwordC,
                  hintText: 'Password',
                  obscureText: true),
              const SizedBox(height: 10),

              // button
              MyButton(
                onTap: () async {
                  // show circular progress indicator
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  // try sign in
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailC.text,
                      password: passwordC.text,
                    );

                    // pop the circular progress ind..
                    if (context.mounted) Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    // pop loading circle
                    Navigator.pop(context);

                    // display error msg
                    dialogBox(e.code);
                  }
                },
                btnName: 'LOGIN',
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
                    "You Haven't account?",
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
                      "Register Now",
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

  void dialogBox(String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(msg),
            ));
  }

  signIn(email, pass) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.toString(),
      password: pass.toString(),
    );
  }
}
