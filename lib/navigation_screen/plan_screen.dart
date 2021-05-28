import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class PlanScreen extends StatefulWidget {
  static const String id = 'plan_screen';

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left
                ),
              ),
            title: Text(
              'Rencana',
              style: TextStyle(
                color: Colors.grey[100]
              )
            ),
            backgroundColor: Colors.grey[900],
            bottom: TabBar(
              indicatorColor: Colors.grey[500],
              tabs: [
                Tab(child: Text('Monthly Schedule')),
                Tab(child: Text('Weekly Agenda'))
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SfCalendar(
                view: CalendarView.month,
                backgroundColor: Colors.grey[900],
                // startdate
                headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[100],
                    fontWeight: FontWeight.bold
                  )
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                todayHighlightColor: Colors.grey[100],
                todayTextStyle: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
                monthViewSettings: MonthViewSettings(
                  monthCellStyle: MonthCellStyle(
                    textStyle: TextStyle(
                      color: Colors.grey[900]
                    ),
                    leadingDatesTextStyle: TextStyle(
                      color: Colors.grey[900]
                    ),
                    trailingDatesTextStyle: TextStyle(
                      color: Colors.grey[900]
                    ),
                    backgroundColor: Colors.grey[500],
                    // background color dynamic heatmap
                    todayBackgroundColor: Colors.grey[500],
                    leadingDatesBackgroundColor: Colors.grey[700],
                    trailingDatesBackgroundColor: Colors.grey[700],
                    )
                  )
                ),
              SfCalendar(
                // hide empty weeks
                view: CalendarView.schedule,
                backgroundColor: Colors.grey[900],
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  backgroundColor: Colors.grey[800],
                ),
                todayHighlightColor: Colors.grey[100],
                todayTextStyle: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold
                ),
                scheduleViewSettings: ScheduleViewSettings(
                  weekHeaderSettings: WeekHeaderSettings(
                    weekTextStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14.0
                    )
                  ),
                  monthHeaderSettings: MonthHeaderSettings(
                    height: 60.0,
                    textAlign: TextAlign.center,
                    monthTextStyle: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                    backgroundColor: Colors.grey[700]
                  )
                ),
              )
            ],
          ),
          floatingActionButton: PlanFAB(),
        ),
      )
    );
  }
}

// Color GetMonthCellBackgroundColor {
//   final int kesibukan = 2;
//   switch (kesibukan) {
//     case 0:
//       return Colors.grey[500];
//       break;
//     case 1:
//       return Colors.grey[400];
//       break;
//     case 2:
//       return Colors.grey[300];
//       break;
//     case 3:
//       return Colors.grey[200];
//       break;
//     case 4:
//       return Colors.grey[100];
//       break;
//     default:
//       return Colors.grey[100];
//   }
// }

class PlanFAB extends StatefulWidget {

  @override
  _PlanFABState createState() => _PlanFABState();
}

class _PlanFABState extends State<PlanFAB> {
  DateTime _date;
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.event),
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.grey[100],
      onPressed: () { 
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Colors.grey[500],
                  scrollable: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text(
                        'Plan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.close_rounded, 
                          color: Colors.grey[900]
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),   
                    ]
                  ),
                  content: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            maxLength: 20,
                            maxLines: 1,
                            cursorColor: Colors.grey[700],
                            decoration: InputDecoration(
                              labelText: 'Aktivitas',
                              labelStyle: TextStyle(
                                color: Colors.grey[700]
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[700]
                                )
                              )
                            ),
                          ),
                          Row(
                            children: <Widget> [
                              OutlinedButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                    builder: (BuildContext context, Widget child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          primaryColor: Colors.grey[700],
                                          colorScheme: ColorScheme.dark(primary: Colors.grey[100]), 
                                        ),
                                        child: child,
                                      );
                                    },
                                  )
                                  .then((date) {
                                    setState(() {
                                      _date = date;
                                    });
                                  });
                                },
                                child: Text('Tanggal'), 
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.grey[700]),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                _date == null ? '' : DateFormat('E, d/M/y').format(_date).toString(),
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontStyle: FontStyle.italic
                                )
                              )
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            children: <Widget> [
                              OutlinedButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.grey[100],
                                            onSurface: Colors.grey[500]
                                          ),
                                        ),
                                        child: child,
                                      );
                                    }
                                  )
                                  .then((time) {
                                    setState(() {
                                      _time = time;
                                    });
                                  });
                                },
                                child: Text('Waktu'), 
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.grey[700]),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                _time == null ? '' : _time.format(context).toString(),
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontStyle: FontStyle.italic
                                )
                              )
                            ],
                          )
                        ],
                      )
                    )
                  )
                );
              }
            );
          }
        );
      },
    );
  }
}