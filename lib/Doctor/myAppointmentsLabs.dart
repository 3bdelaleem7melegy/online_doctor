// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:online_doctor/app/models/labs_model.dart';
import 'package:online_doctor/app/models/patient_model.dart';
import 'package:online_doctor/bannerModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key, required this.patient});
  final Patient patient;

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'My Appointments Labs',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/HomePageDoctor');
                },
                icon: Icon(Icons.arrow_back))),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Analysis')
                // .doc("Cholestrol")
                // .collection("all")
                .where('patient.id', isEqualTo: widget.patient.id)
                .snapshots(),
            builder: (context, snapshot) {
              log(widget.patient.id);
              final data = snapshot.data!.docs
                  .map((e) => Analysis.formJson(e.data()))
                  .toList();
              // List<Row> DentistWidgets = [];
        
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Appointment',style: TextStyle(fontSize: 25),));
                }
                print(snapshot.data!.docs);
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) => Container(
                    height: 250,
                    
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      itemCount: bannerCards.length,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          
                          // alignment:  Alignment.centerLeft,
                          //width: MediaQuery.of(context).size.width,
                          height: 140,
                          margin:
                              EdgeInsets.only(left: 0, right: 0, bottom: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              stops: [0.3, 0.7],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: bannerCards[index].cardBackground,
                            ),
                          ),
                          child: Column(children: [
                          Container(child: Row(children: [
                              Text("Patient ID: ",style: TextStyle(fontSize: 15),),
                            Text(data[i].patient.id,style: TextStyle(fontSize: 13),)
                          ],),),
                          Container(child: Row(children: [
                              Text("Patient Name: ",style: TextStyle(fontSize: 15),),
                            Text(data[i].patient.name,style: TextStyle(fontSize: 16),)
                          ],),),
                          Container(child: Row(children: [
                              Text("Phone Number: ",style: TextStyle(fontSize: 15),),
                            Text(data[i].patient.phoneNumber,style: TextStyle(fontSize: 16),)
                          ],),),
                          Container(child: Row(children: [
                              Text("Analysis Name: ",style: TextStyle(fontSize: 15),),
                            Text(data[i].type,style: TextStyle(fontSize: 16),)
                          ],),),
                          //   Container(child: Row(children: [
                          //     Text("Description: ",style: TextStyle(fontSize: 15),),
                          //   Text(data[i].description,style: TextStyle(fontSize: 16),)
                          // ],),),
                          
                            
                            
                          ]),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        scrollPhysics: ClampingScrollPhysics(),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            })

        );
  
  }
}

