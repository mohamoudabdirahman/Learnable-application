import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../mylearning.dart';

class ProfileRows extends StatelessWidget {
  String? iconimage;
  String? title;

  ProfileRows({Key? key, required this.iconimage, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyLearning()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Container(
              width: 51.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade800.withOpacity(0.5),
                    offset: Offset(3, 3),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: Colors.white54.withOpacity(0.5),
                    offset: Offset(-3, -3),
                    blurRadius: 8,
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              child: Image(
                color: Colors.lightBlue,
                image: AssetImage(iconimage!)),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(title!,
                style: GoogleFonts.roboto(fontSize: 18.0, color: Colors.lightBlue))
          ],
        ),
      ),
    );
  }
}
