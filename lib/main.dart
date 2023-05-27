import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors
                    .white, // Cor de fundo do Container definida como branco
                borderRadius: BorderRadius.circular(
                    10.0), // Valor de raio para deixar a borda arredondada
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        hintText: 'Digite uma cidade...',
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/01d.png'),
                      Text('BR, Caicó, 32.24ºC, céu limpo',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'A sensação térmica em Caicó é de 32.82ºC',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop,
                        size: 24,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Humidity 41% | Probabilidade média de chuva',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
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
      icon: Icon(Icons.cloud_queue_outlined),
      child: Text("Forecast Now"),
    ));
  }
}

class NewNavBar extends HookWidget {
  NewNavBar();

  void tocaramNoBotao(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        tocaramNoBotao;
      },
      currentIndex: state.value,
      items: const [
        BottomNavigationBarItem(label: "Info", icon: Icon(Icons.info_outline)),
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "Previsão detalhada", icon: Icon(Icons.filter_drama ))
      ],
    );
  }
}
