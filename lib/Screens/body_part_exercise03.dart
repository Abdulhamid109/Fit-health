import 'package:fithealth/Api/body_list.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyExerciseDetailPage extends StatefulWidget {
  final int index;
  final String targetQuery;
  const BodyExerciseDetailPage(
      {super.key, required this.index, required this.targetQuery});

  @override
  State<BodyExerciseDetailPage> createState() =>
      _BodyExerciseDetailPageState();
}

class _BodyExerciseDetailPageState extends State<BodyExerciseDetailPage> {
  //getthe remaining details from the previous data
  var bodyExercisDetail = [];
  void getBodyMuscleDetails() async {
    BodyList mybodyDetail = BodyList();
    List data = await mybodyDetail.getBodyMuscleData(widget.targetQuery);
    setState(() {
      bodyExercisDetail = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBodyMuscleDetails();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    // final width = MediaQuery.of(context).size.width*1;
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
      
        body: bodyExercisDetail.isEmpty
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
                              bodyExercisDetail[widget.index]['name'],
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
                                                  bodyExercisDetail[
                                                      widget.index]['gifUrl']),
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
                                        bodyExercisDetail[widget.index]
                                            ['instructions'][index],
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
                            Text(
                              "Secondary Muscle",
                              style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
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
                                        '${index + 1}.${bodyExercisDetail[widget.index]['secondaryMuscles'][index] ?? 'No data'}',
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
                                  bodyExercisDetail[widget.index]['bodyPart'],
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
