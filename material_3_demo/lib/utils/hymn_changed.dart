
import 'package:flutter/material.dart';

class HymnChanged extends Notification {
  final String hymnType;
  final int hymnNo;

  HymnChanged(this.hymnType, this.hymnNo);
}