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
          primarySwatch: Colors.indigo,
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
                    'Confira a previsão do tempo da sua cidade',
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0), // Adicionando margem nas laterais
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite uma cidade...',
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

class NewAppBar extends StatelessWidget {
  NewAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Center(
      child: Text("Forecast Now"),
    ));
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void tocaramNoBotao(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: tocaramNoBotao,
      items: const [
        BottomNavigationBarItem(label: "Info", icon: Icon(Icons.info_outline)),
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "Previsão detalhada", icon: Icon(Icons.more))
      ],
    );
  }
}
