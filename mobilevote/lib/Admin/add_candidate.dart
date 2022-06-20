import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilevote/Admin/candidates_list.dart';

class AddCandidates extends StatefulWidget {
  const AddCandidates({Key? key}) : super(key: key);

  @override
  _AddCandidatesState createState() => _AddCandidatesState();
}

class _AddCandidatesState extends State<AddCandidates> {
  String name = ' ';
  String programme = ' ';
  String manifesto = '';
  String age = '';

  void _addData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('candidate');
      await reference.add({
        "name": name,
        "programme": programme,
        "manifesto": manifesto,
        "age": age
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Candidate Informations",
                style: GoogleFonts.robotoMono(
                    textStyle: Theme.of(context).textTheme.headline3,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (String str) {
                  setState(() {
                    name = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.dashboard),
                    hintText: "Name",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (String str) {
                  setState(() {
                    programme = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: "Programme",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (String str) {
                  setState(() {
                    manifesto = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: "Manifesto",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (String str) {
                  setState(() {
                    age = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: "Age",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.only(top: 1, left: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    _addData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CandidatesList()));
                  },
                  color: Colors.lightBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "Add Candidate",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
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
}
