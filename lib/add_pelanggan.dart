import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPelanggan extends StatelessWidget {
  var _controllerNama = TextEditingController();
  var _controllerAlamat = TextEditingController();
  var _controllerKode = TextEditingController();

  void addNewPelanggan() async {
    var url = 'http://192.168.1.8/db_diary/add_pelanggan.php';
    var response = await http.post((Uri.parse(url)), body: {
      'nama': _controllerNama.text,
      'alamat': _controllerAlamat.text,
      'kodeProduk': _controllerKode.text,
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody['succes']) {
        print('Berhasil');
      } else {
        print('Gagal');
      }
    } else {
      print('Request Eror');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Pelanggan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerNama,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nama Pelanggan'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerAlamat,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Alamat'),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerKode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Kode Barang'),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              addNewPelanggan();
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}