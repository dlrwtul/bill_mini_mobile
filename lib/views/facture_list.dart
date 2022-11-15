import 'package:bill_mini_mobile/models/facture_model.dart';
import 'package:bill_mini_mobile/services/facture_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FactureList extends StatefulWidget {

  String idClient = '';
  int idPartenaire = 0;
  FactureList({Key? key, required this.idPartenaire, required this.idClient})
      : super(key: key);

  @override
  State<FactureList> createState() => _FactureListState();
}

class _FactureListState extends State<FactureList> {

  late Future<List<Facture>> futureFactures;


 @override
  void initState() {
    super.initState();
    futureFactures = FactureService().getFactures(idClient: widget.idClient,idPartenaire: widget.idPartenaire);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Facture>>(
        future: futureFactures,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Facture>? factures = snapshot.data;
            return _buildFactures(context, factures);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}

ListView _buildFactures(
      BuildContext context, List<Facture>? factures) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: factures?.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              factures?[index].numeroFacture ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${factures?[index].montant}'),
            onTap: () {
              
            },
          ),
        );
      }),
    );
  }


