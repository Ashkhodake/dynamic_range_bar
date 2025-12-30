import 'package:flutter/cupertino.dart';
import 'package:range_indicators/data/api_service.dart';
import 'package:range_indicators/data/range_model.dart';

class RangeNotifier extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  String? errorMessage;
  List<RangeModel> ranges = [];

  double inputValue = 0;

  Future<void> featchRanges() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      ranges = await _apiService.fetchRanges();
    } catch (e) {
      errorMessage = 'Failed to load data. Please try again.';
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  void updateInputValue(double value){
    inputValue = value;
    notifyListeners();
  }

  String? get outOfRangeMessage {
    if(ranges.isEmpty) return null;

    final min = ranges. first.min;
    final max = ranges.last.max;

    if(inputValue < min){
      return 'Value is below minimum range.';
    }else if (inputValue > max){
      return 'Value exceeds maximum range.';
    }
    return null;
  }
}
