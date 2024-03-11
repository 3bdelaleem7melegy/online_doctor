// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, library_private_types_in_public_api, unused_element, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:online_doctor/LoginUser/Login.dart';
import 'package:online_doctor/app/models/appointment_model.dart';
import 'package:online_doctor/app/models/patient_model.dart';
import 'package:online_doctor/bannerModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAdmin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _doctorName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _doctorName = TextEditingController();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        actions: <Widget>[IconButton(onPressed: (){
          Navigator.pushNamed(context, '/DoctorProfile');
        }, icon: Icon(Icons.people,size: 30,),)],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Padding(padding: EdgeInsets.only(top: 20))
              Container(
                // width: MediaQuery.of(context).size.width/1.3,
                alignment: Alignment.center,
                child: Text(
                  _message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),


              const SizedBox(
                width: 55,
              ),
              
              // IconButton(
              //   splashRadius: 20,
              //   icon: const Icon(Icons.notifications_active),
              //   onPressed: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (contex) => const NotificationList()));
              //   },
              // ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        
       
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Appointments')
            .doc(doctor!.Special)
            .collection("Pending")
            .where('doctor.name', isEqualTo: doctor!.name)
            .snapshots(),
        builder: (context, snapshot) {
          //log(snapshot.data!.docs.map((e) => e.data()).toString());
          // log(snapshot.data!.docs.map((e) => e.data()).toString());
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No Appionment',style: TextStyle(fontSize: 30),));
            } else {
              final data = snapshot.data!.docs
                  .map((e) => Appointment.formJson(e.data()))
                  .toList();
              log(data.map((e) => e.toFireStore()).toString());
      
              log(data.length.toString());
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 100),
                    child: Text("Hello Dr. ${user.displayName}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),
                  ),
                  Text(
                  'My Appointment',
                  style: const TextStyle(
                                        color: Colors.black,

                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  Expanded(child: AppointmentsWidgetList(appointments: data)),
                ],
              );
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [schedule, settings];
  static const List<MenuItem> secondItems = [logout];

  static const schedule = MenuItem(text: 'schedule Labs', icon: Icons.schedule,);
  // static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'schedule Rumors', icon: Icons.schedule_outlined);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, Patient patient) {
    switch (item) {
      case MenuItems.schedule:
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/MyAppointments', (route) => false,
            arguments: patient);
        // Navigator.of(context).pushNamedAndRemoveUntil(

        //         '/MyAppointments',
        //         arguments: patient,
        //          (Route<dynamic> route) => false)
        //     as MenuItem
        //  );
        //Do something
        break;
      case MenuItems.settings: Navigator.of(context).pushNamedAndRemoveUntil(
            '/MyAppointmentsRumor', (route) => false,
            arguments: patient);
        //Do something
        break;
        //Do something
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}

String convertDate(String date) {
  final d = DateTime.parse(date);
  // final dateString = DateFormat.yMMMd().parse(date);
  return d.toString();
}

class AppointmentsWidgetList extends StatelessWidget {
  const AppointmentsWidgetList({super.key, required this.appointments});
  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    log(appointments.map((e) => e.id).toString());

    return ListView.separated(
      separatorBuilder: (context, i) => SizedBox(
        height: 0,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, i) => Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: bannerCards.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    //alignment:  Alignment.centerLeft,
                    //width: MediaQuery.of(context).size.width,
                    height: 140,
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
                    padding: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        stops: [0.3, 0.7],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: bannerCards[index].cardBackground,
                      ),
                    ),

                    child: Row(children: [
                      Text(
                        'Patient Name: ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        appointments[i].patient.name,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: const Icon(
                                Icons.list,
                                size: 46,
                                color: Colors.blue,
                              ),
                              items: [
                                ...MenuItems.firstItems.map(
                                  (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                                const DropdownMenuItem<Divider>(
                                    enabled: false, child: Divider()),
                                ...MenuItems.secondItems.map(
                                  (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                MenuItems.onChanged(context, value! as MenuItem,
                                    appointments[i].patient);
                              },
                              dropdownStyleData: DropdownStyleData(
                                width: 160,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue,
                                ),
                                offset: const Offset(0, 8),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                customHeights: [
                                  ...List<double>.filled(
                                      MenuItems.firstItems.length, 48),
                                  8,
                                  ...List<double>.filled(
                                      MenuItems.secondItems.length, 48),
                                ],
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  scrollPhysics: ClampingScrollPhysics(),
                ),
              )),
        ],
      ),
    );

    // Text(appointments[index].patient.name),
    // Text(convertDate(appointments[index].date)),
    // Text(convertDate(appointments[index].date)),
    //     ],
    //   ),
    //  );
  }
}
