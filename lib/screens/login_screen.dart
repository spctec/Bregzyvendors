import 'package:bregzy_vendor/screens/home_screen.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_buttom.dart';
import 'package:bregzy_vendor/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;

  // final auth = Auth();
  checktoken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    if (value != null) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => new Home_Screen(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    checktoken();
  }

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: new Text(
                'خطأ',
                style: GoogleFonts.cairo(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              content: new Text(
                'تأكد من البريد الالكترونى وكلمة السر',
                style: GoogleFonts.cairo(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          );
        });
  }

  bool _isLoading = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.13,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 61.0, vertical: 30.0),
              child: Container(
                  child: Image.asset(
                "images/logo-bregzy-2000x727.png",
                width: 300,
              )),
            ),
            Form(
              key: _globalKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Custom_TextField(
                    controller: usernameController,
                    hint: 'البريد الألكتروني',
                    icon: Icons.email,
                    onclicked: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Custom_TextField(
                    controller: passwordController,
                    hint: 'كلمة المرور',
                    icon: Icons.vpn_key_rounded,
                    onclicked: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Custom_buttom(
                      opname: "تسجيل الدخول",
                      onpressed: () {
                        _globalKey.currentState.validate();
                        _globalKey.currentState.save();

                        setState(() {
                          _isLoading = true;
                        });

                        login(
                                email: usernameController.text,
                                password: passwordController.text)
                            .whenComplete(() {
                          if (status) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_Screen()));
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            _showDialog(context);
                          }
                        });

                        setState(() {
                          _isLoading = false;
                        });
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        if (_globalKey.currentState.validate()) {
          _globalKey.currentState.save();
          setState(() {
            setState(() {
              _isLoading = true;
            });
            print("$email -- $password");
            login(email: email, password: password).whenComplete(() {
              if (status) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Home_Screen()));
              } else {
                setState(() {
                  _isLoading = false;
                });
                _showDialog(context);
              }
            });
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffea1b25),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'تسجيل الدخول',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
