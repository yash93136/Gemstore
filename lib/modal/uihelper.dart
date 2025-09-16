import 'package:flutter/material.dart';

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
        child: Text(
          buttomname,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white),
          ),
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
      style: TextStyle(
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
