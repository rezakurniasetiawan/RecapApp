import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';

class ShowModalBottomSheet extends StatelessWidget {
  const ShowModalBottomSheet(
      {super.key,
      required this.title,
      required this.controller,
      required this.hintText, required this.press});

  final String title, hintText;
  final TextEditingController controller;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Color(0xff4B556B),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(height: 30, width: 30, child: Icon(Icons.web)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                // height: 35,
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    hintText: hintText,
                    hintStyle:
                        const TextStyle(fontSize: 14.0, letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: press,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ThemeUtils.primaryColor,
            ),
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(
                    color: ThemeUtils.ColorWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}
