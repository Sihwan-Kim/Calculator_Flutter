import 'package:flutter/material.dart';
import 'package:get/get.dart';

//-----------------------------------------------------------------------------------------
class DisplayNumValue extends GetxController 
{
	String displayValue = '0' ;
  	double fontSize = 80 ;

  	void Display(String value, double fontSize) 
	{
    	displayValue = value ;
    	fontSize = fontSize ;
    
    	update();
	}
}