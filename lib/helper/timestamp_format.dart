// return a foramted date in as string

import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp timestamp) {
  // we retrieve time from firebase
  DateTime dateTime = timestamp.toDate();

  // for year
  String year = dateTime.year.toString();
  // for month
  String month = dateTime.month.toString();

  // for day
  String day = dateTime.day.toString();

  // store year month day in final dateformat
  String finalDate = '$day/$month/$year';

  return finalDate;
}
