import 'package:fithealth/Api/target_list.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:fithealth/Screens/target_exercise02.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TargetExercise extends StatefulWidget {
  const TargetExercise({super.key});

  @override
  State<TargetExercise> createState() => _TargetExerciseState();
}

class _TargetExerciseState extends State<TargetExercise> {
  var targetList = [];
  void getTargetListData() async {
    TargetMuscleListApi myTarget = TargetMuscleListApi();
    List data = await myTarget.getTargetList();
    setState(() {
      targetList = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTargetListData();
  }
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.grey[800],
          title: GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen())),
            child: RichText(
              text: TextSpan(
                  text: "Fit",
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  children: [
                    TextSpan(
                      text: "Health",
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]),
            ),
          ),
          
      ),
      
      body: targetList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: <Widget>[
                    //A girdview Containing the list of target exercise
                    Card(
                      elevation: 4,
                      shadowColor: Colors.cyan,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Exercises for Targeted Muscle',
                          style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.1,
                    ),

                    //gridview represting the list
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,childAspectRatio: 2/1),
                          itemCount: targetList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TargetExercise02(index: index, targetName: targetList[index])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child:  Card(
                                  shadowColor: Colors.white,
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text(targetList[index],style: GoogleFonts.habibi(textStyle:const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,)),)),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
