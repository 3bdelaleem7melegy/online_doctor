// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<Users> {
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
              'User Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(onPressed: (){Navigator.pushNamed(context, '/MyAppointments');}, icon: Icon(Icons.arrow_back))
        ),
        
        body: Column(children: [

        StreamBuilder<QuerySnapshot>(
          
          stream: FirebaseFirestore.instance
              .collection('Doctors')
              // .doc(user.uid)
              // .collection("all")
              .where('id', isEqualTo: 'QRucNWZttjRvvn6scu148k3DnVI2')
              .snapshots(),
          builder: (context, snapshot) {
            List<Row> DentistWidgets = [];
            if (snapshot.hasData) {
              // print(snapshot.data!.docs);
              // return Container(
              //   child: Column(
              //     children: [ Container(
              //       child: Row(
              //         children: [
              //           Container(
              //             padding: EdgeInsets.only(left: 40),
              //         child: Text(snapshot.data!.docs.first.data()['name'],style: TextStyle(color: Colors.blue[900],fontSize: 25,),),
              //       ),
              //       SizedBox(width: 25,),
              //       Container(
              //         child: Text(snapshot.data!.docs.first.data()['description'],style: TextStyle(color: Colors.blue[900],fontSize: 25,)),
              //       ),
              //                     SizedBox(width: 25,),

              //        Container(
              //         child: Text(snapshot.data!.docs.first.data()['doctor'],style: TextStyle(color: Colors.blue[900],fontSize: 25,)),
              //        ),

              //         ],

              //       ),

              //      ),
              //      Container(
              //         child: Text(snapshot.data!.docs.first.data()['phone'],style: TextStyle(color: Colors.blue[900],fontSize: 25,)),

              //      )
              //     ],

              //   ),

              // );

              final Dentists = snapshot.data?.docs.reversed.toList();
              for (var Dentist in Dentists!) {

                var DentistWidget = Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: [Text(Dentist['name'],style: TextStyle(fontSize: 20),),
                  // Text(Dentist['doctor'],style: TextStyle(fontSize: 20),)],
                  children: [
                    Container(
                      
                      padding: EdgeInsets.only(top: 25),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                      child: Container(
                          child: Column(
                            
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Padding(padding: EdgeInsets.only(top: 25)),
                          Container(

                            child: Text(
                              Dentist['name'],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              Dentist['email'],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                           SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              Dentist['phone'],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                           SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              Dentist['id'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                         
                        ],
                      )),
                    ),
                  ],
                );
                DentistWidgets.add(DentistWidget);
              }
            }
            return Expanded(
              child: ListView(
                children: DentistWidgets,
              ),
            );
          },
        )
        ]));
        
  }
}

