import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_new_app/Services/dbhelper.dart';
import 'package:notes_new_app/Services/notesmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MindPad',style: GoogleFonts.acme(fontSize: 50,fontWeight: FontWeight.bold,color: Color(0xff3f51b5)),),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      backgroundColor: Colors.white54,
      body: FutureBuilder(
        future: Dbhelper.instance.getData(), 
        builder: (context,snapshot){
          List<NotesModel>? newData = snapshot.data;
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          else if(!snapshot.hasData){
            return Center(child: Text("No Notes Added Yet",style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 51, 57, 95)),),);
          }
          else{
            return ListView.builder(
              itemCount: newData?.length,
              itemBuilder: (context, index) {
                NotesModel? finalData = newData?[index];
                return ListTile(
                  title: Text(finalData!.title.toString()),
                  subtitle: Text(finalData.description.toString()),
                  trailing: IconButton(onPressed: editMethod(), icon: Icon(Icons.edit,color: Colors.green,)),
                  leading: IconButton(onPressed: deletingMethod(), icon: Icon(Icons.delete,color: Colors.red,)),
                );
              },
            );
          }
        }),

        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Color(0xff3f51b5),
          child: Icon(Icons.add,color: Colors.white,),
        ),
    );
  }
  editMethod(){}
  deletingMethod(){}

  
}