import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/Kelimeler.dart';
import 'package:sozluk_uygulamasi/Kelimelerdao.dart';

import 'DetaySayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu=false;
  String aramaKelimesi="";

  Future<List<Kelimeler>> tumKelimeleriGoster() async {
    var kelimelerListesi= await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }
  Future<List<Kelimeler>> aramaYap() async {
    var kelimelerListesi= await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
         backgroundColor: Colors.green,
        title: aramaYapiliyorMu?
            TextField(
              decoration: InputDecoration(hintText: "Arama yapin"),
              onChanged: (aramaSonucu){
                print("Arama Sonucu: $aramaSonucu");
                setState(() {
                  aramaKelimesi=aramaSonucu;
                });
              },
            )
            :Text("English"),
        actions: [
          aramaYapiliyorMu ?
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: (){
                  setState(() {
                    aramaYapiliyorMu=false;
                    aramaKelimesi="";
                  });
                },
              )

              :IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu=true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyorMu ? aramaYap() : tumKelimeleriGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimelerListesi=snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi!.length,
              itemBuilder: (context,indeks){
                var kelime= kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfa(word: kelime,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                            //Text(kelime.turkce),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();//veri gelmediğinde arayüzde boş tasarım gözükmesi için
          }
        },

      ),
    );
  }
}
