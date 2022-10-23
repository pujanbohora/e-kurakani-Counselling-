import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class _CounsellorCallReportPageState extends State<CounsellorCallReportPage> {
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'How was your experience?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset("assets/images/LOGO.png"),
      submitButtonText: 'Submit',
      commentHint: 'Give us your feedback.',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: _showRatingDialog,
            child: const Text('Show Rating Dialog'),
          ),
        ),
      ),
    );
  }
}

class CounsellorCallReportPage extends StatefulWidget {
  const CounsellorCallReportPage();

  @override
  _CounsellorCallReportPageState createState() =>
      new _CounsellorCallReportPageState();
}
