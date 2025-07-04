import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_new_app/Pages/addoredit.dart';
import 'package:notes_new_app/Services/dbhelper.dart';
import 'package:notes_new_app/Services/notesmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NotesModel> allData = [];

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  // Fetch notes from database and update UI
  void refreshNotes() async {
    List<NotesModel> notes = await Dbhelper.instance.getData();
    setState(() {
      allData = notes;
    });
  }

  // Navigate to Edit Page
  void editNote(NotesModel note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddorEdit(model: note)),
    );
    refreshNotes();
  }

  // Delete note and refresh
  void deleteNote(NotesModel note) async {
    await Dbhelper.instance.deleteData(note);
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MindPad',
          style: GoogleFonts.acme(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3f51b5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      backgroundColor: Colors.white54,

      // Show message if no notes or ListView if notes exist
      body: allData.isEmpty
          ? Center(
              child: Text(
                "No Notes Added Yet",
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                NotesModel note = allData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: const Color(0xff3f51b5),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    title: Text(
                      note.title ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        note.description ?? '',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.yellow),
                      onPressed: () => editNote(note),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.delete, color: Colors.deepOrange),
                      onPressed: () => deleteNote(note),
                    ),
                  ),
                );
              },
            ),

      // Add Note Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddorEdit()),
          );
          refreshNotes(); // Refresh after adding
        },
        backgroundColor: const Color(0xff3f51b5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
