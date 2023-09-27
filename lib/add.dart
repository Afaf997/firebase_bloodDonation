import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodgroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  String? selectedGroup;
  final CollectionReference donormodel =
      FirebaseFirestore.instance.collection('donormodel');

      TextEditingController namecontroller =TextEditingController();
      TextEditingController phonecontroller =TextEditingController();
  void addDonner() {
    final datamap = {
      "name": namecontroller.text,
      "phone": phonecontroller.text,
      "blood": selectedGroup,
    };
    donormodel.add(datamap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Doners"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Doner name")),
              ),
            ),
       Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Phone number")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  decoration:
                      const InputDecoration(label: Text("Select Bloodgroup")),
                  items: bloodgroups
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  addDonner();
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
