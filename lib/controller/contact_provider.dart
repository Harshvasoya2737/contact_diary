import 'dart:io';

import 'package:contact_diary/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void addContact(
      String name, String names, String number, String gmail, File? image) {
    contactList.add(ContactModel(
        name: name, number: number, gmail: gmail, names: names, image: image));
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(int index, String name, String names, String number,
      String gmail, File? image) {
    contactList[index] = ContactModel(
        name: name, number: number, gmail: gmail, names: names, image: image);
    notifyListeners();
  }
}
