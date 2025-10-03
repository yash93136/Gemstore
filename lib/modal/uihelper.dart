import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class uihelper {
  static CustomButtom({
    required VoidCallback callback,
    required String buttomname,
  }) {
    return SizedBox(
      height: 35,
      width: 300,

      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: Text(
          buttomname,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  static Custombutton({
    required VoidCallback callback,
    required String buttonName,
  }) {
    return SizedBox(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white),
          ),
        ),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  static CustomText({
    required String text,
    required double height,
    required FontWeight? fontweight,
    Color? color,
  }) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
        fontSize: height,
        color: color ?? Colors.black,
        fontWeight: fontweight,
      ),
    );
  }

  static CustomContainer(TextEditingController controller) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}

class UiHelper {
  // 🔹 Custom Text
  static Widget customText({
    required String text,
    required double size,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
    );
  }

  // 🔹 Custom Banner
 static Widget customBanner({
  required String title,
  required String subtitle,
  required String image,
  Color? color,
  required double hight,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0)   ,
     child: Container(
      height: hight,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          // LEFT TEXT SIDE
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF60646F),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
    
          // RIGHT IMAGE SIDE
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
    
                // Image on top
                Image.asset(
                  image,
                  height: hight,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}