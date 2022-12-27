import 'package:flutter/material.dart';
import 'package:talktome/signin_signup/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 2,),
            Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("welcomebg.png"),
            fit: BoxFit.cover,
          ),
        ),
            ),
            Text(
              "Welcome to Textrovert Life",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold,fontFamily:"italic"),
            ),
            Spacer(),
            Text(
              "Talk to your long distance friend",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black
              ),
            ),
            Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      ),
                  child: Row(
                    children: [
                      Text(
                        "Next",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black
                            ),
                      ),
                      // SizedBox(width: kDefaultPadding / 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.8),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}