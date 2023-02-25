import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseBloc extends ChangeNotifier {
  factory DatabaseBloc() => _instance;

  DatabaseBloc._init();

  static final DatabaseBloc _instance = DatabaseBloc._init();

  CollectionReference refrence =
      FirebaseFirestore.instance.collection('gallery_images');
  
}