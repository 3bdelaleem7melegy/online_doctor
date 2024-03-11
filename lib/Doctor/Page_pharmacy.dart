// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';

class Treatment extends StatefulWidget {
  const Treatment({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<Treatment> {
   final GlobalKey<FormState> formKey = GlobalKey();


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
            'Treatment',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
             Container(
          padding: const EdgeInsets.only(),
          child: Form(child: Column(
            children: [
               const SizedBox(
            height: 32,
          ),
          CustomTextFormField(
      labelText: 'ID Number',
      hintText: 'Enter ID Number',
      validator: (String? value) => Validations.contactNumberValidation(value),
   ),

          CustomTextFormField(
      validator: (String? value) => Validations.emptyValidation(value),
            
            
      hintText: 'Enter Name',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            
      validator: (String? value) => Validations.emailValidation(value),

      hintText: 'Treatment',
            maxLines: 5,
          ),

          const SizedBox(
            height: 32,
          ),
          ElevatedButton(onPressed: (){}, child: Text("Send",style: TextStyle(fontSize: 20),))
            ],
          ))
             ),
          
        
          ],
        ),

      )
      
    );
  }
}
