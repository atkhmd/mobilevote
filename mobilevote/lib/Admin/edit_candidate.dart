import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilevote/Admin/candidates_list.dart';

class EditCandidate extends StatefulWidget {
  const EditCandidate(
      {required this.name,
      required this.programme,
      required this.manifesto,
      required this.age,
      this.index});

  final String name;
  final String programme;
  final String manifesto;
  final String age;
  final index;

  @override
  EditCandidateState createState() => EditCandidateState();
}

class EditCandidateState extends State<EditCandidate> {
  late TextEditingController controllerName;
  late TextEditingController controllerProgramme;
  late TextEditingController controllerManifesto;
  late TextEditingController controllerAge;

  late String name;
  late String programme;
  late String manifesto;
  late String age;

  void editCandidate() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      // ignore: await_only_futures
      await transaction.update(snapshot.reference, {
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
    //  _dueDate = widget.dueDate;
    //  _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    name = widget.name;
    programme = widget.programme;
    manifesto = widget.manifesto;
    age = widget.age;

    controllerName = TextEditingController(text: widget.name);
    controllerProgramme = TextEditingController(text: widget.programme);
    controllerManifesto = TextEditingController(text: widget.manifesto);
    controllerAge = TextEditingController(text: widget.age);
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
                controller: controllerName,
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
                controller: controllerProgramme,
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
                controller: controllerManifesto,
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
                controller: controllerAge,
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
                    editCandidate();
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
                    "Edit Candidate",
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
