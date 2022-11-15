import 'package:bill_mini_mobile/views/facture_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RechercheFactures extends StatefulWidget {
  final int idPartenaire;
  String? libelleReferenceClient = "Reference Client";
  bool isSubmitted = false;
  Widget list = const Text('data');
  RechercheFactures(
      {Key? key, required this.idPartenaire, this.libelleReferenceClient})
      : super(key: key);

  @override
  State<RechercheFactures> createState() => _RechercheFacturesState();
}

class _RechercheFacturesState extends State<RechercheFactures> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rechercher factures'),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 50.0,
                  child: Text('Veuillez saisir'),
                ),
                TextFormField(
                  controller: textController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                      hintText: widget.libelleReferenceClient),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.isSubmitted = true;
                          super.setState(() {
                            widget.list = FactureList(
                                idPartenaire: widget.idPartenaire,
                                idClient: textController.text);
                          });
                          debugPrint(
                              'idParternaire:${widget.idPartenaire},idClient:${textController.text}');
                        }
                      },
                      child: const Text('Rechercher')),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: widget.list,
                )
              ],
            )));
  }
}
