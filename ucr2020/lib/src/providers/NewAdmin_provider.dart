import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ucr2020/src/models/News_models.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class NewAdminProvider {
  //NewModel newmodel= NewModel();
  final _url = 'https://ucrbeta-25da1.firebaseio.com';

  Future<bool> cargarnoticia(NewModel noticia) async {
    final url = '$_url/new.json';

    await http.post(url, body: newModelToJson(noticia));

    return true;
  }

  Future<List<NewModel>> mostarnoticia() async {
    final url = '$_url/new.json';

    final resp = await http.get(url);
    Map<String, dynamic> noticadecodificada = json.decode(resp.body);

    if (noticadecodificada == null) return [];
    if (noticadecodificada['error'] != null) return [];

    final List<NewModel> noticia = new List();

    noticadecodificada.forEach((id, producto) {
      final temp = NewModel.fromJson(producto);
      temp.id = id;
      noticia.add(temp);
    });

    noticia.sort((a, b) => b.fechap.compareTo(a.fechap));

    return noticia;
  }

  Future<bool> editarProducto(NewModel noticia) async {
    final url = '$_url/new/${noticia.id}.json';

    final resp = await http.put(url, body: newModelToJson(noticia));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarlike(NewModel noticia) async {
    final url = '$_url/new/${noticia.id}.json';

    final resp = await http.put(url, body: newModelToJson(noticia));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<int> borrarnoticia(String id) async {
    final url = '$_url/new/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirimagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/ddaslo0lh/image/upload?upload_preset=rzyojp53');
    final mimetype = mime(imagen.path).split('/');

    final imageupload = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimetype[0], mimetype[1]),
    );

    imageupload.files.add(file);

    final stringresponse = await imageupload.send();

    final resp = await http.Response.fromStream(stringresponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    final respondedata = json.decode(resp.body);

    return respondedata['secure_url'];
  }
}
