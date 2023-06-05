import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final String cityName;
  final double temperature;
  final String weatherDescription;
  final double feelslike;
  final int humidity;
  final String icontmp;

  WeatherData(
      {required this.cityName,
      required this.temperature,
      required this.weatherDescription,
      required this.feelslike,
      required this.humidity,
      required this.icontmp});
}

Future<WeatherData> fetchWeatherData(String city) async {
  var previsaoSimplesUri = Uri(
    scheme: 'https',
    host: 'api.openweathermap.org',
    path: 'data/2.5/weather',
    queryParameters: {
      'q': city,
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
        feelslike: data['main']['feels_like'],
        humidity: data['main']['humidity'],
        icontmp: data['weather'][0]['icon']);
  } else {
    throw Exception('Falha ao carregar os dados da API');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String valorTextField;
  TextEditingController _controller = TextEditingController();
  late PageController _pageController;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    valorTextField = 'caico';
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Page 1',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Confira a Previsão do Tempo',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  hintText: 'Digite uma cidade...',
                                  icon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Atualiza o valor da variável valorTextField com o valor atual do TextField
                                    valorTextField = _controller.text;
                                  });
                                },
                                child: Text('Buscar')),
                            FutureBuilder<WeatherData>(
                              future: fetchWeatherData(valorTextField),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text(
                                      'Erro ao carregar os dados da API');
                                } else {
                                  var weatherData = snapshot.data!;
                                  var iconUrl =
                                      'https://openweathermap.org/img/wn/${weatherData.icontmp}.png';
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(iconUrl),
                                          Text(
                                            '${weatherData.cityName}, ${weatherData.temperature}ºC, ${weatherData.weatherDescription}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.water_drop,
                                            size: 24,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Umidade: ${weatherData.humidity}%',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'A sensação térmica em ${weatherData.cityName} é ${weatherData.feelslike}ºC',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],

                          // container I
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Page 3',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NewNavBar(
          itemSelectedCallback: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
        ),
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
  final void Function(int) itemSelectedCallback;

  const NewNavBar({required this.itemSelectedCallback});

  void tocaramNoBotao(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(40, 44, 52, 1),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback(index);
          tocaramNoBotao(index);
        },
        currentIndex: state.value,
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Info",
            icon: Icon(Icons.info_outline),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Previsão detalhada",
            icon: Icon(Icons.filter_drama),
          ),
        ],
      ),
    );
  }
}
