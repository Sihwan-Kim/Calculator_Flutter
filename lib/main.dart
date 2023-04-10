import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_flutter/View.dart' ;
import 'package:calculator_flutter/Model.dart' ;
import 'package:calculator_flutter/ViewModel.dart' ;
import 'package:get/get.dart';

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