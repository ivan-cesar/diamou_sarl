import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/facture.dart';
import 'repository/facture.repo.dart';

class AddFacture extends StatefulWidget {
    static const tag = "add_facture";
  @override
  State<AddFacture> createState() => _AddFactureState();
}

class _AddFactureState extends State<AddFacture> {
   // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  final CollectionReference _facturess =
      FirebaseFirestore.instance.collection('factures');

 Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (name != null && price != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _facturess.add({"name": name, "price": price});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _facturess
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "price": price});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _priceController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _facturess.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
      final _formKey = new GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une facture'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body:Form(
        child: ListView(
            children: <Widget>[
         TextFormField(
          controller:_nameController,
              decoration:  InputDecoration(labelText: 'Nom du client'),
            ),
             TextFormField(
              decoration:  InputDecoration(labelText: 'Service'),
              controller: _serviceController,
            ),
             TextFormField(
              decoration: new InputDecoration(labelText: 'Montant'),
              controller: _priceController,
            ),
             ElevatedButton(
              child:  Text('validez'),
              onPressed: () {
                final DateTime now = DateTime.now();

                final facture = Facture(nomClient: _nameController.text, services: _serviceController.text, montants: int.parse(_priceController.text), date: now.toString());
                 addFacture(facture);
                _nameController.text = "";
                _serviceController.text = "";
                _priceController.text = "";
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Facture ajouter avec succes",
                     textAlign: TextAlign.center,),
                     ),
                );

                    
               
              },
            ),
          ],
      ),
      )
    );
  }
}
