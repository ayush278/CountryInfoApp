import 'package:flutter/material.dart';

abstract class CountryDetailScreenEvent {}

class InitEvent extends CountryDetailScreenEvent {
  String countryCode;
  InitEvent({required this.countryCode});
}

class ExpandEvent extends CountryDetailScreenEvent {
  ExpandEvent();
}

class CollapseEvent extends CountryDetailScreenEvent {
  CollapseEvent();
}

class ButtonEvent extends CountryDetailScreenEvent {
  final BuildContext context;

  ButtonEvent(
    this.context,
  );
}
