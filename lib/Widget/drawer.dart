import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:fithealth/Screens/body_part_exercise01.dart';
import 'package:fithealth/Screens/equipment_exercise01.dart';
import 'package:fithealth/Screens/target_exercise.dart';
import 'package:fithealth/database/UserData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  //create a function to fetch the current user information
  Future<UserData> getCurrentUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = auth.currentUser;

  if (user != null) {
    // Get the document corresponding to the user from Firestore
    DocumentSnapshot snapshot = await firestore.collection('users').doc(user.uid).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Convert the data from Firestore to your UserData model
      UserData userData = UserData.fromMap(snapshot.data() as Map<String, dynamic>);
      return userData;
    } else {
      // Document doesn't exist
      throw Exception('User data not found');
    }
  } else {
    // No user signed in
    throw Exception('No user signed in');
  }
}


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child:Center(
              child: Column(
                children: [
                  RichText(
                            text: TextSpan(
                    text: "Fit",
                    style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    children: [
                      TextSpan(
                        text: "Health",
                        style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                          ),

                  //displaying the name of the current user
                  Center(
                    child: FutureBuilder<UserData>(
                      future:getCurrentUserData() ,
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }
                        else{
                          return Text("${snapshot.data!.name}");
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            
         
            
            ),
        

        //items\
        const SizedBox(height: 10,),
        ListTile(
          title: Text('Home',style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.w500)),),
          leading: const Icon(Icons.home),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen())),
        ),
        const SizedBox(height: 6,),
        ListTile(
          title: Text('BodyPart List',style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.w500)),),
          leading: const Icon(Icons.home),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const BodyPartExercise01())),
        ),
        const SizedBox(height: 6,),
        ListTile(
          title: Text('Equipment List',style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.w500)),),
          leading: const Icon(Icons.earbuds),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const EquipmentExercise())),
        ),
        const SizedBox(height: 6,),
        ListTile(
          title: Text('Target List',style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.w500)),),
          leading: const Icon(Icons.track_changes),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const TargetExercise())),
        ),
        
        ],
      ),
    );
  }
}