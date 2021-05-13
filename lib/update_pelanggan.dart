import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:apidiary/pelanggan.dart';

class UpdatePelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  UpdatePelanggan({this.pelanggan});
  @override
  _UpdatePelangganState createState() => _UpdatePelangganState();
}

class _UpdatePelangganState extends State<UpdatePelanggan> {
  var _controllerNama = TextEditingController();

  var _controllerAlamat = TextEditingController();

  var _controllerKode = TextEditingController();

  void addNewPelanggan() async {
    var url = 'http://192.168.43.5/db_diary/update_pelanggan.php';
    var response = await http.post((Uri.parse(url)), body: {
      'id': widget.pelanggan.id,
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
  void initState() {
    _controllerNama.text = widget.pelanggan.nama;
    _controllerAlamat.text = widget.pelanggan.alamat;
   _controllerKode.text = widget.pelanggan.kodePrduk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data Pelanggan'),
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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              addNewPelanggan();
            },
            child: Text(
              'Update',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}