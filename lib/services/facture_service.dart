import 'dart:convert';
import 'package:bill_mini_mobile/const.dart';
import 'package:bill_mini_mobile/models/facture_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FactureService {
  // ignore: non_constant_identifier_names
  static String currentPayer = '777777777';

  Future<List<Facture>> getFactures(
      {String? idClient, int? idPartenaire}) async {
    final response = await http.get(Uri.parse(
        "${Constantes.API_URL}factures?idClient=$idClient&partenaire[id]=$idPartenaire"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      debugPrint('statement $responseBody');
      List<dynamic> body = responseBody['data'];
      List<Facture> factures =
          body.map((dynamic item) => Facture.fromJson(item)).toList();

      return factures;
    } else {
      throw Exception('Failed toload data');
    }
  }

  Future<Facture> getFacture({int? idFacture}) async {
    final response = await http.get(Uri.parse(
        "${Constantes.API_URL}detailFacture/$idFacture?currentPayer=$currentPayer"));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      dynamic body = responseBody['data'];

      Facture facture = Facture.fromJson(body);

      return facture;
    } else {
      throw Exception('Failed toload data');
    }
  }

  Future<String> payerFacture({int? idFacture}) async {
    final response = await http.post(Uri.parse("${Constantes.API_URL}payer"),
        headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
        body:jsonEncode( {'id': idFacture, 'currentPayer': currentPayer}));
        debugPrint('response:${response.body}');
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);

      String body = responseBody['message'];

      return body;
    } else {
      throw Exception('Failed to store data');
    }
  }
}
