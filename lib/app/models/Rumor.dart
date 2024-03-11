

import 'package:online_doctor/app/models/doctor_model.dart';
import 'package:online_doctor/app/models/patient_model.dart';

class Rumor {
  final String? id;
  final String date;
  final String description;
  final Patient patient;
  final String type1;

  Rumor({
     this.id,
    required this.type1,
    required this.date,
    required this.patient,
    required this.description,
  });

  factory Rumor.formJson(Map<String, dynamic> json) {
    return Rumor(
      id: json['id'],
      type1: json['type1'],
      date: json['date']??'',
      description: json['description']??'',
      patient: Patient.formJson(json['patient']),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "date": date,
      "type1": type1,
      "description": description,
      "patient": patient.toFireStore(),
    };
  }
}
