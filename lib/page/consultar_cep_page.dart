// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:cadastro_cep/model/consultar_cep_back4app_model.dart';
import 'package:cadastro_cep/repositories/back4app/cep_back4app_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConsultarCepPage extends StatefulWidget {
  const ConsultarCepPage({super.key});

  @override
  State<ConsultarCepPage> createState() => _ConsultarCepPageState();
}

class _ConsultarCepPageState extends State<ConsultarCepPage> {
  CepBack4AppRepository cepRepository = CepBack4AppRepository();
  var cepController = TextEditingController(text: "");

  bool loading = false;
  var _consultarCepBack4App = ConsultasCepBack4AppModel([]);

  var dio = Dio();

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      loading = true;
    });
    _consultarCepBack4App = await cepRepository.obterTarefas();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Consulta de CEPs",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          cepController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar CEP"),
                  content: TextField(
                    controller: cepController,
                    keyboardType: TextInputType.number,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          var response = await dio.get(
                              "https://viacep.com.br/ws/${cepController.text}/json/");
                          if (cepController.text.length == 8 &&
                              response.statusCode == 200) {
                            var json = response.data;

                            await cepRepository
                                .criar(ConsultarCepBack4AppModel.criar(
                              cepController.text,
                              json['logradouro'],
                              json['bairro'],
                              json['localidade'],
                              json['uf'],
                            ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "CEP cadastrado com sucesso",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                            )));
                          }
                          Navigator.pop(context);
                          obterTarefas();
                          setState(() {});
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _consultarCepBack4App.cep.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var cep = _consultarCepBack4App.cep[index];
                      return Dismissible(
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.red, // Define a cor de fundo aqui
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (DismissDirection dismissDirection) async {
                          await cepRepository.remover(cep.objectId);
                          obterTarefas();
                        },
                        key: Key(cep.cep),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              title: Text(
                                "CEP: ${cep.cep}\nRua: ${cep.logradouro}\nBairro: ${cep.bairro}\nCidade: ${cep.localidade}\nEstado: ${cep.uf}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    })),
            Visibility(
                visible: loading, child: const CircularProgressIndicator())
          ],
        ),
      ),
    ));
  }
}
