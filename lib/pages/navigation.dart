import 'package:flutter/material.dart';
// import '../../models/user.dart';
import 'dart:convert';

import 'package:project1010/pages/home.dart';
import 'package:project1010/pages/info.dart';
import 'package:project1010/pages/profile.dart';
import 'package:project1010/pages/recommended.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:scoped_model/scoped_model.dart';
// import 'package:scoped_model/scoped_model.dart';

class MainController extends StatefulWidget {

  @override
  _MainControllerState createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Recommended(),
    Info(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Search"),
            // backgroundColor: Color(0xFF44A1A0),
            actions: [
              IconButton(icon: 
                Icon(Icons.search),
                onPressed: (){
                  showSearch(context: context, delegate: DataSearch());
                },
              )
            ],
            // bottom: PreferredSize(
            //   preferredSize: const Size.fromHeight(30.0),
            //   child: Container(
            //     decoration: new BoxDecoration(
            //       // borderRadius: new BorderRadius.circular(16.0),
            //       color: Colors.green,
            //     ),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.all(15),
            //         ),
            //         Text("Oakland"),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                backgroundColor: Color(0xFF44A1A0),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text("People"),
                backgroundColor: Color(0xFF44A1A0),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text("Info"),
                backgroundColor: Color(0xFF44A1A0),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text("Settings"),
                backgroundColor: Color(0xFF44A1A0),
              ),
            ],
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          body: _children[_currentIndex],
    );
  }
}

class DataSearch extends SearchDelegate<String>{
    final politicians = [
      "Joe Biden",
      "sdsfdvsdfv",
      "hnh tgr",
      "tbetgb bgbtgbe",
      "rgergerb",
      "gbtgb tgbtgbb",
      "ergerb Biden",
      "Jodvewfve ergerb",
      "rwwergJoe Biden",
      "p0j0giJoe Biden",
      "3r23Joe Biden",
      "e3frfrgJoe Biden",
      "thnJoe Biden",
      "gb vJoe Biden",
      "vdcxJoe Biden",
      "qefwJoe Biden",
      "iu8hJoe Biden",
    ];

    final recentPoliticians = [
      "fvfvwfv",
      "wefvwvf",
      "pji0p",
      "qwefqe",
    ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // actions for appbar
      return [
        IconButton(icon: 
          Icon(Icons.clear), 
          onPressed: (){
            query = "";
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // leading icon for left of appbar
      return IconButton(icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
          ),
          onPressed: (){
            close(context, null);
          },
        );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // show some results based on selection
      print(query);
      return Container(
        child: Card(
          child: Text(query),
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

    // MAKE API REQUEST FOR SEARCH HISTORY
    final suggestionList = query.isEmpty?recentPoliticians:politicians.where((p) => p.startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index)=>ListTile(
      onTap: (){
        print(suggestionList[index]);
        // print(context);
      },
      leading: Icon(Icons.people),
      title: RichText(
        text: TextSpan(
          text: suggestionList[index].substring(0, query.length),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
          children: [
            TextSpan(
              text: suggestionList[index].substring(query.length),
              style: TextStyle(color: Colors.grey)
            )
          ],
        ),
      ),
    ),
    itemCount: suggestionList.length,
    );
  }

}