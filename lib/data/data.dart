import 'package:flutter/material.dart';

String apiKey = "21f22329cafed1e374f9f58871daf58e";

String greetings() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good After Noon';
  } else if (hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good night';
  }
}

Widget getWidgetIcon(int code) {
  switch (code) {
    case >= 200 && 300:
      return Image.asset('assets/1.png');
    case >= 300 && 400:
      return Image.asset('assets/2.png');
    case >= 500 && 600:
      return Image.asset('assets/3.png');
    case >= 600 && 700:
      return Image.asset('assets/4.png');
    case >= 700 && 800:
      return Image.asset('assets/5.png');
    case == 800:
      return Image.asset('assets/7.png');
    case > 800 && <= 804:
      return Image.asset('assets/8.png');
    default:
      return Image.asset('assets/7.png');
  }
}
