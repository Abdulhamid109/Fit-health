import 'package:fithealth/Api/body_list.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:fithealth/Screens/body_part_exercise03.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyExercise02 extends StatefulWidget {
  final int index;
  final String targetName;
  const BodyExercise02({super.key,required this.index,required this.targetName});

  @override
  State<BodyExercise02> createState() => _BodyExercise02State();
}

class _BodyExercise02State extends State<BodyExercise02> {

  //function to get the specific target muscle
  var BodyData=[];
  void getBodyPartMuscle()async{
    BodyList myBodyPart = BodyList();
    List data =await myBodyPart.getBodyMuscleData(widget.targetName);
    setState(() {
      BodyData = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBodyPartMuscle();
  }
  @override
  Widget build(BuildContext context) {
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
      
      body: BodyData.isEmpty?const Center(child: CircularProgressIndicator(),):Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.targetName,style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.bold,))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: BodyData.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 2,
                    shadowColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(BodyData[index]['gifUrl']),
                        title: Text('Name : ${BodyData[index]['name']}',style: GoogleFonts.habibi(textStyle:const TextStyle(fontWeight: FontWeight.bold,)),),
                        subtitle: Text('Target Muscle : ${BodyData[index]['target']}',style: GoogleFonts.habibi(textStyle:const TextStyle(fontWeight: FontWeight.w400,))),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyExerciseDetailPage(index: index,targetQuery: widget.targetName,)));
                          },
                        ),
                      ),
                    ),
                  );
              }),
            ),
          ],
        ),
      ),
    
    );
  }
}