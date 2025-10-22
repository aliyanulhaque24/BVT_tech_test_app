import 'package:bvt_tech/components/input_field.dart';
import 'package:bvt_tech/components/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// this is a custom class which will be handy in displaying the results
class Match {
  final String team1;
  final String team2;
  final String ground;
  final DateTime datetime;
  bool isReminder;

  Match({
    required this.team1,
    required this.team2,
    required this.ground,
    required this.datetime,
    this.isReminder = false,
  });
}

class MatchScheduleCard extends StatefulWidget {
  const MatchScheduleCard({super.key});

  @override
  State<MatchScheduleCard> createState() => _MatchScheduleCardState();
}

class _MatchScheduleCardState extends State<MatchScheduleCard> {
  // declaring controllers, names and other requirements for the page

  List<Match> matches = [];
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final TextEditingController _groundController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  void initState() {
    super.initState();
  }

  // this is the function which adds the match card. it includes the validation checks

  void addCard() {
    String team1 = _team1Controller.text.trim();
    String team2 = _team2Controller.text.trim();
    String ground = _groundController.text.trim();
    if (team1.isNotEmpty && team2.isNotEmpty && ground.isNotEmpty) {
      setState(() {
        matches.add(
          Match(
            team1: _team1Controller.text.trim(),
            team2: _team2Controller.text.trim(),
            ground: _groundController.text.trim(),
            datetime: selectedDateTime,
          ),
        );

        _team1Controller.clear();
        _team2Controller.clear();
        _groundController.clear();
        selectedDateTime = DateTime.now();
      });
    } else {
      // the dialog will be shown in case the user doesnt enter any required values
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Missing values"),
            content: Text("You need to fill all three fields."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // app skeleton
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Match Schedule Card', style: TextStyle(fontSize: 28.sp)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            // this first column holds the input elements and action buttons.
            Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _team1Controller,
                        hintText: 'Team 1',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: InputField(
                        controller: _team2Controller,
                        hintText: 'Team 2',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // date selector
                ScalingButton(
                  onTap: changeDateTime,
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 220, 220, 220),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat(
                          'MMM dd, yyyy - hh:mm a',
                        ).format(selectedDateTime),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Color.fromARGB(255, 71, 71, 71),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InputField(
                  controller: _groundController,
                  hintText: 'Enter ground name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20.h),
                ScalingButton(
                  onTap: addCard,
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color.fromARGB(255, 3, 196, 103),
                    ),
                    child: Center(
                      child: Text(
                        'Add Match Card',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ScalingButton(
                  onTap: () {
                    matches.clear();
                    setState(() {});
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color.fromARGB(255, 184, 70, 70),
                    ),
                    child: Center(
                      child: Text(
                        'Clear list',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
            // this second part displays the match cards in a scrollable list view
            Expanded(
              child: ListView.separated(
                itemCount: matches.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Container(
                    height: 220.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 196, 103),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  match.team1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 234, 234, 234),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'V/S',
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Color.fromARGB(255, 234, 234, 234),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  match.team2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 234, 234, 234),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'on ${DateFormat('MMM dd, yyyy - hh:mm a').format(match.datetime)}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Color.fromARGB(255, 234, 234, 234),
                          ),
                        ),
                        Text(
                          'at ${match.ground}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Color.fromARGB(255, 234, 234, 234),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: ScalingButton(
                            onTap: () {
                              setState(() {
                                match.isReminder = !match.isReminder;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color.fromARGB(255, 199, 212, 12),
                              ),
                              child: Center(
                                child: Text(
                                  match.isReminder
                                      ? 'Remove Reminder'
                                      : 'Set Reminder',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 234, 234, 234),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // this is the function which lets the user change the date and time of the scheduled match. the date can not be in the past

  Future changeDateTime() async {
    DateTime? date = await changeDate();
    if (date == null) return;

    TimeOfDay? time = await changeTime();
    if (time == null) return;

    final selectedDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => selectedDateTime = selectedDate);
  }

  Future<DateTime?> changeDate() => showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    initialDate: selectedDateTime,
  );

  Future<TimeOfDay?> changeTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(
      hour: selectedDateTime.hour,
      minute: selectedDateTime.minute,
    ),
  );
}
