import 'package:fithealth/AuthScreens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.width*1;
        return Scaffold(
      appBar: AppBar(
        title: Text(
          "FitHeath",
          style: GoogleFonts.abel(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/start.jpg'),
              fit: BoxFit.cover,
              opacity: 0.7),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height*0.1,),
              Text("Fitness Guide",style: GoogleFonts.aboreto(textStyle:const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),),
              SizedBox(height:height*0.02),
              Container(
                  width: 450,
                  child: Text(
                      "Start your day with a 5-minute wake-up stretch, followed by a 20-minute cardio session incorporating brisk walking or jogging. In the afternoon, spend 15 minutes on strength training with bodyweight exercises and 10 minutes on flexibility and balance through yoga poses. Wind down in the evening with 10 minutes of mindfulness meditation and a 5-minute bedtime stretch. Remember to stay hydrated, eat a balanced diet, take regular breaks from sitting, and prioritize adequate sleep for optimal health and well-being.",
                      style: GoogleFonts.aboreto(textStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),),),
          
              SizedBox(height:height*0.02),
              ElevatedButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()));
              }, child: Text('Get Started',style: GoogleFonts.farro(textStyle:const TextStyle(fontWeight: FontWeight.bold)),),),
            ],
          ),
        ),
      ),
    );
  }
}
