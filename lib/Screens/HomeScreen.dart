import 'package:fithealth/Api/daily_exercise.dart';
import 'package:fithealth/Screens/body_part_exercise01.dart';
import 'package:fithealth/Screens/daily_exercise_details.dart';
import 'package:fithealth/Screens/equipment_exercise01.dart';
import 'package:fithealth/Screens/search_exercise_list.dart';
import 'package:fithealth/Screens/target_exercise.dart';
import 'package:fithealth/Widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Mydata = [];
  TextEditingController SearchController = TextEditingController();

  //create a function to recieve the json data
  void getDailyData() async {
    try {
      DailyExerciseApi mydaily = DailyExerciseApi();
      List data = await mydaily.getDailyExercise();
      setState(() {
        Mydata = data;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDailyData();
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
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'login',
              style: GoogleFonts.abel(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'About us',
              style: GoogleFonts.abel(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.2,
          )
        ],
      ),
      
      
      body: Mydata.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      //textfield with search button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //textfield
                          Container(
                            width: width * 0.39,
                            child: TextField(
                              controller: SearchController,
                              decoration: InputDecoration(
                                hintText: "Enter the name of the exercise",
                                hintStyle: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          //search button
                          GestureDetector(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchExerciseList(targetName: SearchController.text.toString().toLowerCase()))),
                            child: Container(
                              width: width * 0.13,
                              color: Colors.red,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Search",
                                    style: GoogleFonts.abel(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      //Daily exercise field
                      SizedBox(
                        height: height * 0.022,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Daily exercise",
                            style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                      //list of exercise from the api
                      //NOTE:for responsivness increase the widht of the Container
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Mydata.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyExerciseDetails(
                                                  index: index)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Card(
                                            shadowColor: Colors.yellow,
                                            elevation: 5,
                                            child: Container(
                                              height: height * 0.18,
                                              width: width * 0.14,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  Mydata[index]['gifUrl'],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Mydata[index]['name'],
                                            style: GoogleFonts.abel(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.clip)),
                                          ),
                                        )
                                      ]),
                                ),
                              );
                            }),
                      ),
                      //Different Modex of exercise
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Different modes of exercise",
                            style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: height * 0.01,
                      ),
                      //target wise exercise
                      Card(
                        shadowColor: Colors.yellow,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Target wise exercise",
                                style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //red button to proceed
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const TargetExercise()))),
                                child: Container(
                                  width: width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.abel(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //Equipment wise exercise
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Card(
                        shadowColor: Colors.yellow,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Equipment wise exercise",
                                style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //red button to proceed
                              GestureDetector(
                                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const EquipmentExercise())),
                                child: Container(
                                  width: width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.abel(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //bodyPart wise exercise
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Card(
                        shadowColor: Colors.yellow,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "BodyPart wise exercise",
                                style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //red button to proceed
                              GestureDetector(
                                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const BodyPartExercise01())),
                                child: Container(
                                  width: width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.abel(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    
    
      drawer: MyDrawer()
    );
  }
}
