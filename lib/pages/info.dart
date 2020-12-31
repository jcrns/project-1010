import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
            ),
            Text(
              "About NewsBari",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Our goal at NewBari is to make people aware of our country's political atmosphere. We provide unbiased analysis of politicians and show how their political opinions align with yours."
              ),
            ),
          ],
        ),
      ),
    );
  }
}