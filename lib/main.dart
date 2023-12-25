
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget{
  @override
  _CalculatorState createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator>{

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor, double txtsize){
    return Container(
      child: ElevatedButton(
        onPressed: (){
          calculation(btntxt);
      },
      child: Text(btntxt,
      style: TextStyle(
        fontSize: txtsize,
        color: txtcolor,
      ),
      ),
      style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: EdgeInsets.all(20),
      backgroundColor: btncolor,
      ),
      ), 
    );
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold( 
      backgroundColor: Color.fromARGB(255, 64, 44, 99),
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Color.fromARGB(255, 64, 44, 99),),
      body: Padding( 
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                    child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black,
                    fontSize: 100
                    ),
                    ),
                  ),
                ],
              ), 
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('AC', Color.fromARGB(255, 148, 23, 127), Colors.black, 23),
                  calcbutton('+/-', Color.fromARGB(255, 148, 23, 127), Colors.black, 23),
                  calcbutton('%', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('/', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                ],
              ),
              SizedBox(height:10,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('7', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('8', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('9', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('x', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                ],
              ),
              const SizedBox(height: 10,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('4', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('5', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('6', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('-', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                ],
              ),
              SizedBox(height: 10,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('1', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('2', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('3', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('+', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                ],
              ),
              SizedBox(height: 10,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('0', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('.', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                  calcbutton('=', Color.fromARGB(255, 148, 23, 127), Colors.black, 35),
                ],
              ),
              SizedBox(height: 10,),

              
            ],
            ),
        ),
      );
  }
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '/') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
        result = result + btnText;
        finalResult = result;        
    }


    setState(() {
          text = finalResult;
        });

  }


  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);           
         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }
}
