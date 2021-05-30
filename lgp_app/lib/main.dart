import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lgp_app/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/custom_user.dart';
import 'screens/exercisepage.dart';
import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyHomePage());
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Routes
      routes: {
        OverallScaffold.routeName: (context) => OverallScaffold(),
      },
      title: "Let's Get Physio-cal",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Circular',
      ),
      home: MyHomePage(),
    );
  }
}*/

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: AuthService().inputUser,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          ExercisePage.routeName: (context) => ExercisePage(),
        },
        title: "Let's Get Physio-cal",
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Circular',
        ),
      ),
    );
  }
}
