import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:InstiApp/src/utils/title_with_backbutton.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import '../api/model/user.dart';

class QREncryption {
  User? user;
  String? number;
  QREncryption() {
     // number = user?.userRollNumber!= null? user?.userRollNumber : 'Error' ;
    number="210020002";
  }
  String Encrypt(){
    print(number);
    final time= DateTime.now().toString();
    final message=number!+','+time;
    print(message);
    final key= Key.fromBase64('Tolm_fRDkfoN5WMU4oUXWxNwmn1E0MmYlbeh1LA29cU=');
    final b64key = Key.fromBase64(base64Url.encode(key.bytes));
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);
    final encrypted = encrypter.encrypt(message);

    print(encrypted!.base64);
    return encrypted!.base64;
  }

}