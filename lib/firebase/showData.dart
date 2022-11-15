import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController aboutC = TextEditingController();
  void updateUser(
      String id, String name, String email, String phone, String about) async {
    await firestore
        .collection("user")
        .doc(id)
        .update({"name": name, "email": email, "phone": phone, "about": about});
  }

  void deleteUser(String id) async {
    await firestore.collection("user").doc(id).delete();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added Data"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (c, i) {
                    var dataa = snapshot.data!.docs[i];

                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      background: Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 30,
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("DELETE")),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (_) {
                        deleteUser(dataa.id);
                      },
                      child: Card(
                        child: ExpansionTile(
                          leading: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.cancel),
                                              ),
                                              Text("Update Data"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: nameC,
                                          ),
                                          TextFormField(
                                            controller: emailC,
                                          ),
                                          TextFormField(
                                            controller: phoneC,
                                          ),
                                          TextFormField(
                                            controller: aboutC,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              updateUser(
                                                  dataa.id,
                                                  nameC.text,
                                                  emailC.text,
                                                  phoneC.text,
                                                  aboutC.text);
                                            },
                                            child: Text("Update"),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(
                            dataa["name"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Email: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  dataa["email"],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Phone Number: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  dataa["phone"],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "About: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  dataa["about"],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
