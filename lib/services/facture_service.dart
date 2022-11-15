import 'dart:convert';
import 'package:bill_mini_mobile/const.dart';
import 'package:bill_mini_mobile/models/facture_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FactureService {
  // ignore: non_constant_identifier_names
  static String ENTER_POINT = 'factures';

  Future<List<Facture>> getFactures(
      {String? idClient, int? idPartenaire}) async {
    final response = await http.get(Uri.parse(
        "${Constantes.API_URL}$ENTER_POINT?idClient=$idClient&partenaire[id]=$idPartenaire"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<dynamic> body = responseBody['data'];
      List<Facture> factures =
          body.map((dynamic item) => Facture.fromJson(item)).toList();

      return factures;
    } else {
      throw Exception('Failed toload data');
    }
  }
}
