import 'package:flutter/material.dart';
import 'package:project1010/models/user.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

// Defining politician as global var
var politician = Politician();

// If loadedState is true update function won't load on page 
bool loadedState = false;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = new ScrollController();

  // Defining politician as global var
  // var politician = Politician();

  @override
  void initState() {
    super.initState();
    print("\n\n\n\n\n\npolitician");
    // print(politician.politicians[0].name);
    if(loadedState == false){
      _update();
      loadedState = true;
    }
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){

        // Changing number var to ask for more results
        numberStart = numberStart + numberStart;

        // Running update function
        _update();
      }
    });
    print("object");
    // WidgetsBinding.instance
        // .addPostFrameCallback((_) => _update());
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  _update() async {
    // Trying to update politician models
    try {
      print("politician");
      print(politician);
      var data = await politician.getUserData();
      // var _newUserData = await sharedPref.read('politcians');
      print("data");
      print(data);
      var _newUserDataFormatted = json.decode(data);
      Politician _newUserDataObject = Politician.fromJson(_newUserDataFormatted);
      setState(() {
        politician = _newUserDataObject;
      });
      print("politician.politicians[0].similarViews");
      print(politician.politicians[0].similarViews);
    } catch(_) {
      print('WTF');
    }
    // Trying to update user model
    // try {
      SharedPref sharedPref = SharedPref();
      var _newUser = await sharedPref.read('user');
      print("please workl");
      print(_newUser);
      print("please work");
      // var _newUserFormatted = json.decode(_newUser);
      print("please work");
      User _newUserObject = User.fromJson(_newUser);
      print("_newUserDataFormatted");
      print(_newUserObject);
      user = _newUserObject;
      print("_userData.stats.netWorth");
      print(user.username);
      setState(() {
        user = _newUserObject;
      });
    // } catch(_) {
    //   print
    // }
  }

  @override
  Widget build(BuildContext context) {
    if(globalToken != null){
      print("globalToken");
      print(globalToken);
      print(user.username ?? '');
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: RefreshIndicator(
        onRefresh: () async {
          print("\n\n\n\nZErgeirgrtg");
          await _update();
        },
        // Turn into list view
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding(
                //   // padding: EdgeInsets.all(20),
                // ),
                Text(
                  "Welcome, " + (user.username ?? ''),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Politicians",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 24),
                    ),
                    GestureDetector(
                      child: Text(
                          "Filter",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.blue),
                        ),
                      onTap: () async{
                        print("going to login");
                        // SharedPreferences preferences = await SharedPreferences.getInstance();
                        // preferences.clear();
                        await Navigator.of(context).pushNamed('/home-filter');
                      }
                    ),
                  ],
                ),
                Column(
                  children: politician?.politicians?.map((politician) => PoliticianCard(politician : politician, loggedIn: true,))?.toList() ?? [],
                )
              ],
            ),
          ),
        )
      ),
    );
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: RefreshIndicator(
          onRefresh: () async {
            print("\n\n\n\nZErgeirgrtg");
            await _update();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              // height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Padding(
                  //   // padding: EdgeInsets.all(20),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Politicians",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 24),
                      ),
                      GestureDetector(
                        child: Text(
                            "Filter",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.blue),
                          ),
                        onTap: () async{
                          print("going to login");
                          // SharedPreferences preferences = await SharedPreferences.getInstance();
                          // preferences.clear();
                          await Navigator.of(context).pushNamed('/home-filter');
                        }
                      ),
                    ],
                  ),
                  Column(
                    children: politician?.politicians?.map((politician) => PoliticianCard(politician : politician, loggedIn: false))?.toList() ?? [],
                  )
                ],
              ),
            ),
          )
        ),
      );
    }
  }
}

class PoliticianCard extends StatelessWidget {
  final Politicians politician;
  final bool loggedIn;
  PoliticianCard({ this.politician, this.loggedIn });
  
  
  @override
  Widget build(BuildContext context) {
    // print("politician.similarViews");
    // print(politician.similarViews);
    // print(loggedIn);
    // print("loggedIn");
    double text_width = MediaQuery.of(context).size.width*0.5;
    double img_width = MediaQuery.of(context).size.width*0.3;
    print("http://127.0.0.1:8000");
    // print(politician.image);
    if(loggedIn == true){
      return Card(
        margin: EdgeInsets.fromLTRB(0, 16.0,0, 0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: CachedNetworkImage(
                        width: img_width,
                        imageUrl: hostname + politician.image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: text_width,
                          child: Text(
                            politician.location,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: text_width,
                          child: Text(
                            politician.name,
                            style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: text_width,
                          child: Text(
                            politician.position,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: politician?.similarViews?.map((similarView) => SimilarViewsText(similarView : similarView))?.toList() ?? [],

                //   items: ["City Council", 'Mayor', "Congress", "Senate", "Governor", "President"].map(
                //   (val) {
                //     return DropdownMenuItem<String>(
                //       value: val,
                //       child: Text(val),
                //     );
                //   },
                // ).toList(),
                ),
              ],
            ),
          ),
          onTap: () async{
            print(politician);
            await Navigator.of(context).pushNamed('/politician-page', arguments: politician);
            print('sfsff');
          },
        )
      );
    } else {
      return Card(
        margin: EdgeInsets.fromLTRB(0, 16.0,0, 0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: CachedNetworkImage(
                        width: img_width,
                        imageUrl: hostname + politician.image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: text_width,
                          child: Text(
                            politician.location,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: text_width,
                          child: Text(
                            politician.name,
                            style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: text_width,
                          child: Text(
                            politician.position,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () async{
            print(politician);
            await Navigator.of(context).pushNamed('/politician-page', arguments: politician);
            print('sfsff');
          },
        )
      );
    }
  }
}

class SimilarViewsText extends StatelessWidget {
  final similarView;
  
  SimilarViewsText({
    this.similarView,
  });

  @override
  Widget build(BuildContext context) {
    print(similarView);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        "You have similar views on " + similarView
      ),
    );
  }
}

class HomeFilter extends StatefulWidget {
  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  String _dropDownObjectType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "Location",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  // decoration: TextDecoration()
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter', ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter your first name';
                  }
                },
                // onSaved: (val) => 
                // setState(() => _liability.name = val),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Sort By Position",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  // decoration: TextDecoration()
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DropdownButton(
                hint: _dropDownObjectType == null
                    ? Text('Select')
                    : Text(
                        _dropDownObjectType,
                        // style: TextStyle(color: Colors.blue),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: ["City Council", 'Mayor', "Congress", "Senate", "Governor", "President"].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      print(val);
                      _dropDownObjectType = val;
                      // _liability.typeOfObject = val;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RaisedButton(
                onPressed: () {

                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      )
    );
  }
}