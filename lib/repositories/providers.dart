import 'package:flutter/material.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';

class Token with ChangeNotifier {
  String _token = '';

  String get token => _token;

  void getToken(String token) {
    _token = token;
    notifyListeners();
  }
}

class UserId with ChangeNotifier {
  int _id = 0;

  int get id => _id;

  void getUserId(int id) {
    _id = id;
    notifyListeners();
  }
}

class MyVenue with ChangeNotifier {
  final List<LapanganModel> _venue = [];

  List<LapanganModel> get venue => _venue;

  void add(List<LapanganModel> venue, int id) {
    venue = _venue.where((e) => e.mitraId == id).toList();
    notifyListeners();
  }
}

class SelectedDate with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void getUserId(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
