import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'всё в коде',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = '';
  bool _fetchingData = false;
  bool _savingData = false;
  bool _accessingHardware = false;

  //метод для имитации получения данных из сети
  Future<String> fetchData() async {
    setState(() {
      _fetchingData = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _fetchingData = false;
    });
    return 'какая-то информация из интернета';
  }

  //метод для имитации сохранения данных
  Future<void> saveData(String data) async {
    setState(() {
      _savingData = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _savingData = false;
    });
    print('Полученная информация: $data');
  }

  //метод для имитации обращения к аппаратным компонентам устройства
  Future<void> accessHardware() async {
    setState(() {
      _accessingHardware = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _accessingHardware = false;
    });
    print('отлично, информацию достали из компуктера успешно');
  }

  //нажатие кнопки
  void _fetchAndSaveData() async {
    try {
      // Получаем данные из сети
      String fetchedData = await fetchData();
      setState(() {
        _data = fetchedData;
      });
      await saveData(fetchedData);
      await accessHardware();
      print('поздравляю, всё работает');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('асинхронность', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_fetchingData) const CircularProgressIndicator(),
            if (_savingData) const CircularProgressIndicator(),
            if (_accessingHardware) const CircularProgressIndicator(),
            if (!_fetchingData && !_savingData && !_accessingHardware)
              Text(
                'Информация из интернета: $_data',
                style: const TextStyle(fontSize: 26, color: Colors.white),
              ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _fetchAndSaveData,
              child: const Text('сюда нажать'),
            ),
          ],
        ),
      ),
    );
  }
}
