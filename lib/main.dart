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
          appBar: AppBar(title: NewAppBar()),
          body: const Text("teste"),
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
      child: Text("Previsão do Tempo Agora"),
    ));
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void tocaramNoBotao(int index){
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(onTap: tocaramNoBotao, items: const [
        BottomNavigationBarItem(
          label: "Info",
          icon: Icon(Icons.info_outline)
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home)),
        BottomNavigationBarItem(
          label: "Previsão detalhada",
          icon: Icon(Icons.more)
        )
        ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forecast Now',
            ),
          ],
        ),
      ),
    );
  }
}
