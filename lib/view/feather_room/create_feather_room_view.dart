import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/models/dto/notes.dart';
import 'package:my_feather_book_mobile/view/view.dart';

abstract class CreateUpdateFeatherRoomView implements View {
  Notes getNotes();

  BuildContext getContext();

  void showSnackBar(String message);

  @override
  void move();
}
