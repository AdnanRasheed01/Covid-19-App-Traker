


import 'dart:async';

import 'package:covidapp/worls_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
  vsync:this)..repeat();

  @override
  void dispose() {

    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    
    super.initState();

    Timer(const Duration(seconds: 5), 
      () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const WorldSatate())));
  }
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          
          children: [

            AnimatedBuilder(animation: _controller,
            child: Container(
              width: 200,
              height: 200,
              child: const Center(
                child: Image(image: AssetImage('assets/images/virus.png')),
              ),

            ),
             builder:(BuildContext context, Widget? child){
              return Transform.rotate(angle: _controller.value *2.0*math.pi,
              child: child,
              );

             }),

             SizedBox(height: MediaQuery.of(context).size.height*.08,),
             const Align(
              alignment: Alignment.center,
               child:Text('Covid-19 \n Traker App', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),

             ),
           

            



        ],
        )
      ),


    );
    
  }
}