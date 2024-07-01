import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fithealth/AuthScreens/loginScreen.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool toggle = false;
  void setToggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  //create a method SignUp
  void SignUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.uid);
      addData(nameController.text,email,password);
      },
    )
    .catchError((e)=>{
      print(e.toString())
    });
  }

  //create a method to add the data to the cloud firestore with name and password and uid
  // void addData(String name, String email, String password) async {
  //   await FirebaseFirestore.instance
  //   .collection('users')
  //   .doc(FirebaseAuth.instance.currentUser?.uid)
  //   .set({
  //     'name':name,
  //     'email':email,
  //     'password':password,
  //     'uid':FirebaseAuth.instance.currentUser?.uid,
  //   })
  //   .then((value){
  //     SignUp(emailController.text.toLowerCase(),passwordController.text);
  //      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
  //   });
  // }

  void addData(String name, String email, String password) async {
  User? user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  if (user != null) {
    // User is signed in, proceed with adding data
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
          'name': name,
          'email': email,
          'password': password,
          'uid': user.uid,
        })
        .then((value) {
           // No need for emailController and passwordController
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        })
        .catchError((error) {
          print("Error adding data to Firestore: $error");
          // Handle error, such as displaying an error message to the user
        });
  } else {
    // User is not signed in, handle this scenario (e.g., redirect to login screen)
    print("User is not signed in");
    // You might want to redirect the user to the login screen here
  }
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
                    Text("Register",
                        style: GoogleFonts.abel(
                            textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))),

                    //name for demo purpose in cloud fireStore
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //textfield for name
                    Container(
                      width: width * 0.4,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            labelText: "name",
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
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.4,
                      child: TextField(
                        controller: confirmpasswordController,
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
                            labelText: "Confirm Password",
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
                      onTap: (){
                        if(passwordController.text == confirmpasswordController.text){
                          
                          SignUp(emailController.text.toLowerCase(), passwordController.text);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Center(child: Text("Passwords do not match")),
                          ));
                        }
                      },
                      child: Container(
                        width: width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      child: RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue)),
                              ),
                            ]),
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
