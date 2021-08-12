import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../SystemImports.dart';

class DateTimePicker extends StatefulWidget {
  Function SelectedDate;
  Function SelecteTimeFunction;

  String DateFormat;
  int dateChoices;
  /// 1 : DATE ONLY
  /// 2 : TIME ONLY
  /// 3 : DATE AND TIME


  int FirstDate;
  int LastDate;


  DateTimePicker(
      {
        this.dateChoices= 1 ,
        this.SelectedDate,
        this.SelecteTimeFunction,
        this.FirstDate = 2020,
        this.LastDate = 2090,
        this.DateFormat = "yyyy/MM/dd HH:mm"});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime SelectedDate1 = DateTime.now();
  TimeOfDay SelectedTime = TimeOfDay(hour: 9, minute: 0);
  DateTime dateTime=  DateTime.now();
  int year  = 2000;
  int month  = 1;
  int day = 1 ;
  int hour = 10 ;
  int minute = 30;

  /// SELECT DATE
  Future<Void> _openDatePicker(
      BuildContext context, PersonalProvider PersonalCase) async {
    SelectedDate1 = await showDatePicker(
      context: context,
      initialDate: SelectedDate1,
      firstDate: new DateTime(SelectedDate1.year),
      lastDate: new DateTime(widget.LastDate),
      helpText: PersonalCase.GetLable(ResourceKey.ChooseTheDate),
      cancelText: PersonalCase.GetLable(ResourceKey.Close),
      confirmText: PersonalCase.GetLable(ResourceKey.Okay),
    );

  }

  /// SELECT TIME
  Future<Void> _openTimePicker(
      BuildContext context, PersonalProvider PersonalCase) async {
    SelectedTime = await showTimePicker(
      context: context,
        initialTime:  TimeOfDay(hour: 9, minute: 0),
      helpText: PersonalCase.GetLable(ResourceKey.ChooseTheTime),
      // Can be used as title
      cancelText: PersonalCase.GetLable(ResourceKey.Close),
      confirmText: PersonalCase.GetLable(ResourceKey.Okay),
    );


  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return InkWell(
      onTap: () async {
        await _openDatePicker(context, PersonalCase);

        await _openTimePicker(context, PersonalCase);



        switch(widget.dateChoices )
        {
          case   1:
         {
           await _openDatePicker(context, PersonalCase);
         }
         break;

          case   2:
           {
             await _openTimePicker(context, PersonalCase);
           }
           break;
          case   3:
            {
              await _openDatePicker(context, PersonalCase);

              await _openTimePicker(context, PersonalCase);
            }
            break;
          default: {
            //statements;
          }
        }


        setState(() {

          year  = SelectedDate1.year;
          month = SelectedDate1.month;
          day   = SelectedDate1.day;
          hour  = SelectedTime.hour;
          minute   = SelectedTime.minute;

        });
        // if (SelectedDate != null && SelectedTime !=null)
        //   setState(() {
        //     widget.SelectedDateFunction(SelectedDate,SelectedTime);
        //   });
        // else
        //   SelectedDate = DateTime.now();
        //
        //
        // if (SelectedTime != null)
        //   setState(() {
        //     widget.SelecteTimeFunction(SelectedTime);
        //   });
        // else
        //   SelectedTime = DateTime.now();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
           // DateFormat(widget.DateFormat).format(SelectedDate).toString(),
      '${  year.toString() } / ' '${  month.toString() } / ' '${  day.toString() } -' '${  hour.toString() } : ' '${  minute.toString() }  ',
        style:
            TextStyle(fontSize: ArgonSize.Header3, color: ArgonColors.text),
          ),
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                //await _openDatePicker(context);
              })
        ],
      ),
    );
  }
}

class DateAndTimePicker extends StatefulWidget {
  Function SelectedDate;

  String DateFormat;

  int FirstDate;
  int LastDate;
  int Hour;
  int Minute;

  DateAndTimePicker(
      {this.SelectedDate,
        this.FirstDate = 2020,
        this.LastDate = 2090,
        this.DateFormat = "yyyy/MM/dd HH:mm"});

  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  DateTime SelectedDate = DateTime.now();
  TimeOfDay SelectedTime;

  Future<Void> _openDateAndTimePicker(
      BuildContext context, PersonalProvider PersonalCase) async {
    SelectedDate = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: new DateTime(SelectedDate.year),
      lastDate: new DateTime(widget.LastDate),
      helpText: PersonalCase.GetLable(ResourceKey.ChooseTheDate),
      // Can be used as title
      cancelText: PersonalCase.GetLable(ResourceKey.Close),
      confirmText: PersonalCase.GetLable(ResourceKey.Okay),
    );
    SelectedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 10, minute: 30));
    if (SelectedTime != null)
      setState(() {
        widget.SelectedDate(SelectedDate);
        print('${SelectedTime.hour}' '${SelectedTime.minute}');
      });
    else
      SelectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return InkWell(
      onTap: () async {
        await _openDateAndTimePicker(context, PersonalCase);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            DateFormat(widget.DateFormat).format(SelectedDate).toString(),
            style:
            TextStyle(fontSize: ArgonSize.Header3, color: ArgonColors.text),
          ),
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                //await _openDatePicker(context);
              })
        ],
      ),
    );
  }
}
enum  DateChoices{date,time , dateAndTime }