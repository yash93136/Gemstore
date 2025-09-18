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
    return Container(
      height: hight,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.customText(text: title, size: 14, color: Colors.grey),
                const SizedBox(height: 8),
                UiHelper.customText(
                  text: subtitle,
                  size: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF60646F),
                ),
              ],
            ),
          ),

          // RIGHT IMAGE
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circle BG
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
