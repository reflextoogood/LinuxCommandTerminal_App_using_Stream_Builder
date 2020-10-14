import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linuxcommand_app/TerminalStream.dart';

import 'package:linuxcommand_app/signIn.dart';

class Desicion extends StatefulWidget {
  @override
  _DesicionState createState() => _DesicionState();
}

class _DesicionState extends State<Desicion> {
  var authentication = FirebaseAuth.instance;
  var emailUser;
  var passwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Log IN"),
          backgroundColor: Color(0xffec0101),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )),
      body: Container(
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Login Page",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      cursorWidth: 4.0,
                      decoration: InputDecoration(
                          helperText: 'Put your Email here',
                          helperStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "Enter Your Email",
                          hintStyle:
                              TextStyle(fontSize: 19.0, color: Colors.white)),
                      onChanged: (value) {
                        emailUser = value;
                      },
                    ),
                    TextField(
                      autocorrect: false,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      cursorWidth: 4.0,
                      obscureText: true,
                      decoration: InputDecoration(
                          helperText: 'Type your password ',
                          helperStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "Enter Your Password",
                          hintStyle:
                              TextStyle(fontSize: 19.0, color: Colors.white)),
                      onChanged: (value) {
                        passwd = value;
                      },
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      elevation: 5.0,
                      minWidth: 200.0,
                      height: 35,
                      color: Colors.red.withOpacity(0.4),
                      child: new Text('SUBMIT',
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.white)),
                      onPressed: () async {
                        print("clicked on submit");
                        try {
                          var sign =
                              await authentication.signInWithEmailAndPassword(
                                  email: emailUser, password: passwd);
                          print(sign);

                          if (sign != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TerminalStream()));
                          }
                        } catch (ex) {
                          print(ex);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(110.0, 0.0, 30.0, 40.0),
                      child: Row(
                        children: [
                          Text(
                            "New User,then click here to register",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.account_box,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()));
                              })
                        ],
                      ),
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
