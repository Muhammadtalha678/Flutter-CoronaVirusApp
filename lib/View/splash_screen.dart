import 'dart:async';

import 'package:coronavirusindicatorproject/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
//   helps in build animation (tickerProvider)
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late final AnimationController _controller = AnimationController(
  vsync: this,
  duration: const Duration( seconds: 4)
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    // to move on next page
    Timer(const Duration(seconds: 3),
    () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatesScreem()))
     );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            // for rotation of covid logo

            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: const 
                Center(
                  child: Image(image: AssetImage("images/virus.png")),
                ),
              ),
               builder: (BuildContext context ,Widget ? child){
                return  Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                  );
               })
            ,SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App ",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}