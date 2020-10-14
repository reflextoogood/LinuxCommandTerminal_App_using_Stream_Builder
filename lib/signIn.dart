import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linuxcommand_app/TerminalStream.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var authentication = FirebaseAuth.instance;
  var emailUser;
  var passwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffec0101),
        title: Text("Sign UP"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
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
                    Text("Signup Page",
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
                          helperText: 'Keep it short',
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
                          var sign = await authentication
                              .createUserWithEmailAndPassword(
                                  email: emailUser, password: passwd);
                          if (sign.additionalUserInfo.isNewUser == true) {
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
