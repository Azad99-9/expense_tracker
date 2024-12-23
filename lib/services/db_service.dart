import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static final CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');
}