import 'package:flutter/material.dart';

class AdsCard extends StatelessWidget {
  const AdsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('20% OFF',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              Text('sur Vos Livraisons \nen ce Mois',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
              Spacer(),
              Chip(label: Text('claim'),backgroundColor: Colors.grey.shade200,)
           
            ],
           
           ),
         ),

          Spacer(),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Image.asset('assets/images/dr.png',height: 155,width: 180,),
          )
        ],
      ),
      height: MediaQuery.of(context).size.height *0.23,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 1, 23, 42),
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}