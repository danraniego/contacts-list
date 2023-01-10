import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Contact> contacts = [];

  @override
  void initState() {
    checkPermission();

    super.initState();
  }

  checkPermission() async {

    var status = await Permission.contacts.status;
    if (status.isGranted) {
      await getContacts();
    }

  }

  getContacts() async {
    contacts = await FlutterContacts.getContacts(withProperties: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(contacts[index].displayName),
              subtitle: Text(contacts[index].phones.isNotEmpty
                  ? contacts[index].phones.first.number : "--"),
            );
          }
      ),
    );
  }
}
