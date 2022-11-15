class Facture {
  int? id;
  String? numeroFacture;
  String? telephone;
  String? idClient;
  num? montant;
  String? dateEcheance;

  Facture({
    this.id,
    this.numeroFacture,
    this.telephone,
    this.montant,
    this.idClient,
    this.dateEcheance,
  });

  Facture.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        numeroFacture = json['numeroFacture'],
        montant = json['montant'],
        telephone = json['telephone'],
        idClient = json['idClient'],
        dateEcheance = json['dateEcheance'];
}
