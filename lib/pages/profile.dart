import 'package:flutter/material.dart';
import 'package:project1010/models/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    print(globalToken);
    if(globalToken!= null){
      print("sfwefew");
      return Container(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 600,
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
                      "Nearby Politicians",
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
              ],
            ),
          ),
        )
      );
    } else {
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      // setState(() {
      // });
      print("NIGEEAsfwefew");
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(40),
              ),
              Text(
                "Sign in to see politicians in your area"
              ),
              RaisedButton(
                child: Text(
                  "Go"
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed('/register');
                },
              )
            ],
          ),
        ),
      );
    }
  }
}