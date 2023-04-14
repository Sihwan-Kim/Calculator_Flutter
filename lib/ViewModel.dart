import 'dart:io';
import 'package:flutter/material.dart';
import 'package:calculator_flutter/Model.dart' ;
import 'package:provider/provider.dart';
import 'package:get/get.dart';

var calcuControl = new CalculatorControl() ;

class CalculatorControl 
{
	var makeNumber = '' ;
	var selectedOperator = '+';
	var pointExist = false ;

	dynamic firstNumber = 0 ;
	dynamic secondNumber = 0 ;
	//-----------------------------------------------------------------------------------------
	void operatorOnPressed(String st)
	{
		resultOnPressed() ;
    final controller = Get.put(DisplayNumValue());
    
		firstNumber = double.parse(controller.displayValue) ;		
		selectedOperator = st ;		
	}
	//-----------------------------------------------------------------------------------------
	void resultOnPressed()
	{
		var display = '0' ;
    final controller = Get.put(DisplayNumValue());

		secondNumber = double.parse(controller.displayValue) ;		
		makeNumber = '';

		switch(selectedOperator)
		{
			case '+' : firstNumber = firstNumber + secondNumber ;	break ;
			case '−' : firstNumber = firstNumber - secondNumber ;	break ;
			case '×' : firstNumber = firstNumber * secondNumber ;	break ;
			case '÷' : firstNumber = firstNumber / secondNumber ;	break ;
		}

		display = firstNumber.toString();
		firstNumber = 0 ;
		selectedOperator = '+';		
		pointExist = false ;		

		if(display.length >= 3 && display.startsWith('.0', display.length-2)) 
		{
			display = display.substring(0, display.length-2) ;  // 정수일 경우 소수점 이하 지워라...
		}	

		_display(display) ;
	}
	//-----------------------------------------------------------------------------------------
	void functionOnPressed(String st)
	{
		var display = '0' ;
    final controller = Get.put(DisplayNumValue());

		if(st == 'C')		// clear input
		{
			selectedOperator = '+';
			makeNumber = ''; 
			firstNumber = 0 ;
			secondNumber = 0 ;
		}
		else if(st == '%')
		{
			var imsi = double.parse(controller.displayValue) / 100 ;

			if(selectedOperator == '+' || selectedOperator == '-' )
			{
				display = (imsi * firstNumber).toString();
			}
			else
			{
				display = imsi.toString();
			}
		}
		else
		{
			var imsiString = controller.displayValue ;
			makeNumber = '';

			if(imsiString.length > 1)
			{
				display = imsiString.substring(0, imsiString.length-1) ;
				makeNumber = display;
			}
		}

		_display(display) ;
	}
	//-----------------------------------------------------------------------------------------
	void numberOnPressed(String st)  		// 숫자키 입력 이벤트 함수 
	{
		bool inputAdd = true ; 

		if(st == '.') // 소숫점이 눌려졌을 경우 
		{
			if(makeNumber.isEmpty == true)
			{ 
				makeNumber += '0.';
				inputAdd = false ;
			}
			else
			{
				if(pointExist == true) inputAdd = false ; // 소숫점이 없을 경우만 추가
			}

			pointExist = true ;
		}
		else if(st == '0' && makeNumber.isEmpty == true)
    {
      inputAdd = false;
    }  
		
		if(inputAdd == true) makeNumber += st ;

	  _display(makeNumber) ;
	}
	//-----------------------------------------------------------------------------------------
	void _display(String Number)  // private member function
	{
		final controller = Get.put(DisplayNumValue());
    var fontSizes = 80.0 ;

		if(Number.length >= 8) fontSizes = 50 ;  // 글자 크기를 선택     

    controller.displayNumber(Number, fontSizes) ;		
	}
	//-----------------------------------------------------------------------------------------
}