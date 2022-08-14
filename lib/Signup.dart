import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:learnflutternew/Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Center(
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      widthFactor: 0.5,
                      child: Image(
                        image: AssetImage('assets/logotext.png'),
                        fit: BoxFit.cover,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      heightFactor: 0.85,
                      widthFactor: 0.85,
                      child: Image(
                        image: AssetImage('assets/shoeslogin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: FittedBox(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                        Expanded(
                            child: FractionallySizedBox(
                          heightFactor: 0.5,
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text(
                              'Enter your credentials to continue',
                              style: TextStyle(),
                            ),
                          ),
                        )),
                        Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: InputForm(
                    icontop: Icon(Icons.account_circle_outlined),
                    labelInput: 'Name',
                    hinttext: false,
                  )),
                  Expanded(
                      child: InputForm(
                    icontop: Icon(Icons.email_outlined),
                    labelInput: 'Email',
                    hinttext: false,
                  )),
                  Expanded(
                      child: InputForm(
                    icontop: Icon(Icons.lock_outline_sharp),
                    labelInput: 'Password',
                    hinttext: true,
                  )),
                  Expanded(
                      child: FractionallySizedBox(
                    heightFactor: 0.8,
                    widthFactor: 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: FractionallySizedBox(
                          heightFactor: 0.3,
                          widthFactor: 0.5,
                          child: FittedBox(child: Text('Sign Up'))),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  )),
                  Expanded(
                      child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    widthFactor: 0.6,
                    child: FittedBox(
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pushNamed('$Login');
                                    }),
                            ]),
                      ),
                    ),
                  )),
                  Spacer(),
                ],
              ))
        ]),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {Key? key,
      required this.icontop,
      required this.labelInput,
      required this.hinttext})
      : super(key: key);

  final Icon icontop;
  final String labelInput;
  final bool hinttext;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.75,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.0),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              //or 15.0
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: FittedBox(child: icontop),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: TextField(
                    obscureText: hinttext,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        height: 2.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                        label: Text(labelInput),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ))),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
