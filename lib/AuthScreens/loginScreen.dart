import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fithealth/AuthScreens/SignUpScreen.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool toggle = false;
  void setToggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  //create a function to for email and password authentication
  void signIn(String email, String password)async{
    //authenticate the user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/start.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //logo
                    Text("Login",
                        style: GoogleFonts.abel(
                            textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //textfield for email
                    Container(
                      width: width * 0.4,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            labelText: "Email",
                            labelStyle: GoogleFonts.aboreto(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.4,
                      child: TextField(
                        controller: passwordController,
                        obscureText: toggle,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: setToggle,
                              icon: toggle
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            labelText: "Password",
                            labelStyle: GoogleFonts.aboreto(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: ()=>signIn(emailController.text.toLowerCase(),passwordController.text.toString()),
                      child: Container(
                        width: width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      width: width * 0.4,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "or",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterPage())),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: GoogleFonts.abel(
                            textStyle: const TextStyle(fontSize: 18,color: Colors.white),
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.lightBlue)),
                              ),
                          ]
                        ),
                      ),
                    ),

                    

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
