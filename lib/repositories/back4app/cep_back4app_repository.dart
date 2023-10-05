import 'package:cadastro_cep/model/consultar_cep_back4app_model.dart';
import 'package:cadastro_cep/repositories/back4app/back4app_custon_dio.dart';

class CepBack4AppRepository {
  final _custonDio = Back4AppCustonDio();

  CepBack4AppRepository();

  Future<ConsultasCepBack4AppModel> obterTarefas() async {
    var url = "/CEP";
    var result = await _custonDio.dio.get(url);
    return ConsultasCepBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(ConsultarCepBack4AppModel cadastroCepBack4AppModel) async {
    try {
      await _custonDio.dio
          .post("/CEP", data: cadastroCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(
      ConsultarCepBack4AppModel cadastroCepBack4AppModel) async {
    try {
      await _custonDio.dio.put("/CEP/${cadastroCepBack4AppModel.objectId}",
          data: cadastroCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete(
        "/CEP/$objectId",
      );
    } catch (e) {
      rethrow;
    }
  }
}
