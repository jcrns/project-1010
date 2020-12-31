import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1010/models/user.dart';

class PoliticianPage extends StatefulWidget {
  final Politicians politician;
  PoliticianPage({
    Key key,
    @required this.politician,
  });
  @override
  _PoliticianPageState createState() => _PoliticianPageState(politician : politician);
}

class _PoliticianPageState extends State<PoliticianPage> {
  final Politicians politician;
  _PoliticianPageState({
    Key key,
    @required this.politician,
  });
  
  @override
  Widget build(BuildContext context) {
    double text_width = MediaQuery.of(context).size.width*0.5;
    double img_width = MediaQuery.of(context).size.width*0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          politician.name
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          // height: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CachedNetworkImage(
                    width: img_width,
                    imageUrl: hostname + politician.image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          politician.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        width: text_width,
                        child: Text(
                          politician.position
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Criminal Justice",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.criminalJustice,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Economy Taxes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.economyTaxes,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Abortion",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.abortion,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Minority Support",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.minoritySupport,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Immigration",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.immigration,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Enviroment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.environment,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "LGBTQ Rights",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.lbgtqRights,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Womens Rights",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.womensRights,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Health Care",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.healthCare,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Corporations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.corporations,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "National Security",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.nationalSecurity,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text(
                    "Gun Control",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      politician.gunControl,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}