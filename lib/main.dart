import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final String cityName;
  final double temperature;
  final String weatherDescription;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
  });
}

Future<WeatherData> fetchWeatherData() async {
  var previsaoSimplesUri = Uri(
    scheme: 'https',
    host: 'api.openweathermap.org',
    path: 'data/2.5/weather',
    queryParameters: {
      'q': 'caico',
      'units': 'metric',
      'appid': 'd54d9d02c25c79b822c4d38bbc3a1e47',
      'lang': 'pt_br'
    },
  );

  var response = await http.get(previsaoSimplesUri);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return WeatherData(
      cityName: data['name'],
      temperature: data['main']['temp'],
      weatherDescription: data['weather'][0]['description'],
    );
  } else {
    throw Exception('Falha ao carregar os dados da API');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF282C34,
          <int, Color>{
            50: Color.fromRGBO(40, 44, 52, 1),
            100: Color.fromRGBO(40, 44, 52, 1),
            200: Color.fromRGBO(40, 44, 52, 1),
            300: Color.fromRGBO(40, 44, 52, 1),
            400: Color.fromRGBO(40, 44, 52, 1),
            500: Color.fromRGBO(40, 44, 52, 1),
            600: Color.fromRGBO(40, 44, 52, 1),
            700: Color.fromRGBO(40, 44, 52, 1),
            800: Color.fromRGBO(40, 44, 52, 1),
            900: Color.fromRGBO(40, 44, 52, 1),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(217, 217, 217, 219),
        appBar: AppBar(title: const NewAppBar()),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Confira a Previsão do Tempo',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite uma cidade...',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                FutureBuilder<WeatherData>(
                  future: fetchWeatherData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Erro ao carregar os dados da API');
                    } else {
                      var weatherData = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/01d.png'),
                              Text(
                                '${weatherData.cityName}, ${weatherData.temperature}ºC, ${weatherData.weatherDescription}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                size: 24,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Sunny',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 24,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Humidity 41%',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NewNavBar(),
      ),
    );
  }
}

class NewAppBar extends StatelessWidget {
  const NewAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
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
        canvasColor:
            Color.fromRGBO(40, 44, 52, 1), // Defina a cor de fundo desejada
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          tocaramNoBotao;
        },
        currentIndex: state.value,
        unselectedIconTheme: IconThemeData(
            color: Colors
                .grey), // Define a cor dos ícones não selecionados como branco
        selectedIconTheme: IconThemeData(color: Colors.white),
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
