import 'dart:io';

import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  List truckNoList = [
    "Add Truck",
  ];

  void updateTruckNoList({required String newValue}) {
    for (int i = 0; i < truckNoList.length; i++) {
      if (truckNoList[i].toString() == newValue.toString()) {
        print("hi truck already added");
        break;
      } else if (i == truckNoList.length - 1) {
        truckNoList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  List driverNameList = [
    "Add New Driver",
  ];

  void updateDriverNameList({required String newValue}) {
    for (int i = 0; i < driverNameList.length; i++) {
      if (driverNameList[i].toString() == newValue.toString()) {
        print("hi driver already added");
        break;
      } else if (i == driverNameList.length - 1) {
        driverNameList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  int index = 0;
  var dropDownValue1;
  var dropDownValue2;

  void updateDropDownValue1({required String newValue}) {
    dropDownValue1 = newValue;
    notifyListeners();
  }

  void updateDropDownValue2({required String newValue}) {
    dropDownValue2 = newValue;
    notifyListeners();
  }

  String loadingPointCity = "";
  String loadingPointState = "";

  String unloadingPointCity = "";
  String unloadingPointState = "";

  // variables for accountVerification
  File? profilePhotoFile;
  File? panFrontPhotoFile;
  File? panBackPhotoFile;
  File? addressProofPhotoFile;
  File? companyIdProofPhotoFile;

  // variables for login pages

  bool inputControllerLengthCheck = false;
  dynamic buttonColor = MaterialStateProperty.all<Color>(Colors.grey);
  String smsCode = '';
  String phoneController = '';

  //-------------------------------------

  // variables for add truck pages

  String truckTypeValue = '';
  int passingWeightValue = 0;
  int totalTyresValue = 0;
  int truckLengthValue = 0;
  String driverIdValue = '';
  String truckNumberValue = '';

  String truckId = '';

  //variables related to rest button
  bool resetActive = false;

  //variables related to driverApi
  List driverList = [];

  updateProfilePhoto(File newFile) {
    profilePhotoFile = newFile;
    notifyListeners();
  }

  updatePanFrontPhoto(File newFile) {
    panFrontPhotoFile = newFile;
    notifyListeners();
  }

  updatePanBackPhoto(File newFile) {
    panBackPhotoFile = newFile;
    notifyListeners();
  }

  updateAddressProofPhoto(File newFile) {
    addressProofPhotoFile = newFile;
    notifyListeners();
  }

  updateCompanyIdProofPhoto(File newFile) {
    companyIdProofPhotoFile = newFile;
    notifyListeners();
  }

  //------------------------FUNCTIONS--------------------------------------------------------------------------

  void clearLoadingPoint() {
    loadingPointCity = "";
    loadingPointState = "";
    notifyListeners();
  }

  void clearUnloadingPoint() {
    unloadingPointCity = "";
    unloadingPointState = "";
    notifyListeners();
  }

  void updateLoadingPoint({required String city, required String state}) {
    loadingPointCity = city;
    loadingPointState = state;
    notifyListeners();
  }

  void updateUnloadingPoint({required String city, required String state}) {
    unloadingPointCity = city;
    unloadingPointState = state;
    notifyListeners();
  }

  void updateIndex(int newValue) {
    index = newValue;
    notifyListeners();
  }

  //functions for login screen

  void updatePhoneController(String value) {
    phoneController = value;
    print(phoneController);
    notifyListeners();
  }

  void updateInputControllerLengthCheck(bool value) {
    inputControllerLengthCheck = value;
    notifyListeners();
  }

  void updateButtonColor(dynamic value) {
    buttonColor = value;
    notifyListeners();
  }

  void updateSmsCode(value) {
    smsCode = value;
    notifyListeners();
  }

  //TODO: name change to something more relevant
  void clearAll() {
    inputControllerLengthCheck = false;
    buttonColor = MaterialStateProperty.all<Color>(Colors.grey);

    smsCode = '';
    notifyListeners();
  }

//-------------------------------------

  // functions for add truck pages

  void updateTruckTypeValue(value) {
    truckTypeValue = value;
    notifyListeners();
  }

  void updatePassingWeightValue(value) {
    passingWeightValue = value;
    notifyListeners();
  }

  void updateTotalTyresValue(value) {
    totalTyresValue = value;
    notifyListeners();
  }

  void updateTruckLengthValue(value) {
    truckLengthValue = value;
    notifyListeners();
  }

  void updateDriverDetailsValue(value) {
    driverIdValue = value;
    notifyListeners();
  }

  void updateTruckNumberValue(value) {
    truckNumberValue = value;
    notifyListeners();
  }

  void updateTruckId(value) {
    truckId = value;
    notifyListeners();
  }

  void updateResetActive(bool value) {
    resetActive = value;
    notifyListeners();
  }

  void resetTruckFilters() {
    truckTypeValue = '';
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckLengthValue = 0;
    driverIdValue = '';
    notifyListeners();
  }

  void resetOnNewType() {
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckLengthValue = 0;
    driverIdValue = '';
    notifyListeners();
  }

  void resetTruckNumber() {
    truckNumberValue = '';
    notifyListeners();
  }

  void updateDriverList(value) {
    driverList = value;
    notifyListeners();
  }

//----------------------------------

}
