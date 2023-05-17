import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String> _getPathImages() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  String fullPath = dir + '/Categories/';
  return fullPath;
}

Future<void> _createFile(String path, String bytesString) async {
  io.File file = await io.File(path).create(recursive: true);
  file.writeAsStringSync(bytesString);
}

Future<String> getImagePathFile(String name, String bytesString) async {
  String pathImages=await _getPathImages();
  io.File file = io.File(pathImages + name + '.txt');
  _createFile(file.path, bytesString);
  return file.path;
}

String _getImageBytesFromFile(String pathFile)
{
  io.File file = io.File(pathFile);
  return file.readAsStringSync();
}
Uint8List getImageBytes(String imageUrl){
  return base64Decode(_getImageBytesFromFile(imageUrl));
}
