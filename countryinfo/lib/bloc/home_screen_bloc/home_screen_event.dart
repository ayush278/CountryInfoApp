import 'package:flutter/material.dart';

abstract class HomeScreenEvent {}

class InitEvent extends HomeScreenEvent {
  InitEvent();
}

class ButtonEvent extends HomeScreenEvent {
  final BuildContext context;
  String countryCode;
  ButtonEvent(this.context, {required this.countryCode});
}
