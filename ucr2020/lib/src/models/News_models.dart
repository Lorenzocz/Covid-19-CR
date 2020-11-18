// To parse this JSON data, do
//
//     final newModel = newModelFromJson(jsonString);

import 'dart:convert';

NewModel newModelFromJson(String str) => NewModel.fromJson(json.decode(str));

String newModelToJson(NewModel data) => json.encode(data.toJson());

class NewModel {
    String id;
    int idp;
    String titulo;
    String fotourl;
    String fecha;
    String depto;
    String contacto;
    String descripcion;
    String fechap;
    String url;
    int like;

    NewModel({
        this.url,
        this.id,
        this.idp,
        this.titulo,
        this.fotourl,
        this.fecha,
        this.depto,
        this.contacto,
        this.descripcion,
        this.fechap,
        this.like,
    });

    factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        url: json["url"],
        id: json["id"],
        idp: json["idp"],
        titulo: json["titulo"],
        fotourl: json["fotourl"],
        fecha: json["fecha"],
        depto: json["depto"],
        contacto: json["contacto"],
        descripcion: json["Descripcion"],
        fechap: json["fechap"],
        like: json["like"],
    );

    Map<String, dynamic> toJson() => {
        "url":url,
        "id": id,
        "idp": idp,
        "titulo": titulo,
        "fotourl": fotourl,
        "fecha": fecha,
        "depto": depto,
        "contacto": contacto,
        "Descripcion": descripcion,
        "fechap": fechap,
        "like": like,
    };
}
