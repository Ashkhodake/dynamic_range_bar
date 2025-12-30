import '../data/range_model.dart';

class RangeCalculator {
  final List<RangeModel> ranges;

  RangeCalculator(this.ranges);

  double get minValue {
    return ranges.first.min;
  }

  double get maxValue {
    return ranges.last.max;
  }

  double get totalSpan {
    return maxValue - minValue;
  }

  double rangeWidthPecentage(RangeModel range) {
    return range.span / totalSpan;
  }

  double indicatorPosition(double inputValue) {
    if (inputValue <= minValue) return 0;
    if (inputValue >= maxValue) return 1;

    return (inputValue - minValue) / totalSpan;
  }

  RangeModel? activeRange(double inputValue) {
    for (final range in ranges) {
      if (inputValue >= range.min && inputValue <= range.max) {
        return range;
      }
    }
    return null;
  }


}
