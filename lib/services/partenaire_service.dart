import 'dart:convert';
import 'package:bill_mini_mobile/const.dart';
import 'package:bill_mini_mobile/models/partenaire_model.dart';
import 'package:http/http.dart' as http;

class PartenaireService {
  // ignore: non_constant_identifier_names
  static String ENTER_POINT = 'partenaires';

  Future<List<Partenaire>> getPartenaires([String? nomCommercial]) async {
    String searchTerm = ENTER_POINT;
    if (nomCommercial != '' && nomCommercial != null) {
      searchTerm += '?nomCommercial[like]=%\\$nomCommercial%';
    }
    final response =
        await http.get(Uri.parse(Constantes.API_URL + searchTerm));

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
