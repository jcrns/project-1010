import 'package:flutter/material.dart';
import 'package:project1010/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                ),
                Text(
                  "Log in to NewsBari ",
                  style: TextStyle(fontSize: 28),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => 
                  setState(() => _user.username = val),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => 
                  setState(() => _user.password = val),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    
                    onPressed: () async{
                      final form = _formKey.currentState;
                      if(form.validate()){
                        _showDialog(context);
                        form.save();
                        try {
                          final registerResults = await _user.loginUser();
                          if(registerResults != 'failed'){
                            print("TRYING TO LOGGIN");
                            await Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                          }
                        } catch(_){
                          print('failed');
                        }
                      }
                    },
                    child: const Text('Log In'),
                  )
                ),
                GestureDetector(
                  child: Text("Not a member yet? Sign Up", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                    onTap: () {
                    print("going to login");
                    Navigator.of(context).pushNamed('/register');
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showDialog(BuildContext context){
    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Logging In')));
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body : Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                ),
                Text(
                  "Create an account",
                  style: TextStyle(fontSize: 28),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => 
                  setState(() => _user.username = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => 
                  setState(() => _user.email = val),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => 
                  setState(() => _user.password = val),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    
                    onPressed: () async{
                      // final form = _formKey.currentState;
                      // if(form.validate()){
                      //   _showDialog(context);
                      //   form.save();
                      //   final registerResults = await _user.registerUser();
                      //   print('_user.token');
                      //   print(_user.token);
                      //   print(registerResults);
                      //   if(registerResults != 'failed'){
                      //     await Navigator.of(context).pushReplacementNamed('/', arguments:_user.token);
                      //   }
                      // }
                    },
                    child: const Text('Register'),
                  )
                ),
                GestureDetector(
                  child: Text("Already a member? Login now", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                    onTap: () {
                    print("_user.token");
                    // print(_user.token);
                    Navigator.of(context).pushNamed('/login');
                  }
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  _showDialog(BuildContext context){
    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Creating User')));
  }
}