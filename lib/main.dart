import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
  var chaves = ["name", "code"];
  var colunas = ["Nome", "Matriula"];

  void carregar(index) {
    var carregadores = [
      carregarIntegrantes,
    ];

    carregadores[index]();
  }

  void PropIntegrantes() {
    chaves = ["name", "code"];
    colunas = ["Nome", "Matriula"];
  }


  void carregarIntegrantes() {
    PropIntegrantes();

    tableStateNotifier.value = [
      {"name": "GABRIEL LIMA", "code": "20220043441"},
      {"name": "LEONARDO ALVES", "code": "20220043915"},
      {"name": "RICARDO ALENCAR", "code": "20210056689"}
    ];
  }
}

final dataService = DataService();

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
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                return DataTableWidget(
                  jsonObjects: value,
                  propertyNames: dataService.chaves,
                  columnNames: dataService.colunas,
                );
              }),
        ));
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  final List<String> columnNames;

  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const ["Nome", "Matriula"],
      this.propertyNames = const ["name", "code"]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
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

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(
            40, 44, 52, 1), // Defina a cor de fundo desejada
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          tocaramNoBotao;
        },
        currentIndex: state.value,
        unselectedIconTheme: const IconThemeData(
            color: Colors
                .grey), // Define a cor dos ícones não selecionados como branco
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              label: "Info", icon: Icon(Icons.info_outline)),
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Previsão detalhada", icon: Icon(Icons.filter_drama))
        ],
      ),
    );
  }
}
