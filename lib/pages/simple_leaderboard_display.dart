import 'package:bvt_tech/components/input_field.dart';
import 'package:bvt_tech/components/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleLeaderboardDisplay extends StatefulWidget {
  const SimpleLeaderboardDisplay({super.key});

  @override
  State<SimpleLeaderboardDisplay> createState() =>
      _SimpleLeaderboardDisplayState();
}

class _SimpleLeaderboardDisplayState extends State<SimpleLeaderboardDisplay> {
  // declaring controllers, names and other requirements for the page

  List<Map<String, dynamic>> players = []; // this list stores the players

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _runsController = TextEditingController();
  String displayMessage = 'Add a player';
  Color displayMessageColor = Color.fromARGB(255, 71, 71, 71);

  // this is the function which adds the player. it includes the validation checks

  void addPlayer() {
    String runsText = _runsController.text.trim();
    String nameText = _nameController.text.trim();

    if (nameText.isEmpty || runsText.isEmpty) {
      showError('Fields can not be empty');
      return;
    }

    if (nameText.length > 20) {
      showError('Name max 20 characters');
      return;
    }

    final nameRegex = RegExp(r'^[A-Za-z ]+$');
    if (!nameRegex.hasMatch(nameText)) {
      showError('Name cannot be non alpabetical');
      return;
    }

    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(runsText)) {
      showError('Runs must be numeric');
      return;
    }

    int runs = int.parse(runsText);
    if (runs < 0) {
      showError('Runs cannot be negative');
      return;
    }

    setState(() {
      players.add({'name': nameText, 'runs': runs});
      players.sort((a, b) => b['runs'].compareTo(a['runs']));
      _nameController.clear();
      _runsController.clear();
    });

    showSuccess('Player added successfully');
  }

  // error diplaying message function

  void showError(String message) {
    setState(() {
      displayMessage = message;
      displayMessageColor = Color.fromARGB(255, 184, 70, 70);
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        displayMessage = 'Add a player';
        displayMessageColor = Color.fromARGB(255, 71, 71, 71);
      });
    });
  }

  // success diplaying message function

  void showSuccess(String message) {
    setState(() {
      displayMessage = message;
      displayMessageColor = const Color.fromARGB(255, 3, 196, 103);
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        displayMessage = 'Add a player';
        displayMessageColor = Color.fromARGB(255, 71, 71, 71);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // this is the app skeleton
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Leaderboard Display',
          style: TextStyle(fontSize: 28.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // this is the leaderboard which will display the results
              Container(
                height: 300.h,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 3, 196, 103),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 234, 234, 234),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 234, 234),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: players.isEmpty
                            ? Center(
                                child: Text(
                                  'No players yet',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: const Color.fromARGB(
                                      255,
                                      71,
                                      71,
                                      71,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                // this list builder is used to display the leaderboard
                                itemCount: players.length,
                                itemBuilder: (context, index) {
                                  final player = players[index];
                                  final rankColor = index == 0
                                      ? Color.fromARGB(255, 228, 191, 30)
                                      : index == 1
                                      ? Color.fromARGB(255, 113, 113, 113)
                                      : index == 2
                                      ? Color.fromARGB(255, 136, 93, 1)
                                      : Color.fromARGB(255, 204, 204, 204);

                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5.h,
                                      horizontal: 5.w,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: rankColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: Colors.black.withAlpha(40),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            '${index + 1}. ${player['name']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                255,
                                                234,
                                                234,
                                                234,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${player['runs']} runs',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: const Color.fromARGB(
                                                  255,
                                                  234,
                                                  234,
                                                  234,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              // display message
              Text(
                displayMessage,
                style: TextStyle(fontSize: 20.sp, color: displayMessageColor),
              ),
              SizedBox(height: 20.h),
              // input fields
              InputField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                hintText: 'Enter Name here',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20.h),
              InputField(
                controller: _runsController,
                textInputAction: TextInputAction.done,
                hintText: 'Enter Runs here',
              ),
              SizedBox(height: 20.h),
              // action buttons
              ScalingButton(
                onTap: addPlayer,
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color.fromARGB(255, 3, 196, 103),
                  ),
                  child: Center(
                    child: Text(
                      'Add Player',
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
                  players.clear();
                  _nameController.clear();
                  _runsController.clear();
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
                      'Clear leaderboard',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 234, 234, 234),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
