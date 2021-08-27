import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class DateTimePicker extends StatefulWidget {
  Function SelectedDateFunction;
  String DateFormat;
  int FirstDate;
  int LastDate;
  DateTime?  SelectedDate  = DateTime.now() ;

  /// TYPE OF DATE PICKER , CUPERTINO OR NORMAL
  DateMode dateMode = DateMode.normal;
  /// TIME , DATE , TIME AND DATE
  DateChoices dateChoices = DateChoices.date;

  DateTimePicker(
      {required this.SelectedDateFunction,
        this.FirstDate   = 2020,
        this.LastDate    = 2090,
        this.DateFormat  = '',
        this.dateMode    = DateMode.normal,
        this.dateChoices = DateChoices.date,
        required this.SelectedDate});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime  SelectedDate = DateTime.now();
  TimeOfDay? SelectedTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);



  getInitialFormat({DateChoices dateChoices = DateChoices.time}) {
    switch (dateChoices) {
      case DateChoices.date:
        {
          widget.DateFormat = "yyyy/MM/dd";
        }
        break;
      case DateChoices.time:
        {
          widget.DateFormat = "HH:mm";
        }
        break;

      case DateChoices.dateAndTime:
        {
          widget.DateFormat = "yyyy/MM/dd HH:mm";
        }
        break;
    }
  }

  getDate() async {
    switch (widget.dateMode) {

    /// CHOOSE NORMAL DATE
      case DateMode.normal:
        {
          switch (widget.dateChoices) {
            case DateChoices.date:
              {
                print('inside the function ') ;
                await _openDatePicker(context);
                print('after the function') ;
                widget.DateFormat = "yyyy/MM/dd";
              }
              break;
            case DateChoices.time:
              {
                await _openTimePicker(context);
                widget.DateFormat = "HH:mm";
              }
              break;
            case DateChoices.dateAndTime:
              {
                await _openDatePicker(context);
                await _openTimePicker(context);
                widget.DateFormat = "yyyy/MM/dd HH:mm";
              }
              break;
          }
        }
        break;

    /// CHOOSE CUPERTINO DATE
      case DateMode.cupertino:
        {
          switch (widget.dateChoices) {
            case DateChoices.date:
              {
                _openCupertinoDate(context);
                widget.DateFormat = "yyyy/MM/dd";
              }
              break;
            case DateChoices.time:
              {
                _openCupertinoTime(context);
                widget.DateFormat = "HH:mm";
              }
              break;
            case DateChoices.dateAndTime:
              {
                _openCupertinoTime(context);
                _openCupertinoDate(context);

                //  _openCupertinoDateAndTime(context)  ;
                widget.DateFormat = "yyyy/MM/dd HH:mm";
              }
              break;
          }
        }
        break;
    }
  }

  /// CHOOSE DATE
  Future<Void?> _openDatePicker(BuildContext context) async {
    widget.SelectedDate = (await showDatePicker(
      context: context,
      initialDate: widget.SelectedDate ?? DateTime.now(),
      firstDate: new DateTime(DateTime.now().year),
      lastDate:  new DateTime(widget.LastDate),
    ))??DateTime.now();

    if (widget.SelectedDate != null) {

      setState(() {

        widget.SelectedDateFunction(widget.SelectedDate);
      });
    }
    else
      {
        widget.SelectedDate = DateTime.now();

      }

  }

  /// CHOOSE TIME
  Future<Void?> _openTimePicker(BuildContext context) async {
    SelectedTime = await showTimePicker(
        context: context,
        initialTime: SelectedTime ??
            TimeOfDay(
                hour: DateTime.now().hour, minute: DateTime.now().minute));

    if (SelectedTime != null)
      setState(() {
        //  widget.SelectedDate(SelectedTime);
        widget.SelectedDate = DateTime(widget.SelectedDate!.year, widget.SelectedDate!.month,
            widget.SelectedDate!.day, SelectedTime!.hour, SelectedTime!.minute);
        widget.SelectedDateFunction(widget.SelectedDate);
      });
    else
      SelectedTime =  TimeOfDay(
          hour: DateTime.now().hour, minute: DateTime.now().minute);

  }

  /// CUPERTINO
  /// CHOOSE DATE

  void _openCupertinoDate(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: getScreenHeight()*0.6,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: getScreenHeight()*0.5,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        widget.SelectedDate = DateTime(
                            val.year,
                            val.month,
                            val.day,
                            SelectedTime!.hour,
                            SelectedTime!.minute);

                        widget.SelectedDateFunction(widget.SelectedDate);
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));
  }

  /// CHOOSE TIME

  void _openCupertinoTime(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: getScreenHeight()*0.6,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: getScreenHeight()*0.5,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        widget.SelectedDate = DateTime(
                            widget.SelectedDate!.year,
                            widget.SelectedDate!.month,
                            widget. SelectedDate!.day,
                            val.hour,
                            val.minute);

                        widget.SelectedDateFunction(widget.SelectedDate);
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getInitialFormat(dateChoices: widget.dateChoices);
  }

  @override
  Widget build(BuildContext context) {
    getInitialFormat(dateChoices: widget.dateChoices);
    widget.SelectedDate==null?DateTime.now():widget.SelectedDate;
    return InkWell(
      onTap: () async {
        getDate();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            DateFormat(widget.DateFormat).format(widget.SelectedDate!).toString(),
            // '${SelectedDate.year}/'   '${SelectedDate.month}/'   '${SelectedDate.day}/ - '   '${SelectedTime.hour}:' '${SelectedTime.minute}/',
            style:
            TextStyle(fontSize: ArgonSize.Header3, color: ArgonColors.text),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed:(){}
          )
        ],
      ),
    );
  }
}

enum DateMode { normal, cupertino }

enum DateChoices { date, time, dateAndTime }
