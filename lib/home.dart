import 'package:flutter/material.dart';
import 'package:linuxcommand_app/Login.dart';

class LinuxApp extends StatefulWidget {
  @override
  _LinuxAppState createState() => _LinuxAppState();
}

class _LinuxAppState extends State<LinuxApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Linux Dashboard"),
          backgroundColor: Color(0xffec0101),
          leading: Icon(Icons.navigate_before),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Image.asset('assets/Linux.jpg'),
              Text("What is Linux?",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
              Text(
                """ \nLinux is a family of open-source Unix-like operating systems based on the Linux kernel, an operating system kernel first released on September 17, 1991, by Linus Torvalds. Linux is typically packaged in a Linux distribution.           
                  \nLinux has been around since the mid-1990s and has since reached a user-base that spans the globe. Linux is actually everywhere: It?s in your phones, your thermostats, in your cars, refrigerators, Roku devices, and televisions. It also runs most of the Internet, all of the world’s top 500 supercomputers, and the world’s stock exchanges.\n""",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              ),
              Text("Why Linux?",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
              Text(
                """Linux is also distributed under an open source license. Open source follows these key tenants:
                          \n1)The freedom to run the program, for any purpose.
                          \n2)The freedom to study how the program works, and change it to make it do what you wish.
                          \n3)The freedom to redistribute copies so you can help your neighbor.
                          \n4)The freedom to distribute copies of your modified versions to others.
                          \nThese points are crucial to understanding the community that works together to create the Linux platform. Without a doubt, Linux is an operating system that is ?by the people, for the people?. These tenants are also a main factor in why many people choose Linux. It?s about freedom and freedom of use and freedom of choice.""",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "\nWhy choose Red Hat?",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/redhat.png'),
              Text(
                  """Linux is the foundation for the modern IT stack, and Red Hat is one of the leading contributors to the Linux kernel and associated technologies in open source communities. Red Hat engineers help improve features, reliability, and security to make sure your infrastructure performs and remains stable—no matter your use case and workload.
Red Hat Enterprise Linux provides a standard operating environment for everything your enterprise does in every environment—powering the apps that run your business across bare-metal, virtual, containerized, and private and public clouds. Plus, customers running Red Hat Enterprise Linux gain economic advantages of more than USD 1 trillion each year, just because of the OS.""",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0)),
              Text(
                "WANT TO TRY IT!!!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              MaterialButton(
                elevation: 5.0,
                height: 35,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Color(0xFFff4b5c),
                onPressed: () {
                  print("pressed");

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Desicion()));
                },
                child: Text("GO TO TERMINAL"),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          )),
        ));
  }
}
