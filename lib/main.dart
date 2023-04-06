import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-----------------------------------------------------------------------------------------
var makeNumber = '' ;
var selectedOperator = '+';
var pointExist = false ;

dynamic firstNumber = 0 ;
dynamic secondNumber = 0 ;
//-----------------------------------------------------------------------------------------
class DisplayNumValue with ChangeNotifier 
{
    String _displayValue = '0' ;
	double _fontSize = 80 ;

  	String get displayValue => _displayValue;
	double get fontSize => _fontSize;

  	void Display(String value, double fontSize) 
  	{
    	_displayValue = value ;
		_fontSize = fontSize ;

    	notifyListeners();  //<-- 변경 내용을 전파(알림)
  	}
}
//-----------------------------------------------------------------------------------------
void main() 
{
	runApp
	(
    	MultiProvider
		(
      		providers: [ChangeNotifierProvider(create: (_) => DisplayNumValue()),],
      		child: CalculatorApp(),
    	),
  	);
}
//-----------------------------------------------------------------------------------------
class CalculatorApp extends StatelessWidget 
{
  	const CalculatorApp({super.key});
  
	@override
	Widget build(BuildContext context)  // This widget is the root of your application.
	{
		return MaterialApp
    	(
      		title: 'Flutter Demo',
      		theme: ThemeData(primarySwatch: Colors.blue,),
      		home: DesignPage(),
    	);
  	}
}
//-----------------------------------------------------------------------------------------
class DesignPage extends StatelessWidget
{
  	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar(title: Text('Calculator Program'),),
			body: ChangeNotifierProvider
			(
        		create: (BuildContext context) => DisplayNumValue(),
				child :Column
				(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>
					[
						Container
						(
							padding: EdgeInsets.all(30),
							alignment: Alignment(1.0, 1.0),   // 내부 위젯의 위치를 우측 하단으로 설정 
							color: Colors.black,
							child: displayValue(),
							height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.35,   // 화면의 35%를 차지하도록 설정
						),
						ButtonGroupWidget(),
					],					
				),
			),
			backgroundColor: Colors.black,
		);
	}
}  	
//-----------------------------------------------------------------------------------------
class displayValue extends StatelessWidget
{
	displayValue({super.key});

	@override
	Widget build(BuildContext context)
	{
		return Text
		(
			context.watch<DisplayNumValue>().displayValue,   
			style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: context.read<DisplayNumValue>().fontSize,),
			textAlign: TextAlign.right,
		) ;
	}
}
//-----------------------------------------------------------------------------------------
class CalButton extends StatelessWidget
{
	CalButton({super.key, required this.caption, required this.color, required this.buttonKind});
	final String caption ;  // 립력된 버튼의 문자 
	final Color color;      // 버튼의 색
	final int buttonKind;   // 입력된 버튼의 기능(0:숫자, 1:연산, 2:기능)

	@override
	Widget build(BuildContext context)
	{
		return ElevatedButton
		(
			onPressed: () 
			{ 
				switch(buttonKind)
				{
					case 0 : _numberOnPressed(context, caption); break ;
					case 1 : _operatorOnPressed(context, caption); break ;
					case 2 : _resultOnPressed(context, caption); break ; 
				} 
			},
			style: ElevatedButton.styleFrom
			(
				backgroundColor: color, 
				fixedSize: Size((MediaQuery.of(context).size.width/4)-30, (MediaQuery.of(context).size.width/4)-20), 
				shape: const CircleBorder(),
			),
			child: Text('$caption', style: TextStyle(fontSize: 40,),),
		);
	}
}
//-----------------------------------------------------------------------------------------
class ButtonGroupWidget extends StatelessWidget 
{
  	const ButtonGroupWidget({super.key});

  	@override
  	Widget build(BuildContext context) 
	{
    	return Table
		(
			border: TableBorder.all(),
      		columnWidths: const <int, TableColumnWidth>
			{
        		0: FlexColumnWidth(),
        		1: FlexColumnWidth(),
        		2: FlexColumnWidth(),
				3: FlexColumnWidth(),  
      		},
      		defaultVerticalAlignment: TableCellVerticalAlignment.middle,	
      		children: <TableRow>
			[
        		TableRow
				(
					decoration: const BoxDecoration(color: Colors.black,),
          			children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: 'C', color: Colors.grey, buttonKind: 2,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '%', color: Colors.grey, buttonKind: 1,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '⇍', color: Colors.grey, buttonKind: 1,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '÷', color: Colors.orange, buttonKind: 1,),),
          			],
        		),
        		TableRow
				(
					decoration: const BoxDecoration(color: Colors.black,),  
          			children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '7', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '8', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '9', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '×', color: Colors.orange, buttonKind: 1,),),
          			],
        		),
				TableRow
				(
					decoration: const BoxDecoration(color: Colors.black,),
          			children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '4', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '5', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '6', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '−', color: Colors.orange,buttonKind: 1,),),
          			],
        		),
				TableRow
				(
					decoration: const BoxDecoration(color: Colors.black,),
          			children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '1', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '2', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '3', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+', color: Colors.orange, buttonKind: 1,),),
          			],
        		),			
				TableRow
				(
					decoration: const BoxDecoration(color: Colors.black,),
          			children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+/-', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '0', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '.', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '=', color: Colors.orange, buttonKind: 2,),),
          			],
        		),		
      		],
    	);
  	}
}
//-----------------------------------------------------------------------------------------
void _operatorOnPressed(BuildContext context, String st)
{
	_resultOnPressed(context, '=') ;
	selectedOperator = st ;
	firstNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
}
//-----------------------------------------------------------------------------------------
void _resultOnPressed(BuildContext context, String st)
{
	var display = '0' ;
	var fontSizes = 80.0 ;

	if(st == 'C')		// clear input
	{
		selectedOperator = '+';
		makeNumber = ''; 
		firstNumber = 0 ;
 		secondNumber = 0 ;
	}
	else
	{
		secondNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
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
	}
	 pointExist = false ;

	if(display.length >= 7) fontSizes = 50 ;  // 글자 크기를 선택 
	
	context.read<DisplayNumValue>().Display(display, fontSizes) ;
}
//-----------------------------------------------------------------------------------------
void _numberOnPressed(BuildContext context, String st)  		// 숫자키 입력 이벤트 함수 
{
	var fontSizes = 80.0 ;
	bool inputAdd = true ; 

	if(makeNumber.length < 9)  // 숫자는 9자리 까지만 
	{
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
		else if(st == '0' && makeNumber.isEmpty == true)  inputAdd = false;
		
		if(inputAdd == true) makeNumber += st ;
		if(makeNumber.length >= 7) fontSizes = 50 ;  // 글자 크기를 선택 

		context.read<DisplayNumValue>().Display(makeNumber, fontSizes) ;
	}
}
//-----------------------------------------------------------------------------------------
