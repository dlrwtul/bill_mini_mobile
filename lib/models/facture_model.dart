class Facture {
  int? id;
  String? numeroFacture;
  String? telephone;
  String? idClient;
  num? montant;
  String? status;
  String? dateEcheance;

  Facture({
    this.id,
    this.numeroFacture,
    this.telephone,
    this.montant,
    this.status,
    this.idClient,
    this.dateEcheance,
  });

  Facture.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        numeroFacture = json['numeroFacture'],
        montant = json['montant'],
        status = json['status'],
        telephone = json['telephone'],
        idClient = json['idClient'],
        dateEcheance = json['dateEcheance'];
}
