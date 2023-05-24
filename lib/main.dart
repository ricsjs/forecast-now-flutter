import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false, // Removendo o banner de debug
        home: Scaffold(
          backgroundColor: Color.fromARGB(229, 230, 219, 219),
          appBar: AppBar(title: NewAppBar()),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors
                    .white, // Cor de fundo do Container definida como branco
                borderRadius: BorderRadius.circular(
                    10.0), // Valor de raio para deixar a borda arredondada
              ),
              child: Center(
                child: Text(
                  'Conteúdo do meu aplicativo',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Text("teste"),
        ));
  }
}

class NewAppBar extends StatelessWidget {
  NewAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Center(
      child: Text("Previsão do Tempo Agora"),
    ));
  }
}
