import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warganetsoshum/backend_brain/event_brain.dart';
// import 'package:warganetsoshum/details_screen/organization_details.dart';

class EventScreen extends StatefulWidget {
  static const String id = 'event_screen';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
          'Kepanitiaan',
          style: TextStyle(
            color: Colors.grey[100]
          )
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(24.0),
          child: ListView(
            children: <Widget>[
              for (var index = 0; index < namaKepanitiaan.length; index ++)
              Events(index)
            ]
          )
        )
      )
    );
  }
}

class Events extends StatefulWidget {
  Events(this.index);

  final int index;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                    'Bantu kami menyediakan informasi kepanitiaan yang Kamu ketahui.',
                    style: TextStyle(
                      color: Colors.grey[900]
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () async {
                      const kepanitiaanURL = 'https://c6sb7pwofhv.typeform.com/to/qVUBYylD';
                        if (await canLaunch(kepanitiaanURL)) {
                          await launch(kepanitiaanURL, forceWebView: true, enableJavaScript: true);
                        } else {
                          throw 'could not launch $kepanitiaanURL';
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
      child: Card(
        color: Colors.grey[700],
        child: ListTile(
          leading: Image.asset(logoKepanitiaan[widget.index]),
          title: Text(
            namaKepanitiaan[widget.index],
            style: TextStyle(
              color: Colors.grey[100],
              fontSize: 24.0,
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle: Text(
            akronimKepanitiaan[widget.index],
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16.0,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}