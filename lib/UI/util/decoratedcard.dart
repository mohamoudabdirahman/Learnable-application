// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class DecoratedCard extends StatelessWidget {
  const DecoratedCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.lightBlue,
      ),
      child: Row(
        // ignore: prefer_const_constructors, prefer_const_constructors
        
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(    
              children: [
                Stack(
                  children:[
                    Positioned(
                       left: 44,
                       top: 44,
                       child: Container(
                                         width: 85,
                                         height: 85,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                        borderRadius: BorderRadius.circular(300),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade800.withOpacity(0.1),
                            offset: Offset(3, 3),
                            blurRadius: 8,
                          ),
                        ]),
                                         
                                       ),
                     ),
                     Positioned(
                       left: 32,
                       top: 32,
                       child: Container(
                                         width: 110,
                                         height: 110,
                                         decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(300)
                                         ),
                                         
                                       ),
                     ),
                     Positioned(
                       left: 18,
                       top: 18,
                       child: Container(
                                         width: 140,
                                         height: 140,
                                         decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(300)
                                         ),
                                         
                                       ),
                     ),
                     Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(300)
                    ),
                    
                  ),
                  ]
                  
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enjoy Your",style: TextStyle(fontSize:18,color: Colors.white,letterSpacing: 2)),
              Text("Exploring",style: TextStyle(fontSize:30,color: Colors.white,fontWeight: FontWeight.bold)),
            ],  
          ),
          SizedBox(height: 10,),

          
        ],
      ),
    );
  }
}