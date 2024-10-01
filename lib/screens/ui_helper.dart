import 'package:flutter/material.dart';
Widget mspacer({double mwidth=15,double mheight=11})=>SizedBox(width: mwidth,height: mheight,);
InputDecoration mTextfilDecor({
required String hint,
  required String label,
  double borderRadius=21,


}){
  return InputDecoration(
    hintText: hint,
    label:Text(label),
    focusedBorder:OutlineInputBorder( borderRadius:  BorderRadius.circular(borderRadius),),
    enabledBorder: OutlineInputBorder( borderRadius:  BorderRadius.circular(borderRadius),)

  );
}