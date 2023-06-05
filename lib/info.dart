import 'package:flutter/material.dart';



void main() {

  MyApp app = MyApp();

  runApp(app);

}





class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

        theme: ThemeData(primarySwatch: Colors.deepPurple),

        debugShowCheckedModeBanner: false,

        home: Scaffold(

          appBar: AppBar(

            title: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_outlined,
                    size: 40,
                  ),
                  Text(
                    '  Forecast Now  ',
                    style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),

          ),

          body: DataBodyWidget(),

          bottomNavigationBar: NewNavBar(),

        ));

  }

}



class NewNavBar extends StatelessWidget {

  NewNavBar();



  void botaoFoiTocado(int index) {

    print("Tocaram no botão $index");

  }



  @override

  Widget build(BuildContext context) {

    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [

      BottomNavigationBarItem(

        label: "Info", icon: Icon(Icons.info_outline),

      ),

      BottomNavigationBarItem(

          label: "Home", icon: Icon(Icons.home)),

      BottomNavigationBarItem(
          label: "Previsão detalhada", icon: Icon(Icons.filter_drama)),

    ]);

  }

}



class DataBodyWidget extends StatelessWidget {

  DataBodyWidget();

  @override

  Widget build(BuildContext context) {

    return Column(children: [

      Expanded(

        child: Text("Esse projeto foi utilizado uma API para puxar informações detalhadas sobre tempo e o clima de uma região"),

      ),

      Expanded(

        child: Text("Os integrantes para construção desse sistemas foram, Gabriel Lima, Leonardo Alves, Ricardo Alencar"),

      ),

      Expanded(

        child: Text("Para utilizar esse sistema basta digitar o nome da cidade ou região que você mora e clicar em buscar para puxar as informações climaticas dessee local"),

      )

    ]);

  }

}