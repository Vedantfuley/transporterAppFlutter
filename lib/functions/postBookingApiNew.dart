import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/models/loadDetailsScreenModel.dart';

postBookingApiNew(LoadDetailsScreenModel? loadDetailsScreenModel, truckId,
    deviceId, driverName, driverPhoneNo) async {
  TransporterIdController tIdController = Get.find<TransporterIdController>();
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  var jsonData;
  try {
    Map datanew = {
      "transporterId": tIdController.transporterId.toString(),
      "loadId": loadDetailsScreenModel!.loadId,
      "postLoadId": loadDetailsScreenModel.postLoadId,
      "loadingPointCity": loadDetailsScreenModel.loadingPointCity,
      "unloadingPointCity": loadDetailsScreenModel.unloadingPointCity,
      "truckNo": truckId,
      "driverName": driverName,
      "driverPhoneNum": driverPhoneNo,
      "deviceId": deviceId,
      "rate": null,
      "unitValue": null,
      "truckId": [truckId],
      "cancel": false,
      "completed": false,
      "bookingDate": now,
      "completedDate": null,
      "timestamp": now,
      //companyName is added in the body section of post booking Apis
      "companyName": loadDetailsScreenModel.companyName,
    };
    String body = json.encode(datanew);
    final String bookingApiUrl = dotenv.get('bookingApiUrl').toString();
    final response = await http.post(Uri.parse("$bookingApiUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.body);
    jsonData = json.decode(response.body);
    if (response.statusCode == 201) {
      return "successful";
    } else if (response.statusCode == 409) {
      return "conflict";
    } else {
      return "unsuccessful";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
