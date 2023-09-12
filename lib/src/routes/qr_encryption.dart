import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:InstiApp/src/utils/title_with_backbutton.dart';

import 'package:encrypt/encrypt.dart';

import 'dart:convert';
import '../api/model/user.dart';

class QREncryption {
  User? user;
  String? number;
  QREncryption() {
     number = user!.userRollNumber;
  }
  void Encrypt(){
    final time= DateTime.now().toString();
    final message=time + number!;
    final key= Key.fromUtf8('KeyOfLength32characters.........');
    final b64key = Key.fromBase64(base64Url.encode(key.bytes));
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);
    final encrypted = encrypter.encrypt(message);
  }

}