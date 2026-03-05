import 'package:flutter/material.dart';

/// Adds padding extensions for widgets in the LayerX app.
extension PaddingExtension on Widget {
  Widget paddingFromAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Widget paddingVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Widget paddingTop(double padding) => Padding(
        padding: EdgeInsets.only(top: padding),
        child: this,
      );

  Widget paddingBottom(double padding) => Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: this,
      );

  Widget paddingLeft(double padding) => Padding(
        padding: EdgeInsets.only(left: padding),
        child: this,
      );

  Widget paddingRight(double padding) => Padding(
        padding: EdgeInsets.only(right: padding),
        child: this,
      );
}
