import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final String cityName;
  final String pais;
  final double temperature;
  final String weatherDescription;
  final double feelslike;
  final int humidity;
  final String icontmp;
  final int pressure;
  final double windspeed;
  final int cloud;
  final double min_temp;
  final double max_temp;

  WeatherData(
      {required this.cityName,
      required this.pais,
      required this.temperature,
      required this.weatherDescription,
      required this.feelslike,
      required this.humidity,
      required this.icontmp,
      required this.pressure,
      required this.windspeed,
      required this.cloud,
      required this.min_temp,
      required this.max_temp});
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
        pais: data['sys']['country'],
        temperature: data['main']['temp'],
        weatherDescription: data['weather'][0]['description'],
        feelslike: data['main']['feels_like'],
        humidity: data['main']['humidity'],
        icontmp: data['weather'][0]['icon'],
        pressure: data['main']['pressure'],
        windspeed: data['wind']['speed'],
        cloud: data['clouds']['all'],
        min_temp: data['main']['temp_min'],
        max_temp: data['main']['temp_max']);
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
    valorTextField = 'Caicó';
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
        backgroundColor: Color.fromARGB(255, 218, 218, 218),
        appBar: AppBar(title: const NewAppBar()),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                //////////////////////////////////////////////////////////////
                ////////////////////// PÁGINA 1 //////////////////////////////
                /////////////////////////////////////////////////////////////////
                const SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      Text(
                        'Informações de Software',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(40, 44, 52, 1)),
                      ),
                      Text(
                        '',
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Nome do software',
                              ),
                              subtitle: Text(
                                'Forecast Now',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Versão do aplicativo',
                              ),
                              subtitle: Text(
                                '1.0.0-beta',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Descrição do software',
                              ),
                              subtitle: Text(
                                'O Forecast Now é um app de previsão do tempo, seu software utiliza uma API de clima para buscar informações atualizadas sobre o tempo e as condições climáticas de uma determinada região.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Desenvolvedores',
                              ),
                              subtitle: Text(
                                'Ricardo Alencar\nLeonardo Alves\nGabriel Lima',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Data de lançamento',
                              ),
                              subtitle: Text(
                                'Em produção',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Requisitos do sistema',
                              ),
                              subtitle: Text(
                                'Os aparelhos necessitam de conexão com o wifi',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //////////////////////////////////////////////////////////////
                ////////////////////// PÁGINA 2 //////////////////////////////
                /////////////////////////////////////////////////////////////////
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Confira a Previsão do Tempo',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(40, 44, 52, 1)),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          child: Image.asset(
                            'assets/images/nuvem.jpg',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Digite uma cidade...',
                          icon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(40, 44, 52, 1),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey), // Cor do fundo
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Valor do raio para bordas arredondadas
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          // Atualiza o valor da variável valorTextField com o valor atual do TextField
                          valorTextField = _controller.text;
                        });
                      },
                      child: const Text(
                        'Buscar',
                        style: TextStyle(
                          color: Color.fromRGBO(40, 44, 52, 1), // Cor do texto
                        ),
                      ),
                    ),
                    FutureBuilder<WeatherData>(
                      future: fetchWeatherData(valorTextField),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Erro ao carregar os dados da API');
                        } else {
                          var weatherData = snapshot.data!;
                          String breeze = "";
                          if (weatherData.windspeed >= 1.6 &&
                              weatherData.windspeed <= 5.4) {
                            breeze = "brisa leve";
                          } else if (weatherData.windspeed >= 5.5 &&
                              weatherData.windspeed <= 7.9) {
                            breeze = "brisa moderada";
                          } else if (weatherData.windspeed >= 8 &&
                              weatherData.windspeed <= 10.7) {
                            breeze = "vento forte";
                          }
                          var iconUrl =
                              'https://openweathermap.org/img/wn/${weatherData.icontmp}.png';
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(''),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image.network(iconUrl),
                                  Text(
                                    '${weatherData.cityName}, ${weatherData.pais}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(40, 44, 52, 1)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(iconUrl),
                                  Text(
                                    '${weatherData.temperature}ºC',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(40, 44, 52, 1)),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                    height: 35,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sensação térmica de ${weatherData.feelslike}ºC,\n$breeze, ${weatherData.weatherDescription}.',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ],

                  // container I
                ),
                //////////////////////////////////////////////////////////////
                ////////////////////// PÁGINA 3 //////////////////////////////
                //////////////////////////////////////////////////////////////
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Previsão do Tempo Detalhada',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(40, 44, 52, 1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 20.0),
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Digite uma cidade...',
                            icon: Icon(Icons.search,
                                color: Color.fromRGBO(40, 44, 52, 1)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey), // Cor do fundo
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Valor do raio para bordas arredondadas
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // Atualiza o valor da variável valorTextField com o valor atual do TextField
                            valorTextField = _controller.text;
                          });
                        },
                        child: const Text(
                          'Buscar',
                          style: TextStyle(
                            color:
                                Color.fromRGBO(40, 44, 52, 1), // Cor do texto
                          ),
                        ),
                      ),
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
                                Text(''),
                                Card(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.green[10],
                                  shadowColor: Colors.blueGrey,
                                  elevation: 20,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Image.network(iconUrl),
                                        title: Text(
                                          '${weatherData.cityName}, ${weatherData.pais}, ${weatherData.temperature}ºC',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            'Umidade: ${weatherData.humidity}%\nTemperatura mínima: ${weatherData.min_temp}\nTemperatura máxima: ${weatherData.max_temp}\nSensação térmica: ${weatherData.feelslike}ºC\nPressão atmosférica: ${weatherData.pressure}hPa\nVelocidade do vento: ${weatherData.windspeed}m/s\nNúvens: ${weatherData.cloud}%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
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
