import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/controller/transporterIdController.dart';

Future<String?> runTransporterApiPost(
    {required String mobileNum, String? userLocation}) async {
  try {
    TransporterIdController transporterIdController =
        Get.put(TransporterIdController(), permanent: true);

    final String transporterApiUrl =
        FlutterConfig.get("transporterApiUrl").toString();
    Map data = userLocation != null
        ? {"phoneNo": mobileNum, "transporterLocation": userLocation}
        : {"phoneNo": "8290748131"};
    String body = json.encode(data);
    final response = await http.post(Uri.parse(transporterApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.body);
    if (response.statusCode == 201) {

      var decodedResponse = json.decode(response.body);
      if (decodedResponse["transporterId"] != null) {
        String transporterId = decodedResponse["transporterId"];
        bool transporterApproved =
            decodedResponse["transporterApproved"].toString() == "true";
        bool companyApproved =
            decodedResponse["companyApproved"].toString() == "true";
        bool accountVerificationInProgress =
            decodedResponse["accountVerificationInProgress"].toString() ==
                "true";
        String transporterLocation = decodedResponse["transporterLocation"]== null
            ? " ": decodedResponse["transporterLocation"];
        String name = decodedResponse["transporterName"] == null
            ? " " :decodedResponse["transporterName"];
        String companyName = decodedResponse["companyName"] == null
            ? " " : decodedResponse["companyName"];
        transporterIdController.updateTransporterId(transporterId);
        transporterIdController.updateTransporterApproved(transporterApproved);
        transporterIdController.updateCompanyApproved(companyApproved);
        transporterIdController.updateMobileNum(mobileNum);
        transporterIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress);
        transporterIdController.updateTransporterLocation(transporterLocation);
        transporterIdController.updateName(name);
        transporterIdController.updateCompanyName(companyName);
        return transporterId;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
