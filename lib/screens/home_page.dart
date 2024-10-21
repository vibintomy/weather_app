
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
     
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
      
      ),
      body:Padding(
        padding:const  EdgeInsets.fromLTRB(40, 1.2* kToolbarHeight, 40,20),
        child: SizedBox(
          height:  MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment:const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple
                  ),
                ),
              ),
               Align(
                alignment:const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple
                  ),
                ),
              ),

             Align(
                alignment:const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration:const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.orange
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0),
                child: Container(
                  decoration:const BoxDecoration(
                    color: Colors.transparent
                  ),
                ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📍 Kochi',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 8,),
                      const Text('Good Morning',style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),),
                      Image.asset('assets/7.png'),
                  const    Center(child: Text('21 °C',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),)),
                  const   Center(child: Text('THUNDERSTORM',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),)),
                  const    SizedBox(height: 5,),
                  const   Center(
                       child: Text('Friday · 10.51 am',
                       style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                       ),),
                      
                     ),
                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/11.png',
                            scale: 8,),
                             const SizedBox(width: 5,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sunrise',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 3,),
                                Text('21 °C',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),)
                              ],
                            )
                          ],
                        ),
                         Row(
                          children: [
                            Image.asset('assets/12.png',
                            scale: 8,),
                             const SizedBox(width: 9,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sunset',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 3,),
                                Text('12 °C',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
               const     Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),

                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/13.png',
                            scale: 8,),
                            const SizedBox(width: 5,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Temp Max',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 3,),
                                Text('21 °C',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),)
                              ],
                            )
                          ],
                        ),
                      
                         Row(
                          children: [
                            Image.asset('assets/14.png',
                            scale: 8,),
                           
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Temp Min',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 3,),
                                Text('12 °C',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),  
                    
                    ],
                    
                      
                  ),
                )
            ],
          ),
        ),
         )
    );
  }
}