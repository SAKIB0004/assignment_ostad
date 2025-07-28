import 'package:flutter/material.dart';

void main(){
  runApp(flutterApp());
}


class flutterApp extends StatelessWidget {
  const flutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Greeting App",
      theme: ThemeData(canvasColor: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Greeting App"),
        //backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello, World!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("Welcome to Flutter",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                //fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Image.asset("images/flutter_logo.png" ,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action when button is pressed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Button Pressed!"))
                );
              },
              child: Text("Press Me",),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
