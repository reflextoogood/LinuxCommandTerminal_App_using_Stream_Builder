import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TerminalStream extends StatefulWidget {
  @override
  _TerminalStreamState createState() => _TerminalStreamState();
}

class _TerminalStreamState extends State<TerminalStream> {
  var msgtextcontroller = TextEditingController();
  var fordatabase = FirebaseFirestore.instance;
  var authentication = FirebaseAuth.instance;
  var cmd;
  var webdata;

  call() async {
    try {
      var url = "http://192.168.0.192/cgi-bin/linux.py?x=${cmd}";
      var r = await http.get(url);
      webdata = r.body;
      await fordatabase.collection("LinuxData").add({
        "$cmd": webdata,
        "cmd": "$cmd",
        "output": webdata,
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffec0101),
        title: Text("Terminal"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              print("user is now signed off");
              await authentication.signOut();
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                print("user is now signed off");
                await authentication.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/redhat3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "RUN YOUR LINUX COMMANDS",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          onChanged: (value) {
                            cmd = value;
                          },
                          autocorrect: false,
                          controller: msgtextcontroller,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          cursorColor: Colors.white,
                          cursorWidth: 4.0,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              hintText: "Run your command",
                              helperText: 'Enter ur command',
                              helperStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  fontSize: 19.0, color: Colors.white),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "  [root@localhost ~]#  ",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ))),
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      height: 35,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Color(0xFFff4b5c),
                      onPressed: () {
                        msgtextcontroller.clear();
                        call();
                      },
                      child: Text("RUN"),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 400.0,
                      height: 350.0,
                      color: Colors.black.withOpacity(0.5),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int i) {
                            return StreamBuilder<QuerySnapshot>(
                              builder: (context, snapshot) {
                                print('new data comes');
                                var msg = snapshot.data.docs;
                                List<Widget> y = [];
                                for (var d in msg) {
                                  var command = d.data()['cmd'];
                                  var finaloutput = d.data()['output'];
                                  var msgwid = Text(
                                    "[root@localhost ~]# $command\n$finaloutput",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19.0),
                                  );
                                  y.add(msgwid);
                                }

                                print(y);

                                return Container(
                                  child: Column(
                                    children: y,
                                  ),
                                );
                              },
                              stream: fordatabase
                                  .collection("LinuxData")
                                  .snapshots(),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
