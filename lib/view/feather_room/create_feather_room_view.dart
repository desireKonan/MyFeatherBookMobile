import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/dto/diary.dart';
import 'package:my_feather_book_mobile/view/view.dart';

abstract class CreateUpdateFeatherRoomView implements View {
  Diary getDailyNotes();

  BuildContext getContext();

  void showSnackBar(String message);

  @override
  void move();
}
