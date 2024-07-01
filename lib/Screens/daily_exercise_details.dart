import 'package:fithealth/Api/daily_exercise.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyExerciseDetails extends StatefulWidget {
  final int index;
  const DailyExerciseDetails({super.key, required this.index});

  @override
  State<DailyExerciseDetails> createState() => _DailyExerciseDetailsState();
}

class _DailyExerciseDetailsState extends State<DailyExerciseDetails> {
  var Details = [];

  void getDetails() async {
    try {
      DailyExerciseApi myDetails = DailyExerciseApi();
      List data = await myDetails.getDailyExercise();
      setState(() {
        Details = data;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: RichText(
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
          
          
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Home',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'login',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About us',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.2,
            )
          ],
        ),
        body: Details.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: <Widget>[
                        //name + dialog for pop in amimation form
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              Details[widget.index]['name'],
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),

                            // button
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Center(
                                              child: Text("Animated Image")),
                                          content: Container(
                                            // height: 200,
                                            // width:200,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: NetworkImage(
                                                  Details[widget.index]
                                                      ['gifUrl']),
                                            )),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Ok"))
                                          ],
                                        );
                                      });
                                },
                                child: const Text("image"))
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        // instructions
                        //consider a listview
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Instructions",
                                style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))),
                          ],
                        ),
                        SizedBox(height: height * 0.012),
                        Container(
                          height: height * 0.5,
                          child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Card(
                                  shadowColor: Colors.red,
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        Details[widget.index]['instructions']
                                            [index],
                                        style: GoogleFonts.abel(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                );
                              
                              }),
                        ),

                        // secondary mussle
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Secondary Muscle",
                                style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),),),
                          ],
                        ),
                        SizedBox(height: height * 0.012),
                        Container(
                          height: height * 0.2,
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Card(
                                  shadowColor: Colors.red,
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        '${index + 1}.${Details[widget.index]['secondaryMuscles'][index] ??'No data'}',
                                        style: GoogleFonts.abel(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                );
                              }),
                        ),
                      
                      
                        //target body part
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Target body Part",
                                style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))),
                          ],
                        ),
                        SizedBox(height: height * 0.012),
                        Card(
                                  shadowColor: Colors.red,
                                  elevation: 6,
                                  child: Container(
                                    // height: height*1,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          Details[widget.index]['bodyPart'],
                                          style: GoogleFonts.abel(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500))),
                                    ),
                                  ),
                                )
                              
                      ],
                    ),
                  ),
                ),
              ));
  
  }
}
