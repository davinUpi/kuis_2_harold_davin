import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Kuis2 Provis Davin_Harold",
        home: BlocProvider<ModelJenisPinjaman>(
          create: (_) => ModelJenisPinjaman(),
          child: const MainPage(),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    var temp = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My App P2P"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                  "2100195, Davin Fausta Sanjaya; 2102292, Harold Vidian Exaudi Simarmata; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang"),
            ),
            BlocBuilder<ModelJenisPinjaman, List<JenisPinjaman>>(
              builder: (context, instanceModelA) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                          isExpanded: true,
                          value: context
                              .read<ModelJenisPinjaman>()
                              .dropdownDefaultVal,
                          items: context.read<ModelJenisPinjaman>().dropdownVal,
                          onChanged: (String? newVal) {
                            context.read<ModelJenisPinjaman>().dropdownCurVal =
                                newVal!;
                            context.read<ModelJenisPinjaman>().fetchData();
                          }),
                      Expanded(
                          child: ListView.builder(
                              itemCount: instanceModelA.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                        leading: Image.network(
                                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                        trailing: const Icon(Icons.more_vert),
                                        title: Text(instanceModelA[index].nama),
                                        subtitle: Text(
                                            'id: ${instanceModelA[index].id}'),
                                        tileColor: Colors.white70));
                              }))
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String idPinjam;
  const DetailPage({Key? key, required this.idPinjam}) : super(key: key);

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detil")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ModelDetilJenis, DetilJenisPinjaman>(
              builder: (context, detail) {
            context.read<ModelDetilJenis>().fetchData();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(detail.id),
                  Text(detail.nama),
                  Text(detail.bunga),
                  Text(detail.syariah)
                ],
              ),
            );
          })
        ],
      )),
    );
  }
}
