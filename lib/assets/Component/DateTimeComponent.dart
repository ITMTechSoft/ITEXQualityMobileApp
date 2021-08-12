import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class DateTimePicker extends StatefulWidget {
  Function SelectedDate;

  String DateFormat;

  int FirstDate;
  int LastDate;

  DateMode dateMode       =   DateMode.normal;
  DateChoices dateChoices = DateChoices.date ;





  DateTimePicker({this.SelectedDate,
    this.FirstDate = 2020,
    this.LastDate = 2090,
    this.DateFormat ,
    this.dateMode = DateMode.normal ,
    this.dateChoices = DateChoices.date});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime SelectedDate = DateTime.now();
  TimeOfDay SelectedTime = TimeOfDay(hour: 10, minute: 30);

   getInitialFormat({DateChoices dateChoices=DateChoices.time}){
    switch(dateChoices){
      case DateChoices.date :{
       widget.DateFormat = "yyyy/MM/dd";
      }
      break;
      case DateChoices.time :{
        widget.DateFormat = "HH:mm";
      }
      break ;

      case DateChoices.dateAndTime :{
        widget.DateFormat = "yyyy/MM/dd HH:mm";
      }
      break ;

    }


  }

  getDate() async {



    switch(widget.dateMode)
    {
    /// CHOOSE NORMAL DATE
      case DateMode.normal : {
        switch (widget.dateChoices) {
          case DateChoices.date :
            {
              await _openDatePicker(context);
              widget.DateFormat = "yyyy/MM/dd";
            }
            break;
          case DateChoices.time :
            {
              await _openTimePicker(context);
              widget.DateFormat = "HH:mm";
            }
            break;
          case DateChoices.dateAndTime :
            {
              await _openDatePicker(context);
              await _openTimePicker(context);
              widget.DateFormat = "yyyy/MM/dd HH:mm";
            }
            break;
        }
      }
      break ;
    /// CHOOSE CUPERTINO DATE
      case DateMode.cupertino :{
        switch (widget.dateChoices) {
          case DateChoices.date :
            {
              _openCupertinoDate(context);
              widget.DateFormat = "yyyy/MM/dd";
            }
            break;
          case DateChoices.time :
            {
              _openCupertinoTime(context);
              widget.DateFormat = "HH:mm";
            }
            break;
          case DateChoices.dateAndTime :
            {


              _openCupertinoTime(context);
              _openCupertinoDate(context);



            //  _openCupertinoDateAndTime(context)  ;
              widget.DateFormat = "yyyy/MM/dd HH:mm";
            }
            break;
        }
      }
      break ;
    }


  }



  /// CHOOSE DATE
  Future<Void> _openDatePicker(BuildContext context) async {
    SelectedDate = await showDatePicker(
      context: context,
      initialDate: SelectedDate??DateTime.now(),
      firstDate: new DateTime(SelectedDate.year),
      lastDate: new DateTime(widget.LastDate),
    );

    if (SelectedDate != null)
      setState(() {
        //  widget.SelectedDate(SelectedTime);

      });
    else
      SelectedDate = DateTime.now();
  }

  /// CHOOSE TIME
  Future<Void> _openTimePicker(BuildContext context) async {
    SelectedTime = await showTimePicker(
        context: context,
        initialTime: SelectedTime??TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
    );


    if (SelectedTime != null)
      setState(() {
        //  widget.SelectedDate(SelectedTime);
        SelectedDate = DateTime(
            SelectedDate.year, SelectedDate.month, SelectedDate.day,
            SelectedTime.hour, SelectedTime.minute);
      });
    else
      SelectedTime = SelectedTime;
  }

  /// CHOOSE DATE

  void _openCupertinoDate(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,

                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        SelectedDate = DateTime(
                            val.year, val.month, val.day,
                            SelectedTime.hour, SelectedTime.minute);
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
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,

                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        SelectedDate = DateTime(
                            SelectedDate.year, SelectedDate.month, SelectedDate.day,
                            val.hour, val.minute);                            // DateTime(
                            // val.year, val.month, val.day,
                            // val.hour, val.minute);
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


  void _openCupertinoDateAndTime(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,

                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        SelectedDate = val;
                        // DateTime(
                        // val.year, val.month, val.day,
                        // val.hour, val.minute);
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

    return InkWell(
      onTap: () async {
        getDate();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            DateFormat(widget.DateFormat).format(SelectedDate).toString(),
            // '${SelectedDate.year}/'   '${SelectedDate.month}/'   '${SelectedDate.day}/ - '   '${SelectedTime.hour}:' '${SelectedTime.minute}/',
            style: TextStyle(
                fontSize: ArgonSize.Header3, color: ArgonColors.text),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
          )
        ],
      ),
    );
  }
}


enum DateMode {
  normal , cupertino
}

enum DateChoices {
 date , time , dateAndTime
}