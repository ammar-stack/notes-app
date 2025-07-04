import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_new_app/Services/dbhelper.dart';
import 'package:notes_new_app/Services/notesmodel.dart';

class AddorEdit extends StatefulWidget {
  NotesModel? model;
  AddorEdit({this.model, super.key});

  @override
  State<AddorEdit> createState() => _AddorEditState();
}

class _AddorEditState extends State<AddorEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      titleController.text = widget.model!.title.toString();
      descriptionController.text = widget.model!.description.toString();
    } else {
      null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.model != null ? "Edit Note" : "Add Note",
          style: GoogleFonts.acme(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color(0xff3f51b5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 50, right: 50),
              child: InkWell(
                onTap: () => addoredit(),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Color(0xff3f51b5),
                  child: Center(
                    child:
                        widget.model != null
                            ? Text(
                              "Edit Note",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                            : Text(
                              "Add Note",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  addoredit() async{
    if(widget.model != null){
      Dbhelper.instance.updateData(NotesModel(title: titleController.text,description: descriptionController.text,id: widget.model?.id));
    }
    else{
      Dbhelper.instance.insertData(NotesModel(title: titleController.text,description: descriptionController.text,time: TimeOfDay.now().toString()));
    }
    Navigator.pop(context);
  }
}
