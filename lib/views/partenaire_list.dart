import 'package:bill_mini_mobile/models/partenaire_model.dart';
import 'package:bill_mini_mobile/services/partenaire_service.dart';
import 'package:bill_mini_mobile/views/recherche_facture.dart';
import 'package:flutter/material.dart';

class PartenaireList extends StatefulWidget {
  const PartenaireList({super.key});

  @override
  State<PartenaireList> createState() => _PartenaireListState();
}

class _PartenaireListState extends State<PartenaireList> {
  late Future<List<Partenaire>> futurePartenaires;

  @override
  void initState() {
    super.initState();
    futurePartenaires = PartenaireService().getPartenaires();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Partenaire>>(
        future: futurePartenaires,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Partenaire>? partenaires = snapshot.data;
            return _buildPartenaires(context, partenaires);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  ListView _buildPartenaires(
      BuildContext context, List<Partenaire>? partenaires) {
    return ListView.builder(
      itemCount: partenaires?.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              partenaires?[index].nomCommercial ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(partenaires?[index].code ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RechercheFactures(
                    idPartenaire: partenaires?[index].id ?? 0,
                    libelleReferenceClient: partenaires?[index].libelleIdentifiant ,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
