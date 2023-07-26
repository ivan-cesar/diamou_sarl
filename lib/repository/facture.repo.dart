import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/facture.dart';

Future addFacture(Facture facture) async{

  final docFacture = FirebaseFirestore.instance.collection("factures").doc();
  facture.id = docFacture.id;
  await  docFacture.set(facture.toJson());
}