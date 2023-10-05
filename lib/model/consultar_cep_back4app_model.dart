class ConsultasCepBack4AppModel {
  List<ConsultarCepBack4AppModel> cep = [];

  ConsultasCepBack4AppModel(this.cep);

  ConsultasCepBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cep = <ConsultarCepBack4AppModel>[];
      json['results'].forEach((v) {
        cep.add(ConsultarCepBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = cep.map((v) => v.toJson()).toList();
    return data;
  }
}

class ConsultarCepBack4AppModel {
  String objectId = "";
  String cep = "";
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  String createdAt = "";
  String updatedAt = "";

  ConsultarCepBack4AppModel(this.objectId, this.cep, this.logradouro,
      this.bairro, this.localidade, this.uf, this.createdAt, this.updatedAt);

  ConsultarCepBack4AppModel.criar(
    this.cep,
    this.logradouro,
    this.bairro,
    this.localidade,
    this.uf,
  );

  ConsultarCepBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}
