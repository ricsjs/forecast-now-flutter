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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Confira a Previsão do Tempo',
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0), // Adicionando margem nas laterais
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite algo...',
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
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
