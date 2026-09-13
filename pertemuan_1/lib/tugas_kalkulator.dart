import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Kalkulator Df137')),
        body: const Kalkulator(),
      ),
    );
  }
}

class Kalkulator extends StatefulWidget {
  const Kalkulator({super.key});

  @override
  State<Kalkulator> createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();
  late TextEditingController _aktif = _angka1Controller;
  String _operasi = '+';
  String _hasil = '0';

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  void _ketik(String karakter) => _aktif.text += karakter;

  void _pilihOperasi(String operasi) {
    setState(() {
      _operasi = operasi;
      _aktif = _angka2Controller;
    });
  }

  void _bersihkan() {
    setState(() {
      _angka1Controller.clear();
      _angka2Controller.clear();
      _aktif = _angka1Controller;
      _operasi = '+';
      _hasil = '0';
    });
  }

  void _hitung() {
    double? angka1 = double.tryParse(_angka1Controller.text);
    double? angka2 = double.tryParse(_angka2Controller.text);
    String hasil;

    if (angka1 == null || angka2 == null) {
      hasil = 'Masukan tidak valid';
    } else if (_operasi == '÷' && angka2 == 0) {
      hasil = 'Tidak bisa dibagi nol';
    } else {
      double nilai;
      switch (_operasi) {
        case '×':
          nilai = angka1 * angka2;
        case '÷':
          nilai = angka1 / angka2;
        case '+':
          nilai = angka1 + angka2;
        default:
          nilai = angka1 - angka2;
      }
      hasil = (nilai % 1 == 0 ? nilai.toInt() : nilai).toString();
    }

    setState(() => _hasil = hasil);
  }

  Widget _kolomAngka(TextEditingController controller, String label) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onTap: () => _aktif = controller,
      ),
    );
  }

  Widget _tombol(String label, VoidCallback aksi, [Color? warna]) {
    return Expanded(
      child: ElevatedButton(
        onPressed: aksi,
        style: ElevatedButton.styleFrom(
          backgroundColor: warna,
          foregroundColor: warna == null ? null : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 28)),
      ),
    );
  }

  Widget _tombolAngka(String label) => _tombol(label, () => _ketik(label));

  Widget _tombolOperasi(String label) =>
      _tombol(label, () => _pilihOperasi(label), Colors.orange);

  Widget _baris(List<Widget> tombol) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: tombol,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              _kolomAngka(_angka1Controller, 'Angka pertama'),
              Text(_operasi, style: const TextStyle(fontSize: 32)),
              _kolomAngka(_angka2Controller, 'Angka kedua'),
            ],
          ),
          Text(
            '= $_hasil',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          _baris([
            _tombolAngka('7'),
            _tombolAngka('8'),
            _tombolAngka('9'),
            _tombolOperasi('÷'),
          ]),
          _baris([
            _tombolAngka('4'),
            _tombolAngka('5'),
            _tombolAngka('6'),
            _tombolOperasi('×'),
          ]),
          _baris([
            _tombolAngka('1'),
            _tombolAngka('2'),
            _tombolAngka('3'),
            _tombolOperasi('-'),
          ]),
          _baris([
            _tombol('C', _bersihkan, Colors.red),
            _tombolAngka('0'),
            _tombolAngka('.'),
            _tombolOperasi('+'),
          ]),
          _baris([_tombol('=', _hitung, Colors.green)]),
        ],
      ),
    );
  }
}
