import 'package:flutter/material.dart';
import 'package:warganetsoshum/backend_brain/organization_brain.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
// import 'package:warganetsoshum/details_screen/organization_details.dart';

class OrganizationScreen extends StatefulWidget {
  static const String id = 'organization_screen';

  @override
  _OrganizationScreenState createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
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
          'Organisasi',
          style: TextStyle(
            color: Colors.grey[100]
          )
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(24.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: <Widget>[
              for (var index = 0; index < namaOrganisasi.length; index ++)
              Organizations(index)
            ],
          ),
        ),          
      ),
    );
  }
}

class Organizations extends StatefulWidget {
  Organizations(this.index);

  final int index;

  @override
  _OrganizationsState createState() => _OrganizationsState();
}

class _OrganizationsState extends State<Organizations>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        Tween<double>(end: 1, begin: 0).animate(_animationController)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          _animationStatus = status;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(_animation.value < 0.5
          ? pi * _animation.value
          : pi * (1 + _animation.value)),
      child: GestureDetector(
        onTap: () {
          if (_animationStatus == AnimationStatus.dismissed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: _animation.value >= 0.5
          ? Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[700]
            ),
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      namaOrganisasi[widget.index],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100]
                      ),
                    ),
                  TextButton(
                    onPressed: () async {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen()));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            backgroundColor: Colors.grey,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget> [
                                Text(
                                  'Warganet Soshum',
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
                            content: Column(
                              children: <Widget> [
                                Text(
                                  'Bantu kami menyediakan informasi organisasi yang Kamu ketahui.',
                                  style: TextStyle(
                                    color: Colors.grey[900]
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextButton(
                                  onPressed: () async {
                                    const organisasiURL = 'https://c6sb7pwofhv.typeform.com/to/x28SYmKd';
                                      if (await canLaunch(organisasiURL)) {
                                        await launch(organisasiURL, forceWebView: true, enableJavaScript: true);
                                      } else {
                                        throw 'could not launch $organisasiURL';
                                      }
                                    },
                                  child: Text('Okay'),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(Colors.grey[100]),
                                    backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                                    elevation: MaterialStateProperty.all(4.0)
                                  )
                                )
                              ] 
                            ),
                          );
                        }
                      );
                    },
                    child: Text('info'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.grey[100]),
                      backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                      elevation: MaterialStateProperty.all(4.0)
                    )
                  ),
                ],
              ),
            ),
          )
          : Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[700]
              ),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Image.asset(
                  logoOrganisasi[widget.index],
                ),
              ),
            ),
      ),
    );
  }
}