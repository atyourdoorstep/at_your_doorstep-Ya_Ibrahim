import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SpecialSpinner extends StatefulWidget {

  @override
  _SpecialSpinnerState createState() => _SpecialSpinnerState();
}

class _SpecialSpinnerState extends State<SpecialSpinner>
    with TickerProviderStateMixin{


  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(color: Colors.red,value: controller.value,),
          Image.asset("assets/atyourdoorstep.png", height: 28,width: 28,),
        ],
      ),
    );
  }
}
