import 'dart:ui';

import 'package:bill_mini_mobile/models/facture_model.dart';
import 'package:bill_mini_mobile/services/facture_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    futureFactures = FactureService().getFactures(
        idClient: widget.idClient, idPartenaire: widget.idPartenaire);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Facture>>(
        future: futureFactures,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Facture>? factures = snapshot.data;
            if (factures?.length == 1) {
              return detailsFacture(factures?[0].id);
            }
            return _buildFactures(context, factures);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}

detailsFacture(int? idFacture) => FutureBuilder<Facture>(
    future: FactureService().getFacture(idFacture: idFacture),
    builder: ((context, snapshot) {
      debugPrint('${snapshot.connectionState}');
      if (snapshot.connectionState == ConnectionState.done) {
        final Facture? facture = snapshot.data;
        return modaContainer(context, facture);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }));

ListView _buildFactures(BuildContext context, List<Facture>? factures) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: factures?.length,
    itemBuilder: ((context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                factures?[index].numeroFacture ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Chip(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
                backgroundColor: Colors.green.shade300,
                label: Text(factures?[index].status ?? '',
                    style:
                        const TextStyle(color: Colors.black, fontSize: 10.0)),
              ),
            ],
          ),
          subtitle: Text('${factures?[index].montant}'),
          onTap: () {
            _showModalFactures(context, factures?[index].id);
          },
        ),
      );
    }),
  );
}

_showModalFactures(context, int? idFacture) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return detailsFacture(idFacture);
      });
}

Widget modaContainer(context, Facture? facture) {
  return Container(
    color: Colors.transparent,
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
          )
        ],
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10),
                    child: const Text(
                      "Détail Facture",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5, right: 5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xfff8f8f8),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    CardDetails('Numero Facture', facture?.numeroFacture),
                    CardDetails('Montant', facture?.montant),
                    CardDetails('Date', facture?.dateEcheance),
                    CardDetails('Id Client', facture?.idClient),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Payer',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: () {
                  FutureBuilder<String>(
                      future:
                          FactureService().payerFacture(idFacture: facture?.id),
                      builder: ((context, snapshot) {
                        debugPrint('${snapshot.connectionState}');
                        if (snapshot.connectionState == ConnectionState.done) {
                          final String? message = snapshot.data;
                          Fluttertoast.showToast(
                              msg: message ?? 'àiezjiàrjeàiràze',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return Container();
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }));
                }),
          )
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget CardDetails(String? key, dynamic value) {
  double height = 55.0;
  return Card(
    elevation: 0,
    child: InkWell(
      onTap: () {
        height = 60.0;
      },
      child: Container(
        height: height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$key',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('$value')
          ],
        ),
      ),
    ),
  );
}

// Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   textAlign: TextAlign.justify,
//                   text: TextSpan(
//                       text: facture?.numeroFacture,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                           color: Colors.black,
//                           wordSpacing: 1)),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),