import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class DateTimePicker extends StatefulWidget {
  Function SelectedDate;

  String DateFormat;

  int FirstDate;
  int LastDate;

  DateTimePicker(
      {this.SelectedDate,
      this.FirstDate = 2020,
      this.LastDate = 2090,
      this.DateFormat = "yyyy/MM/dd HH:mm"});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime SelectedTime = DateTime.now();

  Future<Void> _openDatePicker(BuildContext context) async {
    SelectedTime = await showDatePicker(
      context: context,
      initialDate: SelectedTime,
      firstDate: new DateTime(SelectedTime.year),
      lastDate: new DateTime(widget.LastDate),
    );

    if (SelectedTime != null)
      setState(() {
        widget.SelectedDate(SelectedTime);
      });
    else
      SelectedTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          DateFormat(widget.DateFormat).format(SelectedTime).toString(),
          style: TextStyle(fontSize: ArgonSize.Header3, color: ArgonColors.text),
        ),
        IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              await _openDatePicker(context);
            })
      ],
    );
  }
}
