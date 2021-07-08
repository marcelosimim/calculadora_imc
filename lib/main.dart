import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = 'Informe seus dados';

  void _resetFilds() {
    _formKey = GlobalKey<FormState>();
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100.0;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc < 25) {
        _infoText = 'Peso normal (${imc.toStringAsPrecision(4)})';
      } else if (imc < 30) {
        _infoText = 'Sobrepeso (${imc.toStringAsPrecision(4)})';
      } else if (imc < 35) {
        _infoText = 'Obesidade grau 1 (${imc.toStringAsPrecision(4)})';
      } else if (imc < 40) {
        _infoText = 'Obesidade grau 2 (${imc.toStringAsPrecision(4)})';
      } else {
        _infoText = 'Obesidade grau 3 (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFilds)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.greenAccent,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          labelStyle: TextStyle(color: Colors.greenAccent)),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o peso";
                        }
                        if(value.contains(',')){
                          return 'Separe com ponto e não vírgula';
                        }
                        final n = num.tryParse(value);
                        if(n == null) {
                          return '"$value" não é um número válido';
                        }
                        if(n >= 500){
                          return 'Você está no app errado. Vá direto ao Guinness World Records!';
                        }
                        if(n < 0){
                          return 'Desculpa, ainda não trabalhamos com o mundo espiritual...';
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Altura (cm)',
                          labelStyle: TextStyle(color: Colors.greenAccent)),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a altura";
                        }
                        if(value.contains(',')){
                          return 'Separe com ponto e não vírgula';
                        }
                        final n = num.tryParse(value);
                        if(n == null) {
                          return '"$value" não é um número válido';
                        }
                        if(n >= 300){
                          return 'Você está no app errado. Vá direto ao Guinness World Records!';
                        }
                        if(n < 0){
                          return 'Desculpa, ainda não trabalhamos com o mundo espiritual...';
                        }
                        return null;
                      }),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate())
                                _calculate();
                            },
                            child: Text('Calcular',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0)),
                            style: ElevatedButton.styleFrom(primary: Colors.greenAccent, onPrimary: Colors.white)),
                      )),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 25.0))
                ],
              ),
            )));
  }
}
