import 'package:demoproject/adddata.dart';
import 'package:demoproject/firebase/UserList.dart';
import 'package:demoproject/firebase/update.dart';
import 'package:demoproject/form.dart';
import 'package:demoproject/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB3ak9P2tapTBpiOR3D60_jRqeA1B0mpjI",
        authDomain: "fir-project-cb330.firebaseapp.com",
        projectId: "fir-project-cb330",
        storageBucket: "fir-project-cb330.firebasestorage.app",
        messagingSenderId: "63604192840",
        appId: "1:63604192840:web:55ca2a7f739b0e76044a7d",
        measurementId: "G-16Y4FJGJTE"
    )
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FormScreen()));
            }, child: Text("Add User")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersListPage()));
            }, child: Text("Fetch User")),
          ],
        ),
      ),
    );
  }
}

