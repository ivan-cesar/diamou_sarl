class Facture {
  String? id;
  String? nomClient;
  String? services;
  int? montants;
  String? date;

Facture({
     required this.date,
     this.id='',
     required this.montants,
     required this.nomClient,
     required this.services
     });


  // Méthode pour créer une instance du modèle à partir d'un snapshot Firestore
factory Facture.fromJson(Map<String, dynamic> json){
 return Facture(
      date: json['date']?.toString() ?? '', // Utilisez une chaîne vide ('') si la valeur est null
      id: json['id'] as String?,
      montants: json['montants'] as int? ?? 0, // Utilisez 0 si la valeur est null
      nomClient: json['nomClient'] as String? ?? '', // Utilisez une chaîne vide ('') si la valeur est null
      services: json['services'] as String? ?? '', // Utilisez une chaîne vide ('') si la valeur est null

 );
}
Map<String, dynamic> toJson(){

  return{
    'date':date,
    'id':id,
    'montants':montants,
    'nomClient':nomClient,
    'services':services,
  };
}
}
