import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Creating api hostname as global variable
String hostname = 'http://127.0.0.1:8000';
String globalToken;

// Start and number
int requestStart = 1;
int numberStart = 7;

// Storing user class
var user = User();

// Adding read write to session and save capabilities
class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString(key));
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class User {
  String email;
  String username;
  String password;
  String token;

  User();

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        username = json['username'],
        password = json['password'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'token': token,
      };


   // User Registration
  Future<String> registerUser() async {
    var postBody = { "username" : username, "email" : email, "password" : password };
    var response = await http.post(
      Uri.encodeFull(hostname + "/register/"),
      headers: {
        "Accept": "application/json",
      },
      body: postBody
    );
    print(response.body);
    Map<String, dynamic> map = json.decode(response.body);
    var newToken = map["token"];
    print("token login");
    print(newToken);
    var result = 'success';
    if(newToken == '' ||  newToken == null){
      result = 'failed';
    } else {

      // Saving user login data
      globalToken = newToken;
      token = newToken;
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("user", map);

    }
    print(token);
    return result;
    
  }
  Future<String> loginUser() async {
    var postBody = { "username" : username, "password" : password };
    var response = await http.post(
      Uri.encodeFull(hostname + "/login/"),
      headers: {
        "Accept": "application/json",
        "Start": "application/json",
      },
      body: postBody
    );
    print(response.body);
    print(response.body);
    Map<String, dynamic> map = json.decode(response.body);
    print("map");
    print(map);
    var newToken = map["token"];
    map["username"] = username;
    print("token login");
    print(newToken);
    var result = 'success';
    if(newToken == '' ||  newToken == null){
      result = 'failed';
    } else {

      // Saving user login data
      globalToken = newToken;
      token = newToken;
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("user", map);

      var _newUser = User();
      _newUser.username = username; 
      
      user = _newUser;
    }
    print(token);
    return result;
  }
}

class Politician {
  List<Politicians> politicians;

  Politician({this.politicians});

  Politician.fromJson(Map<String, dynamic> json) {
    if (json['politicians'] != null) {
      politicians = new List<Politicians>();
      json['politicians'].forEach((v) {
        politicians.add(new Politicians.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.politicians != null) {
      data['politicians'] = this.politicians.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<String> getUserData() async {
    print('Getting user data\n\n\n');
    print(globalToken);
    print('Getting user data');
    var response = await http.get(
      Uri.encodeFull(hostname + "/get_politician_data/"),
      headers: {
        "Accept": "application/json",
        "Authorization" : "Token " + globalToken.toString(),
        "Start" : requestStart.toString(),
        "Number" : numberStart.toString(),
      },
    );
    print(response.body);
    Map<String, dynamic> map = json.decode(response.body);
    var encodedJson = json.encode(response.body);
    var requestResults = map["details"];
    print("encodedJson");
    var jsonString = response.body.toString();
    print("jsonString");
    print(jsonString);
    print("jsonString");
    // if(requestResults == '' || requestResults == null){
    SharedPref sharedPref = SharedPref();
    await sharedPref.save("politicians", jsonString);
    
    // }
    return jsonString;
  }

}

class Politicians {
  int id;
  String name;
  int age;
  String position;
  String location;
  bool upForElection;
  String biography;
  String image;
  String criminalJustice;
  String economyTaxes;
  String abortion;
  String education;
  String minoritySupport;
  String immigration;
  String environment;
  String lbgtqRights;
  String womensRights;
  String healthCare;
  String corporations;
  String nationalSecurity;
  String gunControl;
  Preferences preferences;
  double score;
  List<String> similarViews;

  Politicians(
      {this.id,
      this.name,
      this.age,
      this.position,
      this.location,
      this.upForElection,
      this.biography,
      this.image,
      this.criminalJustice,
      this.economyTaxes,
      this.abortion,
      this.education,
      this.minoritySupport,
      this.immigration,
      this.environment,
      this.lbgtqRights,
      this.womensRights,
      this.healthCare,
      this.corporations,
      this.nationalSecurity,
      this.gunControl,
      this.preferences,
      this.score,
      this.similarViews});

  Politicians.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    position = json['position'];
    location = json['location'];
    upForElection = json['up_for_election'];
    biography = json['biography'];
    image = json['image'];
    criminalJustice = json['criminal_justice'];
    economyTaxes = json['economy_taxes'];
    abortion = json['abortion'];
    education = json['education'];
    minoritySupport = json['minority_support'];
    immigration = json['immigration'];
    environment = json['environment'];
    lbgtqRights = json['lbgtq_rights'];
    womensRights = json['womens_rights'];
    healthCare = json['health_care'];
    corporations = json['corporations'];
    nationalSecurity = json['national_security'];
    gunControl = json['gun_control'];
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
    score = json['score'];
    similarViews = json['similar_views'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['position'] = this.position;
    data['location'] = this.location;
    data['up_for_election'] = this.upForElection;
    data['biography'] = this.biography;
    data['image'] = this.image;
    data['criminal_justice'] = this.criminalJustice;
    data['economy_taxes'] = this.economyTaxes;
    data['abortion'] = this.abortion;
    data['education'] = this.education;
    data['minority_support'] = this.minoritySupport;
    data['immigration'] = this.immigration;
    data['environment'] = this.environment;
    data['lbgtq_rights'] = this.lbgtqRights;
    data['womens_rights'] = this.womensRights;
    data['health_care'] = this.healthCare;
    data['corporations'] = this.corporations;
    data['national_security'] = this.nationalSecurity;
    data['gun_control'] = this.gunControl;
    if (this.preferences != null) {
      data['preferences'] = this.preferences.toJson();
    }
    data['score'] = this.score;
    data['similar_views'] = this.similarViews;
    return data;
  }
}


class Preferences {
  String owner;
  int criminalJustice;
  int economyTaxes;
  int abortion;
  int education;
  int minoritySupport;
  int immigration;
  int environment;
  int lbgtqRights;
  int womensRights;
  int healthCare;
  int corporations;
  int nationalSecurity;
  int gunControl;
  int socialLeftToRight;
  int economicsLeftToRight;

  Preferences(
      {this.owner,
      this.criminalJustice,
      this.economyTaxes,
      this.abortion,
      this.education,
      this.minoritySupport,
      this.immigration,
      this.environment,
      this.lbgtqRights,
      this.womensRights,
      this.healthCare,
      this.corporations,
      this.nationalSecurity,
      this.gunControl,
      this.socialLeftToRight,
      this.economicsLeftToRight});

  Preferences.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    criminalJustice = json['criminal_justice'];
    economyTaxes = json['economy_taxes'];
    abortion = json['abortion'];
    education = json['education'];
    minoritySupport = json['minority_support'];
    immigration = json['immigration'];
    environment = json['environment'];
    lbgtqRights = json['lbgtq_rights'];
    womensRights = json['womens_rights'];
    healthCare = json['health_care'];
    corporations = json['corporations'];
    nationalSecurity = json['national_security'];
    gunControl = json['gun_control'];
    socialLeftToRight = json['social_left_to_right'];
    economicsLeftToRight = json['economics_left_to_right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['criminal_justice'] = this.criminalJustice;
    data['economy_taxes'] = this.economyTaxes;
    data['abortion'] = this.abortion;
    data['education'] = this.education;
    data['minority_support'] = this.minoritySupport;
    data['immigration'] = this.immigration;
    data['environment'] = this.environment;
    data['lbgtq_rights'] = this.lbgtqRights;
    data['womens_rights'] = this.womensRights;
    data['health_care'] = this.healthCare;
    data['corporations'] = this.corporations;
    data['national_security'] = this.nationalSecurity;
    data['gun_control'] = this.gunControl;
    data['social_left_to_right'] = this.socialLeftToRight;
    data['economics_left_to_right'] = this.economicsLeftToRight;
    return data;
  }
}