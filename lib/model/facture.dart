class Facture {
  String? id;
  String? nom_client;
  String? services;
  int? montants;
  String? date;

Facture({this.id='',required this.nom_client,required this.services,required this.montants,required this.date});

Map<String, dynamic> toJson(){

  return{
    'id':id,
    'nom_client':nom_client,
    'services':services,
    'montants':montants,
    'date':date
  };
}
/*
factory Facture.fromJson(Map<String, dynamic> json){
 return Facture(id: json['id'], nom_client: json['nom_client'], services: json['services'], montants: json['montants'], date: json['date'].toString());
}*/
 factory Facture.fromSnapshot(snapshot) {
     return Facture(
      id: snapshot['id'], 
      nom_client: snapshot['nom_client'] ?? "", 
      services: snapshot['services'] ?? "", 
      montants: snapshot['montants'] ?? "", 
      date: snapshot['date'] ?? "");

  }
}
