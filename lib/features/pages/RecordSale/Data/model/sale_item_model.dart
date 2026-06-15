import 'package:flutter/material.dart';

class SaleItemModel {
  String size;
  int quantity;
  final TextEditingController qtyController;

  SaleItemModel({this.size = 'Medium', this.quantity = 0})
    : qtyController = TextEditingController(text: quantity.toString());

  void dispose() {
    qtyController.dispose();
  }
}
