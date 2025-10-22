import 'package:bvt_tech/components/input_field.dart';
import 'package:bvt_tech/components/scaling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StrikeRateCalculator extends StatefulWidget {
  const StrikeRateCalculator({super.key});

  @override
  State<StrikeRateCalculator> createState() => _StrikeRateCalculatorState();
}

class _StrikeRateCalculatorState extends State<StrikeRateCalculator> {
  final TextEditingController _runsController = TextEditingController();
  final TextEditingController _ballsController = TextEditingController();

  String displayMessage = 'Start typing...';
  Color displayMessageColor = Color.fromARGB(255, 71, 71, 71);

  String? resultRate;
  String? resultMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _runsController.dispose();
    _ballsController.dispose();
    super.dispose();
  }

  void calculateStrikeRate() {
    resultRate = null;
    resultMessage = null;

    String runsText = _runsController.text.trim();
    String ballsText = _ballsController.text.trim();

    if (runsText.isEmpty || ballsText.isEmpty) {
      showError('Fields cannot be empty');
      return;
    }

    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(runsText) || !numericRegex.hasMatch(ballsText)) {
      showError('Only numeric values are allowed');
      return;
    }

    int runs = int.parse(runsText);
    int balls = int.parse(ballsText);

    if (runs < 0) {
      showError('Runs cannot be negative');
      return;
    }
    if (balls <= 0) {
      showError('Balls must be at least 1');
      return;
    }

    double strikeRate = (runs / balls) * 100;
    String strikeMessage = strikeRate < 80
        ? 'Need to improve rotation of strike.'
        : (strikeRate > 80 && strikeRate < 120)
        ? 'Good balance of attack.'
        : 'Excellent aggressive play!';

    setState(() {
      resultRate = strikeRate.toStringAsFixed(2);
      resultMessage = strikeMessage;
    });
  }

  void showError(String message) {
    setState(() {
      displayMessage = message;
      displayMessageColor = Color.fromARGB(255, 184, 70, 70);
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        displayMessage = 'Start typing...';
        displayMessageColor = Color.fromARGB(255, 71, 71, 71);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Strike Rate Calculator',
          style: TextStyle(fontSize: 28.sp),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Enter the details to obtain the strike rate of a player (only integer values allowed).',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: Color.fromARGB(255, 71, 71, 71),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              displayMessage,
              style: TextStyle(fontSize: 24.sp, color: displayMessageColor),
            ),
            SizedBox(height: 20.h),
            InputField(
              controller: _runsController,
              hintText: 'Enter number of runs here',
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.h),
            InputField(
              controller: _ballsController,
              hintText: 'Enter number of balls here',
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20.h),
            ScalingButton(
              onTap: calculateStrikeRate,
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color.fromARGB(255, 3, 196, 103),
                ),
                child: Center(
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 234),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              resultRate != null ? 'Strike Rate: $resultRate' : '',
              style: TextStyle(
                fontSize: 24.sp,
                color: Color.fromARGB(255, 71, 71, 71),
              ),
            ),
            Text(
              resultMessage != null ? 'Message: $resultMessage' : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                color: Color.fromARGB(255, 71, 71, 71),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
