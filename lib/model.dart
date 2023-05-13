import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JenisPinjaman {
  String id;
  String nama;
  JenisPinjaman({required this.id, required this.nama});
}

class ModelJenisPinjaman extends Cubit<List<JenisPinjaman>> {
  String url = "http://178.128.17.76:8000/jenis_pinjaman/";
  ModelJenisPinjaman() : super([]);
  List<JenisPinjaman> listJenisPinjaman = <JenisPinjaman>[];

  // Untuk dropdown
  String dropdownCurVal = "";
  String dropdownDefaultVal = "";
  List<DropdownMenuItem<String>> dropdownVal = [
    const DropdownMenuItem<String>(
      value: "",
      child: Text("Pilih Jenis Pinjaman"),
    ),
    const DropdownMenuItem<String>(
      value: "1",
      child: Text("Jenis Pinjaman 1"),
    ),
    const DropdownMenuItem<String>(
      value: "2",
      child: Text("Jenis Pinjaman 2"),
    ),
    const DropdownMenuItem<String>(
      value: "3",
      child: Text("Jenis Pinjaman 3"),
    )
  ];

  void setFromJson(dynamic json) {
    setData(json);
    emit(listJenisPinjaman);
  }

  void setData(dynamic json) {
    listJenisPinjaman = [];
    var data = json['data'];
    for (var val in data) {
      String id = val['id'];
      String nama = val['nama'];
      listJenisPinjaman.add(JenisPinjaman(id: id, nama: nama));
    }
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url + dropdownCurVal));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal ambil');
    }
  }
}

class DetilJenisPinjaman {
  String id;
  String nama;
  String bunga;
  String syariah;
  DetilJenisPinjaman(
      {required this.id,
      required this.nama,
      required this.bunga,
      required this.syariah});
}

class ModelDetilJenis extends Cubit<DetilJenisPinjaman> {
  String id = "";
  String url = "http://127.0.0.1:8000/detil_jenis_pinjaman/";

  ModelDetilJenis()
      : super(DetilJenisPinjaman(id: "", nama: "", bunga: "", syariah: ""));

  void setFromJson(dynamic json) {
    id = json['id'];
    String nama = json['nama'];
    String bunga = json['bunga'];
    String syariah = json['syariah'];
    emit(
        DetilJenisPinjaman(id: id, nama: nama, bunga: bunga, syariah: syariah));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url + id));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal ambil');
    }
  }
}
