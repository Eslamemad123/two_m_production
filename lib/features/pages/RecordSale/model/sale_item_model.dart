import 'package:flutter/material.dart';

class SaleItemModel {
  String size;
  int quantity;
  final TextEditingController qtyController;

  SaleItemModel({this.size = 'M', this.quantity = 1})
    : qtyController = TextEditingController(text: quantity.toString());

  void dispose() {
    qtyController.dispose();
  }
}
