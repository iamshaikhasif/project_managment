import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mangment_flutter/pages/auth/login_page.dart';
import 'package:project_mangment_flutter/service/firebase_cloud.dart';
import 'package:project_mangment_flutter/utils/utils.dart';
import 'package:project_mangment_flutter/widget/loader.dart';
import 'package:project_mangment_flutter/widget/text_feild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  registerUser() async {
    try {
      showLoader(context: context);
      UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      createDb(userCredential);
      if (context.mounted) Utils.instance.popScreen(context: context);
    } on FirebaseAuthException catch (err) {
      Utils.instance.logDebugPrint(msg: "${err.message}");
    }
  }

  createDb(UserCredential? userCredential) {
    var fc = FirebaseCloud.instance;
    fc.createUserDoc(
      userCredential: userCredential,
      collectionName: fc.userCollection,
      data: {
        "email": emailController.text.toString(),
        "name":  nameController.text.toString()
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/background.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 50.0),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lets get',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'you on board',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textFromFeild(
                        controller: nameController,
                        inputType: TextInputType.text,
                        onChanged: (value) {},
                        validator: (value) {
                          if (nameController.text.toString().isEmpty) {
                            return "please enter name";
                          }

                          return null;
                        },
                        hint: 'Full name',
                      ),
                      const SizedBox(height: 20.0),
                      textFromFeild(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        validator: (value) {
                          if (emailController.text.toString().isEmpty) {
                            return "please enter email";
                          }
                          return null;
                        },
                        hint: 'Email',
                      ),
                      const SizedBox(height: 20.0),
                      textFromFeild(
                        controller: passwordController,
                        inputType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        maxLen: 6,
                        validator: (value) {
                          if (passwordController.text.toString().isEmpty) {
                            return "please enter password";
                          }
                          if (passwordController.text.toString().length != 6) {
                            return "Password should be at least 6 characters";
                          }
                          return null;
                        },
                        hint: 'Password',
                        texthide: true,
                      ),
                      const SizedBox(height: 10.0),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: GestureDetector(
                      //     onTap: () {},
                      //     child: const Text(
                      //       'Forgot Password?',
                      //       style:
                      //           TextStyle(fontSize: 20.0, color: Colors.blue),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 60.0,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(
                      'Or',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 60.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils.instance.nextScreen(
                            context: context, child: const LoginPage());
                      },
                      child: const Text(
                        ' Sign In',
                        style: TextStyle(fontSize: 25.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
