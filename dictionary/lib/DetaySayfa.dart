import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/Kelimeler.dart';

class DetaySayfa extends StatefulWidget {

  Kelimeler word;

  DetaySayfa({required this.word}); //amaç veri gönderirken DetaySayfa.kelime diyebilmek

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
       backgroundColor: Colors.green,
        title: Text("Turkish"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.word.ingilizce,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.pink),),
            Text(widget.word.turkce,style: TextStyle(fontSize: 40),),

          ],
        ),
      ),
    );
  }
}
