import 'dart:convert';

import 'package:bill_mini_mobile/models/partenaire_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PartenaireService {
  Future<List<Partenaire>> getPartenaires() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/payments/partenaires'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<dynamic> body = responseBody['data'];
      List<Partenaire> partenaires =
          body.map((dynamic item) => Partenaire.fromJson(item)).toList();

      return partenaires;
    } else {
      throw Exception('Failed toload data');
    }
  }
}
