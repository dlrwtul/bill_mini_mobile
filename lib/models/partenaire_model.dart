class Partenaire {
  int? id;
  String? nom;
  String? prenom;
  String? nomCommercial;
  String? telephone;
  String? email;
  String? logo;
  String? code;
  String? libelleIdentifiant;

  Partenaire(
      {this.id,
      this.logo,
      this.nom,
      this.prenom,
      this.nomCommercial,
      this.email,
      this.code,
      this.telephone,
      this.libelleIdentifiant});

  Partenaire.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nom = json['nom'],
        prenom = json['prenom'],
        code = json['code'],
        nomCommercial = json['nomCommercial'],
        email = json['email'],
        logo = json['logo'],
        telephone = json['telephone'],
        libelleIdentifiant = json['libelleIdentifiant'];
}
