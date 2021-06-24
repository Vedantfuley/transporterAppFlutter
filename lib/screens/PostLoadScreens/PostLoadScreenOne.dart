import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/PostLoadScreens/PostLoadScreenTwo.dart';
import 'package:liveasy/widgets/AddCalender.dart';
import 'package:liveasy/widgets/addPostLoadHeader.dart';
import 'package:liveasy/widgets/addTruckSubtitleText.dart';
import 'package:liveasy/widgets/addressInputWidget.dart';
import 'package:liveasy/widgets/buttons/NextButton.dart';
import 'package:liveasy/widgets/loadingPointImageIcon.dart';
import 'package:liveasy/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:get/get.dart';

class PostLoadScreenOne extends StatefulWidget {
  const PostLoadScreenOne({Key? key}) : super(key: key);

  @override
  _PostLoadScreenOneState createState() => _PostLoadScreenOneState();
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
Jiffy initialDay = Jiffy(DateTime.now());
Jiffy secondDay = Jiffy(DateTime.now()).add(days: 1);
Jiffy thirdDay = Jiffy(DateTime.now()).add(days: 2);
Jiffy fourthDay = Jiffy(DateTime.now()).add(days: 3);

class _PostLoadScreenOneState extends State<PostLoadScreenOne> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate:
            DateTime(DateTime.now().year, DateTime.now().month, 30, 0, 0));
    Jiffy nextDay = Jiffy(picked);

    if (picked != null && picked != selectedDate)
      setState(() {
        bookingDateList[3] = (nextDay.MMMEd);
      });
  }

  List bookingDateList = [
    initialDay.MMMEd,
    secondDay.MMMEd,
    thirdDay.MMMEd,
    fourthDay.MMMEd
  ];
  bool i = false;
  var changedDate = fourthDay.MMMEd;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    if (!i) {
      providerData.updateBookingDate(initialDay.MMMEd);
      i = true;
    }

    if (providerData.loadingPointCityPostLoad != "") {
      controller1 = TextEditingController(
          text:
              ("${providerData.loadingPointCityPostLoad} (${providerData.loadingPointStatePostLoad})"));
    } else {
      controller1 = TextEditingController(text: (""));
    }
    if (providerData.unloadingPointCityPostLoad != "") {
      controller2 = TextEditingController(
          text:
              ("${providerData.unloadingPointCityPostLoad} (${providerData.unloadingPointStatePostLoad})"));
    } else {
      controller2 = TextEditingController(text: (""));
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  space_2,
                  space_4,
                  space_2,
                  space_0,
                ),
                child: AddPostLoadHeader(
                  reset: true,
                  resetFunction: () {
                    providerData.resetPostLoadScreenOne();
                  },
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(space_4, space_2, space_4, space_0),
                height: MediaQuery.of(context).size.height,
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddTruckSubtitleText(text: "Location Details"),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(size_2, size_5, size_10, size_2),
                      child: AddressInputWidget(
                          hintText: "Loading point",
                          icon: LoadingPointImageIcon(
                            height: size_6,
                            width: size_6,
                          ),
                          controller: controller1,
                          onTap: () {
                            setState(() {
                              providerData.updateResetActive(true);
                              print(providerData.resetActive);
                            });
                          }),
                    ),
                    SizedBox(height: size_5),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(size_2, size_5, size_10, size_2),
                      child: AddressInputWidget(
                        hintText: "Unloading point",
                        icon: UnloadingPointImageIcon(
                          height: size_6,
                          width: size_6,
                        ),
                        controller: controller2,
                        onTap: () {
                          providerData.updateResetActive(true);
                        },
                      ),
                    ),
                    SizedBox(height: space_3),
                    AddTruckSubtitleText(text: "Booking Date"),
                    GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: EdgeInsets.all(10.0),
                      crossAxisCount: 2,
                      children: bookingDateList
                          .map((e) => AddCalender(value: e, text: e))
                          .toList(),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    // ignore: deprecated_member_use
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: space_8,
                        child: ElevatedButton(
                          onPressed: () async {
                            _selectDate(context);
                          },
                          style: ButtonStyle(backgroundColor: calendarColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Set date',
                                style: TextStyle(
                                    color: black,
                                    fontSize: size_7,
                                    fontWeight: normalWeight),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: black,
                                size: size_9,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    nextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
