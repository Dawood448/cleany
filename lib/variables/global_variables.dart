import 'package:cleany/models/chatting_details_model.dart';
import 'package:flutter/material.dart';

int? chatRoom;

List message = [];
List<ChattingDetailsModel> list = [];
bool canUpload = true;
List<bool> _isChecked = [false, false];
// int? user_id;
const MaterialColor kPrimaryColor = MaterialColor(
  0xFF5C4DB1,
  <int, Color>{
    50: Color(0xFF35B4C5),
    100: Color(0xFF35B4C5),
    200: Color(0xFF35B4C5),
    300: Color(0xFF35B4C5),
    400: Color(0xFF35B4C5),
    500: Color(0xFF35B4C5),
    600: Color(0xFF35B4C5),
    700: Color(0xFF35B4C5),
    800: Color(0xFF35B4C5),
    900: Color(0xFF35B4C5),
  },
);
