// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/otpscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phonenumber extends StatefulWidget {
  const Phonenumber(
      {Key? key,})
      : super(key: key);

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? initialselection = '+252';
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets9.lottiefiles.com/packages/lf20_hy4txm7l.json',
                height: 300.0),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800.withOpacity(0.06),
                        offset: const Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ]),
                child: Row(
                  children: [
                    CountryListPick(
                      theme: CountryTheme(
                          isShowTitle: false, showEnglishName: true),
                      initialSelection: initialselection,
                      onChanged: (CountryCode? country) {
                        initialselection = country?.dialCode;
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The field cannot be empty';
                          }
                          if (value.length < 4) {
                            return 'Invalid Phone Number';
                          }

                          return null;
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(13)],
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'phone number'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            MaterialButton(
                onPressed: () {
                  verify();
                },
                color: Colors.lightBlue,
                minWidth: 200,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  void verify() async {
    if (_formkey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    phonenumber: _controller.text,
                    initialcode: initialselection,
                  )));
    }
  }
}
