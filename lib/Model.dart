import 'package:flutter/material.dart';
import 'package:get/get.dart';

//-----------------------------------------------------------------------------------------
class DisplayNumValue extends GetxController 
{
	String displayValue = '0' ;
  double fontSize = 80.0 ;

  void displayNumber(String displayValue, double fontSize) 
	{
    	this.displayValue = displayValue ;
    	this.fontSize = fontSize ;

      update();
	}
}