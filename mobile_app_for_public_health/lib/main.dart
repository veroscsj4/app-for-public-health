import 'package:flutter/material.dart';
import 'src/authentification/screens/welcome/welcome.dart';
import 'src/constants/styles.dart';


void main() {
  runApp(App()); //Start die App
}
class App extends StatelessWidget{
  const App ({Key? key}): super(key:key);
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: WelcomePage(),
    );
  }
}


/*class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var questions = ["question 1", "question 2"];

  void answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  // override- ist ein Decorator, ist nur um zu vestehen, dass eine bestehene Methode manuell überschrieben wird
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage();
      /*home: Scaffold(
        appBar: AppBar(
          title: Text('Mein Körper'),
        ),
        body: Column(children: [
          Question(questions[_questionIndex]),
          ElevatedButton(
            child: const Text('Antwort'),
            onPressed: answerQuestion,
          ),
          ElevatedButton(
            child: const Text('Antwort 2'),
            onPressed: answerQuestion,
          ),
        ]),
      ),*/
    );
  }
}*/
