import 'package:flutter/material.dart';
import 'package:range_indicators/data/range_model.dart';

import '../logic/range_calculator.dart';

class RangeBar extends StatelessWidget {
  final List<RangeModel> ranges;
  final double inputValue;

  const RangeBar({super.key, required this.ranges, required this.inputValue});

  @override
  Widget build(BuildContext context) {
    if (ranges.isEmpty) return const SizedBox.shrink();

    final calculator = RangeCalculator(ranges);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBar(calculator),
        const SizedBox(height: 8,),
        Text('Value: ${inputValue.toStringAsFixed(1)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildBar(RangeCalculator calculator) {
    return LayoutBuilder(builder: (context, constraints) {
      final barWidth = constraints.maxWidth;
      final indicatorLeft = barWidth * calculator.indicatorPosition(inputValue);

      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: ranges.map((range) {
                return Expanded(
                  flex: ((calculator.rangeWidthPecentage(range) * 1000).round()).clamp(1, 1000),
                  child: Container(
                    height: 32,
                    color: range.color,
                    alignment: Alignment.center,
                    child:  const SizedBox.shrink(),
                    // Text(
                    //   range.label,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 10,
                    //   ),
                    // ),
                  ),
                );
              }).toList(),
            ),
          ),

          if(indicatorLeft!=0.0)Positioned(
            left: indicatorLeft,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              color: Colors.black,
            ),
          )
        ],
      );
    });
  }
}

