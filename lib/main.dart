import 'package:flutter/material.dart';

void main() {
  runApp(const ConsumApp());
}

class ConsumApp extends StatelessWidget {
  const ConsumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator consum combustibil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _distantaController = TextEditingController();
  final TextEditingController _combustibilController = TextEditingController();

  String _rezultat = 'Introduceți datele și apăsați „Calculează”';

  void _calculeaza() {
    // Acceptăm și virgula ca separator zecimal (ex: 5,5)
    final double? distanta =
    double.tryParse(_distantaController.text.trim().replaceAll(',', '.'));
    final double? combustibil = double.tryParse(
        _combustibilController.text.trim().replaceAll(',', '.'));

    setState(() {
      if (distanta == null || combustibil == null) {
        _rezultat = 'Introduceți valori numerice valide!';
      } else if (distanta <= 0 || combustibil < 0) {
        _rezultat = 'Distanța trebuie să fie > 0, iar combustibilul ≥ 0!';
      } else {
        final double consum = combustibil / distanta * 100;
        _rezultat = 'Consum mediu: ${consum.toStringAsFixed(2)} l/100 km';
      }
    });
  }

  @override
  void dispose() {
    _distantaController.dispose();
    _combustibilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator consum combustibil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _distantaController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Distanța parcursă (km)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _combustibilController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Combustibil consumat (litri)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculeaza,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('Calculează', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              _rezultat,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}