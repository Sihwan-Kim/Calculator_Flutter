import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-----------------------------------------------------------------------------------------
var displayNumber = '0';
var makeNumber = '' ;
var selectedOperator = '+';
var displayFontSize = 80.0 ;
var pointExist = false ;

dynamic firstNumber = 0 ;
dynamic secondNumber = 0 ;

var _disignPage = new DesignPage() ;
//-----------------------------------------------------------------------------------------
void main() 
{
//	runApp(const CalculatorApp());
  	runApp
	(
		MultiProvider
		(
      		providers:[ ChangeNotifierProvider(create: (_) => ChangeValue()),],
    		child: CalculatorApp(),
  		),
	);
}
//-----------------------------------------------------------------------------------------
class ChangeValue with ChangeNotifier 
{
  	double _displayValue = 0 ;

  	double get displayValue => _displayValue;

  	void Change(double value) 
  	{
    	_displayValue = value ;
    	notifyListeners();  //<-- 변경 내용을 전파(알림)
  	}
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
      		home: MainPage(),
    	);
  	}
}
//-----------------------------------------------------------------------------------------
class MainPage extends StatefulWidget 
{
	@override
  	DesignPage createState() => _disignPage ; // DesignPage();
}
//-----------------------------------------------------------------------------------------
class DesignPage extends State<MainPage>  
{
  	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar(title: Text('Calculator Program'),),
			body: ChangeNotifierProvider
			(
        		create: (BuildContext context) => ChangeValue(),
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
							child: displayValue(caption: '$displayNumber', fontsize: displayFontSize,),
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
	displayValue({super.key, required this.caption, required this.fontsize});
	final String caption ;
	final double fontsize ;

	@override
	Widget build(BuildContext context)
	{
		return Text
		(
			'$caption', 
			style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: fontsize,),
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
					case 0 : _numberOnPressed(caption); break ;
					case 1 : _operatorOnPressed(caption); break ;
					case 2 : _resultOnPressed(caption); break ; 
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
void _operatorOnPressed(String st)
{
	_resultOnPressed('=') ;
	selectedOperator = st ;
	firstNumber = double.parse(displayNumber) ;
}
//-----------------------------------------------------------------------------------------
void _resultOnPressed(String st)
{
	if(st == 'C')		// clear input
	{
		selectedOperator = '+';
		makeNumber = ''; 
		displayNumber = '0' ;
		firstNumber = 0 ;
 		secondNumber = 0 ;
	}
	else
	{
		secondNumber = double.parse(displayNumber) ;
		makeNumber = '';

		switch(selectedOperator)
		{
			case '+' : firstNumber = firstNumber + secondNumber ;	break ;
			case '−' : firstNumber = firstNumber - secondNumber ;	break ;
			case '×' : firstNumber = firstNumber * secondNumber ;	break ;
			case '÷' : firstNumber = firstNumber / secondNumber ;	break ;
		}

		displayNumber = firstNumber.toString();
		firstNumber = 0 ;
		selectedOperator = '+';
	}
	 pointExist = false ;

	if(displayNumber.length < 7) displayFontSize = 80.0 ;  // 글자 크기를 선택 
	else displayFontSize = 50 ;

	_disignPage.setState(() { displayNumber ;});  // 화면을 갱신한다. 
}
//-----------------------------------------------------------------------------------------
void _numberOnPressed(String st)  		// 숫자키 입력 이벤트 함수 
{
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

		displayNumber = makeNumber ;

		if(displayNumber.length < 7) displayFontSize = 80.0 ;  // 글자 크기를 선택 
		else displayFontSize = 50 ;

		_disignPage.setState(() { displayNumber ;});  // 화면을 갱신한다. 
	}
}
//-----------------------------------------------------------------------------------------
