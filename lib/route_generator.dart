import 'package:flutter/material.dart';
import 'package:project1010/main.dart';
import 'package:project1010/models/user.dart';
import 'package:project1010/pages/authentication.dart';
import 'package:project1010/pages/home.dart';
import 'package:project1010/pages/navigation.dart';
import 'package:project1010/pages/politician.dart';
// import 'package:my_app/screens/overview/home.dart';
// import 'package:my_app/screens/users/home.dart';
// import 'package:my_app/models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        print("Arguments");
        print(args);
        return MaterialPageRoute(builder: (_) => MainController());
        
      case '/home-filter':
        print("Arguments");
        print(args);
        return MaterialPageRoute(builder: (_) => HomeFilter());
      case '/register':
        print("Arguments");
        print(args);
        return MaterialPageRoute(builder: (_) => Register());

      case '/login':
        print("Arguments");
        print(args);
        return MaterialPageRoute(builder: (_) => Login());

      case '/politician-page':
        print("Arguments");
        print(args);
        return MaterialPageRoute(builder: (_) => PoliticianPage(politician: args));

      default:
          return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
// clearSession() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.clear();
// }
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
    : super(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            page,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
      );
}