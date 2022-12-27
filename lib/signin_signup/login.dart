import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talktome/signin_signup/forgot_password.dart';
import 'package:talktome/signin_signup/signup.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPassword(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.red),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text("Wrong Password Provided by User",
                style: TextStyle(fontSize: 18.0, color: Colors.red)),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(min. 6 Character");
                    }
                    return null;
                  },
                  onSaved: (Value) {
                    passwordController.text = Value!;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        )
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? "),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => Signup(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text('Signup'),
                    ),
                    // TextButton(
                    //   onPressed: () => {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         PageRouteBuilder(
                    //           pageBuilder: (context, a, b) => UserMain(),
                    //           transitionDuration: Duration(seconds: 0),
                    //         ),
                    //         (route) => false)
                    //   },
                    //   child: Text('Dashboard'),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 100),
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/loginui.png"),
                      fit: BoxFit.fitHeight),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
