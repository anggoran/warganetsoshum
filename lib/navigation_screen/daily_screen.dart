import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math';
import 'package:timelines/timelines.dart';

class DailyScreen extends StatefulWidget {
  static const String id = 'daily_screen';

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  bool isClickedFAB = false;
  AnimationController _animationController;
  Animation<Color> _animateBackColor;
  Animation<Color> _animateFrontColor;
  Curve _curve = Curves.easeIn;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          setState(() {
            _angle = _animationController.value * 45 / 360 * pi * 2;
          });
        });
    _animateBackColor =
        ColorTween(
          begin: Colors.grey[800],
          end: Colors.grey[500]
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: _curve)
    ));
    _animateFrontColor =
        ColorTween(
          begin: Colors.grey[100],
          end: Colors.grey[900]
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: _curve)
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
      if(!isClickedFAB) {
        _animationController.forward();
      } else {
        _animationController.reverse();
    }
    isClickedFAB = ! isClickedFAB;
  }

  Widget fabulousFAB() {
    return FloatingActionButton(
      backgroundColor: _animateBackColor.value,
      foregroundColor: _animateFrontColor.value,
        onPressed: animate,
        child: Transform.rotate(
          child: Icon(Icons.add),
          angle: _angle
        ),
        elevation: 4.0,
      );
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
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
          'Harian',
          style: TextStyle(
            color: Colors.grey[100]
          )
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Stack(
        children: <Widget>[
          PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _selectedIndex = page;
            });
          },
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SecondaryAppBar('To Do List'),
                DailyList(
                  listCategory: TodoTile().todoLeading,
                  child: TodoTile(
                    leading: 'Kuliah',
                    title: 'Aku Lapar',
                    description: 'So you wanna be a software engineer at google? go to AlgoExpert.io, pick the questions, read the probs.',
                  ),
                ),
                SecondaryAppBar('Notes'),
                DailyList(
                  listCategory: NotesTile().notesLeading,
                  child: NotesTile(                          
                    leading: 'Kuliah',
                    title: 'Aku Lapar',
                    subtitle: Text(
                      'Hello World How Are you This Pandemic?',
                      style: TextStyle(
                        color: Colors.grey[400]
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    date: '18/04/2001',
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DetailsDialog(
                          heading: 'Aku Lapar',
                          body: 'Hello World How Are You this Pandemic?',
                        );
                      }
                    );      
                  },
                ),
                SecondaryAppBar('Diary'),
                DailyList(
                  listCategory: DiaryTile().diaryLeading,
                  child: DiaryTile(
                    leading: '#1',
                    title: 'The Irony of Me and You',
                    titleAlignment: TextAlign.center,
                    date: '18/04/21',
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DetailsDialog(
                          heading: 'The Irony of Me and You',
                          body: 'Halo! Nama saya Muhammad Anggoran Iwari, biasa dipanggil Anggoran. Ini adalah Diary yang saya buat untuk kebutuhan pada aplikasi saya. Diary ini dibuat dengan tujuan agar saya dapat mengukur bagaimana penyesuaian width dan height antara text dan layout.\n\nHalo! Nama saya Muhammad Anggoran Iwari, biasa dipanggil Anggoran. Ini adalah Diary yang saya buat untuk kebutuhan pada aplikasi saya. Diary ini dibuat dengan tujuan agar saya dapat mengukur bagaimana penyesuaian width dan height antara text dan layout.\n\nHalo! Nama saya Muhammad Anggoran Iwari, biasa dipanggil Anggoran. Ini adalah Diary yang saya buat untuk kebutuhan pada aplikasi saya. Diary ini dibuat dengan tujuan agar saya dapat mengukur bagaimana penyesuaian width dan height antara text dan layout.\n\nHalo! Nama saya Muhammad Anggoran Iwari, biasa dipanggil Anggoran. Ini adalah Diary yang saya buat untuk kebutuhan pada aplikasi saya. Diary ini dibuat dengan tujuan agar saya dapat mengukur bagaimana penyesuaian width dan height antara text dan layout.',
                        );
                      }
                    );      
                  },
                ),
              ],
            ),
            Container(
              color: Colors.grey[700],
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 32.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Text(
                        'Habit',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100],
                        ),
                      ),
                    ),
                  ),
                  for (var index = 0; index < HabitLine(index).timeList.length; index ++)
                    HabitLine(index),                       
                ],
              ),
            ),
          ]
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isClickedFAB ? MediaQuery.of(context).size.height : 0.0,
              width: isClickedFAB ? MediaQuery.of(context).size.height: 0.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isClickedFAB ? 0.0 : 400.0),
                color: Colors.grey[500]
              ),
              child: Container(
                margin: EdgeInsets.all(108.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AddDaily(
                      title: 'To Do List',
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDialog(
                              title: 'To Do List',
                              children: <Widget> [
                                AddForm(maxLength: 10, maxLines: 1, labelText: 'Kategori'),
                                AddForm(maxLength: 20, maxLines: 1, labelText: 'Judul'),
                                AddForm(maxLength: 120, maxLines: 4, labelText: 'Deskripsi')
                              ],
                            );
                          }
                        );
                      }
                    ),
                    AddDaily(
                      title: 'Notes',
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDialog(
                              title: 'Notes',
                              children: <Widget> [
                                AddForm(maxLength: 10, maxLines: 1, labelText: 'Kategori'),
                                AddForm(maxLength: 20, maxLines: 1, labelText: 'Judul'),
                                AddForm(maxLength: 120, maxLines: 4, labelText: 'Deskripsi')
                              ],
                            );
                          }
                        );
                      }
                    ),
                    AddDaily(
                      title: 'Diary',
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDialog(
                              title: 'Diary',
                              children: <Widget> [
                                AddForm(maxLength: 30, maxLines: 1, labelText: 'Heading'),
                                AddForm(maxLength: 1000, maxLines: null, labelText: 'Body'),
                              ],
                            );
                          }
                        );
                      }
                    ),
                    AddDaily(
                      // Habit bisa diclick biar sabi diedit atau delete
                      title: 'Habit',
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDialog(
                              title: 'Habit',
                              children: <Widget> [
                                AddForm(maxLength: 10, maxLines: 1, labelText: 'Waktu'),
                                AddForm(maxLength: 20, maxLines: 1, labelText: 'Aktivitas'),
                              ],
                            );
                          }
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          )
        ]
      ),
      floatingActionButton: fabulousFAB(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Catatan'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Rutinitas'
          ),
        ],
        backgroundColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.grey[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}

class DetailsDialog extends StatelessWidget {
  DetailsDialog({this.heading, this.body});
  
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.grey,
      title: Text(
        heading,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[900],
          fontWeight: FontWeight.bold
        ),
      ),
      content: Text(
        body,
        style: TextStyle(
          color: Colors.grey[900]
        ),
      )
    );
  }
}

class AddForm extends StatelessWidget {
  AddForm({this.maxLength, this.maxLines, this.labelText});

  final int maxLength;
  final int maxLines;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.grey[700],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[700]
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[700]
          )
        )
      ),
    );
  }
}

class AddDialog extends StatelessWidget {
  AddDialog({this.title, this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(                          
      backgroundColor: Colors.grey[500],
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Text(
            title,
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
            children: children,
              // Tanggal
          )
        ),
      )
    );
  }
}

class HabitActivity extends StatelessWidget {
  HabitActivity(this.activityList, this.index);

  final List<String> activityList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(16.0)
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: Text(
        activityList[index],
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        )
      ),
    );
  }
}

class HabitTime extends StatelessWidget {
  HabitTime(this.timeList, this.index);

  final List<String> timeList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        timeList[index],
        style: TextStyle(
          color: Colors.grey[200],
          fontSize: 14.0
        )
      ),
    );
  }
}

class HabitLine extends StatelessWidget {
  HabitLine(this.index);
  
  final int index;
  final List<String> timeList = ['09:00', 'siang', '1 jam'];
  final List<String> activityList = ['ngoding', 'belajar', 'membaca'];

  @override
  Widget build(BuildContext context) {    
    return TimelineTile(
      oppositeContents: index.isEven
      ? HabitTime(timeList, index)
      : HabitActivity(activityList, index),
      contents: index.isOdd
      ? HabitTime(timeList, index)
      : HabitActivity(activityList, index)
      ,
      node: TimelineNode(
        indicator: DotIndicator(
          color: Colors.grey[800],
          size: 16.0,
        ),
        startConnector: SizedBox(
          height: 20.0,
          child: SolidLineConnector(
            color: Colors.grey[500],
            thickness: 4.0,
          ),
        ),
        endConnector: index < timeList.length - 1
        ? SizedBox(
            height: 20.0,
            child: SolidLineConnector(
              color: Colors.grey[500],
              thickness: 4.0,
            ),
          )
        : SizedBox(height: 20.0)
      )
    );
  }
}

class AddDaily extends StatelessWidget {
  AddDaily({this.title, this.onTap});
  
  final String title;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[800]
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500]
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class DailyList extends StatefulWidget {
  DailyList({this.listCategory, this.child, this.onTap});
  final List listCategory;
  final Widget child;
  final Function onTap;

  @override
  _DailyListState createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              color: Colors.grey[700],
              child: Slidable(
                key: Key(widget.listCategory[index]),
                actionPane: SlidableDrawerActionPane(),
                actions: [
                  IconSlideAction(
                    color: Colors.grey[900], 
                    foregroundColor: Colors.grey[100], 
                    icon: Icons.edit,
                    onTap: () {
                      print('Hello Edit');
                    },
                  ),
                ],
                secondaryActions: [
                  IconSlideAction(
                    color: Colors.grey[900], 
                    foregroundColor: Colors.grey[100], 
                    icon: Icons.delete, 
                    onTap: () {
                      setState(() {
                        widget.listCategory.removeAt(index);
                        }
                      );
                    }
                  )
                ],
                child: widget.child,
              ),
            ),
            onTap: widget.onTap
          );
        },
        childCount: widget.listCategory.length
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  TodoTile({this.leading, this.title, this.description});
  final String leading;
  final String title;
  final String description;
  final List todoLeading = ['Kuliah', 'Kuliah', 'Kuliah'];
  final List todoTitle = [];
  final List todoDescription = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Text(
        leading,
        style: TextStyle(
          color: Colors.grey[500]
        )
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[300]
        )
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey[500],
      ),
      children: <Widget>[
        Container(
          color: Colors.grey[500],
          child: ListTile(
            title: Text(
              description,
              style: TextStyle(
                color: Colors.grey[800]
              )
            ),
          ),
        )
      ],
    );
  }
}

class NotesTile extends StatelessWidget {
  NotesTile({this.leading, this.title, this.subtitle, this.date});
  final String leading;
  final String title;
  final Widget subtitle;
  final String date;
  final List notesLeading = ['halo', 'hai', 'kenapa'];
  final List notesTitle = [];
  final List notesSubtitle = [];
  final List notesDate = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: TextStyle(
          color: Colors.grey[500]
        )
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[300]
        )
      ),
      subtitle: subtitle,
      trailing: Text(
        date,
        style: TextStyle(
          color: Colors.grey[500]
        )
      ),
    );
  }
}

class DiaryTile extends StatelessWidget {
  DiaryTile({this.leading, this.title, this.titleAlignment, this.date});
  final String leading;
  final String title;
  final TextAlign titleAlignment;
  final String date;
  final List diaryLeading = ['halo', 'hai', 'kenapa'];
  final List diaryTitle = [];
  final List diaryDate = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: TextStyle(
          color: Colors.grey[500]
        )
      ),
      title: Text(
        title,
        textAlign: titleAlignment,
        style: TextStyle(
          color: Colors.grey[300]
        )
      ),
      trailing: Text(
        date,
        style: TextStyle(
          color: Colors.grey[500]
        )
      ),
    );
  }
}

class SecondaryAppBar extends StatelessWidget {
  SecondaryAppBar(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      snap: false,
      title: Text(title),
      foregroundColor: Colors.grey[100],
      backgroundColor: Colors.grey[800],
    );
  }
}