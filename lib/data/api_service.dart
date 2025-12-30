import 'dart:convert';

import 'package:range_indicators/data/range_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _url = 'https://nd-assignment.azurewebsites.net/api/get-ranges';
  static const _token =
      'eb3dae0a10614a7e719277e07e268b12aeb3af6d7a4655472608451b321f5a95';

  Future<List<RangeModel>> fetchRanges() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer ${_token}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load ranges');
    }

    final data = json.decode(response.body) as List;
//     final ranges = data.map((e) => RangeModel.fromJson(e)).toList();
// print(ranges.first.label);
    return data.map((e) => RangeModel.fromJson(e)).toList();
  }
}
