class Facture {
  String? id;
  String? nomClient;
  String? services;
  int? montants;
  String? date;

Facture({this.id='',required this.nomClient,required this.services,required this.montants,required this.date});


  // Méthode pour créer une instance du modèle à partir d'un snapshot Firestore
factory Facture.fromJson(Map<String, dynamic> json){
 return Facture(
      id: json['id'] as String?,
      nomClient: json['nomClient'] as String? ?? '', // Utilisez une chaîne vide ('') si la valeur est null
      services: json['services'] as String? ?? '', // Utilisez une chaîne vide ('') si la valeur est null
      montants: json['montants'] as int? ?? 0, // Utilisez 0 si la valeur est null
      date: json['date']?.toString() ?? '', // Utilisez une chaîne vide ('') si la valeur est null
 );
}
Map<String, dynamic> toJson(){

  return{
    'id':id,
    'nomClient':nomClient,
    'services':services,
    'montants':montants,
    'date':date
  };
}
}
