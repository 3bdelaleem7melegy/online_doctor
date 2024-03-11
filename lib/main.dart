import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_doctor/Doctor/AdminProfile.dart';
import 'package:online_doctor/Doctor/HomePageAdmin.dart';
import 'package:online_doctor/Doctor/UserDetails.dart';
import 'package:online_doctor/Doctor/Admin.dart';
import 'package:online_doctor/Doctor/myAppointmentRumor.dart';
import 'package:online_doctor/LoginUser/Login.dart';
import 'package:online_doctor/LoginUser/register.dart';
import 'package:online_doctor/app/models/patient_model.dart';
import 'package:online_doctor/firebaseAuth.dart';
import 'package:online_doctor/Doctor/myAppointmentsLabs.dart';

import 'package:online_doctor/note/constants.dart';
import 'package:online_doctor/note/cubits/notes_cubit/notes_cubit.dart';
import 'package:online_doctor/note/models/note_model.dart';
import 'package:online_doctor/note/simple_bloc_observer.dart';
import 'package:online_doctor/note/views/notes_view.dart';
import 'package:online_doctor/skip.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyCbw2AOKUq4JfVoZceQsZP27aCa6Q2z2-U",
              appId: "1:474247137471:android:474f58b5863b60faf3de0a",
              messagingSenderId: "474247137471",
              projectId: "final-project-b67b9"))
      // WidgetsFlutterBinding.ensureInitialized();
      // SystemChrome.setPreferredOrientations(
      //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      : await Firebase.initializeApp();

  await Hive.initFlutter();

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _getUser();
    return BlocProvider(
        create: (context) => NotesCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
          title: 'Flutter Demo',
          initialRoute: '/',
          //
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => Skip());
              case '/login':
                return MaterialPageRoute(builder: (context) => FireBaseAuth());
              case '/SignIn':
                return MaterialPageRoute(builder: (context) => SignIn());
              case '/doctorScreen':
                return MaterialPageRoute(builder: (context) => AdminScreen());
              case '/Users':
                return MaterialPageRoute(builder: (context) => Users());
              case '/MyAppointments':
                return MaterialPageRoute(
                    builder: (context) => MyAppointments(
                          patient: settings.arguments as Patient,
                        ));
              case '/HomePageDoctor':
                return MaterialPageRoute(
                    builder: (context) => HomePageAdmin());
              case '/DoctorProfile':
                return MaterialPageRoute(builder: (context) => AdminProfile());
              case '/MyAppointmentsRumor':
                return MaterialPageRoute(
                    builder: (context) => MyAppointmentsRumor(
                          patient: settings.arguments as Patient,
                        ));

              default:
            }
          },
          // routes: {
          //   // When navigating to the "/" route, build the FirstScreen widget.
          //   '/': (context) => Skip(),
          //   '/login': (context) => FireBaseAuth(),

          //   '/SignIn': (context) => SignIn(),
          //   '/doctorScreen': (context) => doctorScreen(),
          //   '/Users': (context) => Users(),
          //   '/MyAppointments': (context) => MyAppointments(),
          //    '/HomePageDoctor': (context) => HomePageDoctor(),

          // }
        ));
  }
}
