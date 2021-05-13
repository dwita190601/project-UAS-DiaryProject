import 'dart:convert';

import 'package:apidiary/add_pelanggan.dart';
import 'package:apidiary/pelanggan.dart';
import 'package:apidiary/update_pelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ListPelanggan extends StatefulWidget {
  @override
  _ListPelangganState createState() => _ListPelangganState();
}

class _ListPelangganState extends State<ListPelanggan> {
  List<Pelanggan> _listPelanggan = [];

  void getListPelanggan() async {
    _listPelanggan.clear();
    String url = 'http://192.168.1.8/db_diary/getlist.php';
    var response = await http.get (Uri.parse(url));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody['succes']) {
        List listData = responseBody['data'];
        listData.forEach((itemPelanggan) {
          _listPelanggan.add(Pelanggan.fromMap(itemPelanggan));
        });
      } else {}
    } else {
      print('Request Error');
    }
    setState(() {});
  }

  void deletePelanggan(String id) async {
    var url = 'http://192.168.1.8/db_diary/delete_pelanggan.php';
    var response = await http.post(
      (Uri.parse(url)),
      body: {'id': id},
    );
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
    getListPelanggan();
  }

  @override
  void initState() {
    getListPelanggan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Pelanggan'),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  getListPelanggan();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.amber,
          // foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPelanggan()),
            ).then((value) => getListPelanggan());
          },
        ),
        body: _listPelanggan.length > 0
            ? ListView.builder(
                itemCount: _listPelanggan.length,
                itemBuilder: (context, index) {
                  Pelanggan pelanggan = _listPelanggan[index];
                  return ListTile(
                    leading: Image.network(
                      pelanggan.photo,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    title: Text(pelanggan.nama),
                    subtitle: Text("alamat" + pelanggan.alamat),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePelanggan(
                                pelanggan: pelanggan,
                              )),
                    ).then((value) => getListPelanggan()),
                    trailing: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                      child: InkWell(
                        onTap: () {
                          deletePelanggan(pelanggan.id);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text('Tidak ADA Data'),
              ));
  }
}