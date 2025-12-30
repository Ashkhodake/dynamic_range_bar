import 'package:flutter/material.dart';

class RangeModel {
  final double min;
  final double max;
  final String label;
  final Color color;

  RangeModel({
    required this.min,
    required this.max,
    required this.label,
    required this.color,
  });

  factory RangeModel.fromJson(Map<String, dynamic> json) {
    final rangeParts = (json['range'] as String).split('-');

    return RangeModel(
      min: double.parse(rangeParts[0]),
      max: double.parse(rangeParts[1]),
      label: json['meaning'],
      color: _hexToColor(json['color']),
    );
  }

  static Color  _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  double get span => max - min;
}


