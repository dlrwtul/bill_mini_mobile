import 'dart:convert';

import 'package:bill_mini_mobile/models/partenaire_model.dart';
import 'package:bill_mini_mobile/services/partenaire_service.dart';
import 'package:bill_mini_mobile/views/recherche_facture.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PartenaireList extends StatefulWidget {
  String? nomCommercial;
  PartenaireList({Key? key, this.nomCommercial}) : super(key: key);

  @override
  State<PartenaireList> createState() => _PartenaireListState();
}

class _PartenaireListState extends State<PartenaireList> {
  late Future<List<Partenaire>> futurePartenaires;

  @override
  void initState() {
    super.initState();
    futurePartenaires =
        PartenaireService().getPartenaires(widget.nomCommercial);
  }

  @override
  void didUpdateWidget(covariant PartenaireList oldWidget) {
    super.didUpdateWidget(oldWidget);
    futurePartenaires =
        PartenaireService().getPartenaires(widget.nomCommercial);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Partenaire>>(
        future: futurePartenaires,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Partenaire>? partenaires = snapshot.data;
            return RefreshIndicator(
              child: _buildGridPartenaires(context, partenaires),
              onRefresh: () {
                debugPrint('mess:${widget.nomCommercial}');
                setState(() {
                  futurePartenaires =
                      PartenaireService().getPartenaires(widget.nomCommercial);
                });
                return Future<void>(
                  () => null,
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  // ListView _buildPartenaires(
  //     BuildContext context, List<Partenaire>? partenaires) {
  //   return ListView.builder(
  //     itemCount: partenaires?.length,
  //     itemBuilder: ((context, index) {
  //       return gridItem(context, partenaires?[index]);
  //     }),
  //   );
  // }

  GridView _buildGridPartenaires(
          BuildContext context, List<Partenaire>? partenaires) =>
      GridView.builder(
        itemCount: partenaires?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0),
        itemBuilder: ((context, index) {
          return gridItem(context, partenaires?[index]);
        }),
      );
}

Widget gridItem(BuildContext context, Partenaire? partenaire) => GridTile(
        child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Card(
        elevation: 4,
        child: Center(child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.memory(const Base64Decoder().convert(partenaire
                    ?.logo ??
                'iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAABmJLR0QA/wD/AP+gvaeTAAAFKUlEQVRoge2aS2xUVRjH/9+5d2aYmZaWPkY6RUpVQCC2pChDFcFXTExckBijJiys0iHGBOPCPUsXauIjMSrBjcaNiQvjwhBTSpHwEEPiIwQUbGkLQkfrtJ22d+6czw0+0jJzv3PnIGrmt2z/53++/9w793zn3AFq1KhRo0aNfw0UbhhTqn9wJ4PSFmqYA/E4++6XE/u3jlvwq0iowKnswA5m+sR2MQCOMtGbE+9u+wggvg7+UGEGMasHbRdylS3E/GFr/6GBpr7Bm6/HBKECA5yxW8Yi/+3K5aFU9otbbTsbB17x4pE4Ad22C1kIAR3Mzsd4/LuoTV/jwF5+rocBq0VUYGOq4coLNg3Nb2lFvTYLCIIJz2Evh/zqLcbYiEGbbU0upLN17GCXLTPzT46wxdbkUhhqgy0vo3W45ZnDaXL8ManemZ39of78SE5pjpiX9hf5tStPX76n2yFgBMABf7ZwCHtWz4fxck3EyvEzJt1A/fkLE47nVX1HKN+fArD96twvOfHEZd43+rJ2im+jr3POyMtErAlGDyxV9G4x0ZfDSyacBX9KEdNrqhg9in3jHUY1mYhJQ9xwON78BWJOmfiXw7upcek16yF0O8xH8M5PbVIveeC9Ay4Im6Ty6GR+VOxdmUKhLbW6wv/Tjop8IF26xIFbxp0uAEmpPpqfLkq1lfDqkt9o14kHyB5w2sefkPiJAytoo/5ZzRWaTfTlyK9f5YuETP0SmTgwa4MNg+Z55evbxPpyODQy2b1a1ugQ34v3zy8Jksm/w4rEy4tbmDkLICb2LkOuZ90wk5Ku4W60uCRwdyUK3Pj0QCMYa4QTY8lv+V+l2nL4dfHjv2y8favJGA3dEKQRBY5EqBcGXZkzNWPU0CyElXNu+LGH1oDMOkFSmA3SiAITmW34HW/eqBn4O+w6Z4effDipY5FG07FFJ3IxSCO6EqwpI/2slVecIM1hDvd4fln90OiO+7p0xDwsgAn0pS4FiQSBmYgGN0t76OjU1DkALUI5AKAUjZy6fP8mf7ojvc1k3AI+l4gCAzdnD65lpibprJHJvKSZL5Ri0TOzy5tzuTvXtXvNjRul/hX4VCIKDKygMoB8j1ToaJvJpdZ/jYXtvquUH48nS/FYvZ+INTEpGyH/IFfyIp9JhIGBWXOGpM9KIn2ld8N2ECWEI6zARK/i+dS0RBv4lCYlP+EoJWM//tNhAYxpirwlFVcMnM5+lQDjDqmZ11j3s1RrCZ9AT+HZ1inpgIqBPc7fBYNTkWJDIuS7qlAwg/f4/ekhk0EVwyhSGTY409HxiHgjXiU+CLv1rhX7TQdWvMIM+QkHOzStlVplWkAITipWd5d2tRuHBYIeWiwPXFyaPBPoVxV0HMx9pYZ0pphtOxHWpewtvSx7eCXYb5caeU3JfIj5J3HtRT7PQI6A08w46ipnwNu1/NsQ/osoG9iFb7Rh8OsSBssRFRXrzcXsilMStWdSSABlb0EyOeEAoGNup1hMfEwa1jZlAzPRWqlJKR4dAdAq1RPTManWNmVvaYZ+hVi5TMHrsNe0dBLASumkzPq4VGsbK42C+97Y6wzskepLmjqwOz1iY25TrCwjDPkBH0AXb1RYwEbgN87GAJb/BIL5hn1/AQuB3WS8BwZHskw37oEFWAis2ewFuVL6vx2YmEzWa+3H4iernbMabDy0xFeYwd9jZ3OYFtQaNgIHnvb/ORmrAxbmq4qq3hAAgAI/wlCPgriil2a6VErEQm3patSoUaNGjf8pvwNlKoZveIb9MgAAAABJRU5ErkJggg=='),height: 50.0,width: 50.0,),
          ),
          title: Text(
            partenaire?.nomCommercial ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(partenaire?.code ?? ''),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RechercheFactures(
                  idPartenaire: partenaire?.id ?? 0,
                  libelleReferenceClient: partenaire?.libelleIdentifiant,
                ),
              ),
            );
          },
        ),
      )),
    ));
