import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/BookingModel.dart';
import 'package:http/http.dart' as http;
import 'package:liveasy/models/onGoingCardModel.dart';

import 'loadOnGoingOrdersData.dart';

onGoingOrdersApiCall(int i) async {
  final String bookingApiUrl = dotenv.get('bookingApiUrl');
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();
  List<OngoingCardModel?> modelList = [];
  http.Response response = await http.get(Uri.parse(
      '$bookingApiUrl?transporterId=${transporterIdController.transporterId.value}&completed=false&cancel=false&pageNo=$i'));

  var jsonData = json.decode(response.body);
  for (var json in jsonData) {
    BookingModel bookingModel = new BookingModel();
    bookingModel.bookingDate =
        json['bookingDate'] != null ? json['bookingDate'] : 'NA';
    bookingModel.loadId = json['loadId'] != null ? json['loadId'] : 'NA';
    bookingModel.cancel = json['cancel'] != null ? json['cancel'] : false;
    bookingModel.completed =
        json['completed'] != null ? json['completed'] : false;
    bookingModel.completedDate =
        json['completedDate'] != null ? json['completedDate'] : 'NA';
    bookingModel.postLoadId =
        json['postLoadId'] != null ? json['postLoadId'] : 'NA';
    bookingModel.bookingId =
        json['bookingId'] != null ? json['bookingId'] : 'NA';
    bookingModel.rate = json['rate'] != null ? json['rate'].toString() : 'NA';
    bookingModel.unitValue =
        json['unitValue'] != null ? json['unitValue'] : 'NA';

    bookingModel.driverName =
        json['driverName'] != null ? json['driverName'] : 'NA';
    bookingModel.driverPhoneNum =
        json['driverPhoneNum'] != null ? json['driverPhoneNum'] : 'NA';
    bookingModel.transporterId =
        json['transporterId'] != null ? json['transporterId'] : 'NA';
    bookingModel.driverPhoneNum =
        json['driverPhoneNum'] != null ? json['driverPhoneNum'] : 'NA';
    bookingModel.loadingPointCity =
        json['loadingPointCity'] != null ? json['loadingPointCity'] : 'NA';
    bookingModel.unloadingPointCity =
        json['unloadingPointCity'] != null ? json['unloadingPointCity'] : 'NA';
    bookingModel.truckNo = json['truckNo'] != null ? json['truckNo'] : 'NA';
    bookingModel.deviceId = json['deviceId'] != null
        ? json['deviceId'] == 'NA'
            ? 80
            : int.parse(json["deviceId"])
        : 80;
    bookingModel.companyName =
        json['companyName'] != null ? json['companyName'] : 'NA';
    var loadAllDataModel = await loadAllOnGoingOrdersData(bookingModel);
    modelList.add(loadAllDataModel);
  }

  return modelList;
}
