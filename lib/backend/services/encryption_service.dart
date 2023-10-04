// Generic Imports
import 'package:encrypt/encrypt.dart';

// Backend imports
import 'package:mindwaves/backend/privates/encryption_key.dart';

class EncryptionService {
  Map<String, String> encryptText(String text) {
    IV iv = IV.fromLength(16);
    String encryptedText =
        Encrypter(AES(encryptionKey)).encrypt(text, iv: iv).base64;

    return {encryptedText: iv.base64};
  }

  String decryptText(String text, String iv) {
    String decryptedText =
        Encrypter(AES(encryptionKey)).decrypt64(text, iv: IV.fromBase64(iv));

    return decryptedText;
  }
}
