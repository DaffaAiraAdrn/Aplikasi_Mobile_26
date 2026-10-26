import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget{
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _pilihTanggal() async {
    final DateTime? pilih = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pilih != null) {
      _selectedDate = pilih;
      final day = pilih.day.toString().padLeft(2, '0');
      final month = pilih.month.toString().padLeft(2, '0');
      _dateController.text = '$day/$month/${pilih.year}';
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat halaman ditutup untuk mencegah memory leak
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }
  

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catat Transaksi'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Judul", border:
                OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Tidak Boleh Kosong": null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Nominal", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Tidak boleh Kosong": null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tanggal Transaksi",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _pilihTanggal,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal wajib diisi";
                  }    
                  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                    return 'Format tanggal harus DD/MM/YYYY';
                  }              
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, 
                padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Transaksi Berhasil Disimpan"),
                      backgroundColor: Colors.green),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan', style: TextStyle(fontSize: 16.0)
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}