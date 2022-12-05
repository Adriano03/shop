//Usado para persistência de dados, caso o usuário logado saia da aplicação..
//..quando voltar os usuário voltara logado com todos os dados;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  //Salvar String
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  //Salvar Map;
  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    //Transformar Map em json;
    return saveString(key, jsonEncode(value));
  }

  //Obter String;
  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  //Obter Map;
  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      //Transformar json em Map;
      return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
