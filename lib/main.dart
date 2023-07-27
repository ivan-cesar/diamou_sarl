import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/facture.dart';
import 'firebase_options.dart';
import 'add_facture.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent),);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:AppBarTheme(color: Colors.teal, centerTitle: true ),
        ),
        home: Factures(),
        routes: {AddFacture.tag: (_) => AddFacture()},
    );
  }
}

class Factures extends StatefulWidget {
  @override
  State<Factures> createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  @override
  Widget build(BuildContext context) {
    List<Facture> allFactures = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('DIAMOU Sarl'),
      ),
        body:Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 90,bottom: 40),
            child: Text("Bienvenue sur la platforme de paiemant des services DIAMOU Sarl",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),
                textAlign: TextAlign.center,),
          ),
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom( 
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(16),
                    ),
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.payment),
                    SizedBox(height: 10),
                    Text("Payer"),
                  ],
                ),
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom( 
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16),
                    ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddFacture.tag);

                },
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.login),
                    SizedBox(height: 10),
                    Text("Connecter"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Text('Date', textAlign: TextAlign.center, style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          Expanded(child: Text('Services',textAlign: TextAlign.center,  style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          Expanded(child: Text('Montants',textAlign: TextAlign.center,  style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          Expanded(child: Text('Action', textAlign: TextAlign.center, style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                  ),
                ),
                 ListTile(                //return new ListTile(
                            onTap: null,
                            title: Row(
                                children: <Widget>[
                                  Expanded(child: Text("25/07/23",textAlign: TextAlign.center, )),
                                  Expanded(child: Text("Site web",textAlign: TextAlign.center, )),
                                  Expanded(child: Text("90.000.000",textAlign: TextAlign.center, )),
                                  Expanded(child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.payment)))),
                                ]
                            )
                        ),
               StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("factures").orderBy('date').snapshots(),
                builder:(context, snp){
                  if (snp.hasError) {
                    return Center(child: Text('Error'),);
                  }
                  if (snp.hasData) {
                     allFactures = snp.data!.docs
                           .map((doc) => Facture.fromJson(doc.data() as Map<String, dynamic>)).toList();
                     return ListView.builder(
                      itemCount: allFactures.length,
                      itemBuilder: (context, index){
                        print("HHHHHHHHHHHEEEEEELLLLLLLLLLLOOOOOOOOO");
                           return Text(allFactures[index].nomClient.toString());
                      });
                  }else{
                    print(snp);
                    print("EEEEEERRRRROOOORRRRRRRRR");
                   return CircularProgressIndicator();
                  }

                }),
            
                ],
              ),
      ),
          
        
      ],
        )
      
      );
  }
}
