import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
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
            'BEM FEB UI',
            style: TextStyle(
              color: Colors.grey[100]
            )
          ),
          backgroundColor: Colors.grey[900]
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(24.0),
                  color: Colors.grey[800],
                  child: Text(
                    'Badan Eksekutif Mahasiswa',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100],
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.grey[900],
                          offset: Offset(4.0, 4.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      '[PENJELASAN ORGANISASI]Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.', style: TextStyle(color: Colors.grey[900])
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                    '[DEPARTEMEN/BIRO]Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.', style: TextStyle(color: Colors.grey[900]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                  color: Colors.grey[900],
                ),
                child: Text('[Penjelasan Departemen/Biro] \nSWIPE UP! \n[ICON]', style: TextStyle(color: Colors.grey[100]), textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      ),
    );
  }
}