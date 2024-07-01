import 'package:fithealth/Api/daily_exercise.dart';
import 'package:fithealth/Screens/HomeScreen.dart';
import 'package:fithealth/Screens/search_exercise_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchExerciseList extends StatefulWidget {
  final String targetName;
  const SearchExerciseList({super.key,required this.targetName});

  @override
  State<SearchExerciseList> createState() => _SearchExerciseListState();
}

class _SearchExerciseListState extends State<SearchExerciseList> {

  //function to get the specific target muscle
  var SearchData=[];
  void getSearchExercise()async{
    DailyExerciseApi mySearch = DailyExerciseApi();
    List data =await mySearch.getSearchName(widget.targetName);
    setState(() {
      SearchData = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchExercise();
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
      
      body: (SearchData.isEmpty)?const Center(child: CircularProgressIndicator(),):Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.targetName,style: GoogleFonts.abel(textStyle:const TextStyle(fontSize: 21,fontWeight: FontWeight.bold,))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: SearchData.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 2,
                    shadowColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(SearchData[index]['gifUrl']),
                        title: Text('Name : ${SearchData[index]['name']}',style: GoogleFonts.habibi(textStyle:const TextStyle(fontWeight: FontWeight.bold,)),),
                        subtitle: Text('Target Muscle : ${SearchData[index]['target']}',style: GoogleFonts.habibi(textStyle:const TextStyle(fontWeight: FontWeight.w400,))),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchExerciseDetailPage(index: index,targetQuery: widget.targetName,)));
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