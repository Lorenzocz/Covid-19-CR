import 'dart:convert';

HorarioModel newModelFromJson(String str) =>
    HorarioModel.fromJson(json.decode(str));

String nnewModelToJson(HorarioModel data) => json.encode(data.toJson());

class HorarioModel {
  String id;

  String nombreP;
  String depto;
  String descripcion;
  String grupo;

  HorarioModel({
    this.id,
    this.nombreP,
    this.depto,
    this.descripcion,
    this.grupo
  });

  factory HorarioModel.fromJson(Map<String, dynamic> json) => HorarioModel(
        id: json["id"],
        nombreP: json["nombreP"],
        depto: json["depto"],
        descripcion: json["Descripcion"],
         grupo: json["grupo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreP": nombreP,
        "depto": depto,
        "Descripcion": descripcion,
         "grupo": grupo,
      };
}
