import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talktome/signin_signup/login.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0,color: Colors.green),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
            ),
          );
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup",
        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.purple[500],
      ),
      // body: Container(
      //             padding: EdgeInsets.only(top: 100),
      //             height: 200,
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: AssetImage("assets/signup.png"),
      //                 fit: BoxFit.fitHeight
      //               ),

      //             ),
      //           ),
       body: SingleChildScrollView(
      child:Container(
      child: Column(
        children: <Widget>[
          Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/signup.png"),
                      fit: BoxFit.fitHeight
                    ),
                     ),
                ),
  Container(
      child:Form(
       key: _formKey,
       child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
       child: Column(
         children: [
           Container(
             margin: EdgeInsets.symmetric(vertical: 10.0),
             child: TextFormField(
               autofocus: false,
               decoration: InputDecoration(
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
                 } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
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
                 if (value == null || value.isEmpty) {
                   return 'Please Enter Password';
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
                 labelText: 'Confirm Password: ',
                 labelStyle: TextStyle(fontSize: 20.0),
                 border: OutlineInputBorder(),
                 errorStyle:
                     TextStyle(color: Colors.redAccent, fontSize: 15),
               ),
               controller: confirmPasswordController,
               validator: (value) {
                 if (value == null || value.isEmpty) {
                   return 'Please Enter Password';
                 }
                 return null;
               },
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(
                 onPressed: () {
                   // Validate returns true if the form is valid, otherwise false.
                   if (_formKey.currentState!.validate()) {
                     setState(() {
                       email = emailController.text;
                       password = passwordController.text;
                       confirmPassword = confirmPasswordController.text;
                     });
                     registration();
                   }
                 },
                 child: Text(
                   'Sign Up',
                   style: TextStyle(fontSize: 18.0),
                 ),
               ),
             ],
           ),
           Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Already have an Account? "),
                 TextButton(
                     onPressed: () => {
                           Navigator.pushReplacement(
                             context,
                             PageRouteBuilder(
                               pageBuilder:
                                   (context, animation1, animation2) =>
                                       Login(),
                               transitionDuration: Duration(seconds: 0),
                             ),
                           )
                         },
                     child: Text('Login'))
               ],
             ),
           )
         ],
       ),
      )
      )
  )
        ]
      ),
       )
       )
    );
  }
}