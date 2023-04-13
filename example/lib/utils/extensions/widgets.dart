import 'package:flutter/material.dart';

extension WidgetsUtils on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget padTop(double top) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: this,
    );
  }

  Widget padBottom(double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: this,
    );
  }

  Widget padLeft(double left) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: this,
    );
  }

  Widget padRight(double right) {
    return Padding(
      padding: EdgeInsets.only(right: right),
      child: this,
    );
  }

  Widget pad(double top, double bottom, double left, double right) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: this,
    );
  }

  Widget padAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget padHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget padVertical(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  Widget padTopLeft(double top, double left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: this,
    );
  }

  Widget padTopRight(double top, double right) {
    return Padding(
      padding: EdgeInsets.only(top: top, right: right),
      child: this,
    );
  }

  Widget padBottomLeft(double bottom, double left) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, left: left),
      child: this,
    );
  }

  Widget padBottomRight(double bottom, double right) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, right: right),
      child: this,
    );
  }

  Widget marginTop(double top) {
    return Container(
      margin: EdgeInsets.only(top: top),
      child: this,
    );
  }

  Widget marginBottom(double bottom) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      child: this,
    );
  }

  Widget marginLeft(double left) {
    return Container(
      margin: EdgeInsets.only(left: left),
      child: this,
    );
  }

  Widget marginRight(double right) {
    return Container(
      margin: EdgeInsets.only(right: right),
      child: this,
    );
  }
}
