// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

/// The code includes functions to send audio files to a server and retrieve audio files from a server
/// using HTTP requests in Dart.
///
/// Args:
///   audioFile: The `audioFile` parameter in the `sendAudio` function should be the audio file that you
/// want to upload to the server. It could be the path to the audio file on your device or the actual
/// audio data that you want to send.

class Peticiones {
//Enviar audio al servidor
  Future<void> sendAudio(audioFile) async {
    final url = Uri.parse(
        'https://www.bibloplus.com/~biblop/webservice/EndSubir/upload-file.php');

    final response = await http.post(
      url,
      body: {'data': audioFile, 'codigo': 'ID'},
    );

    print('Archivo Subido con exito  ${response.statusCode}');
  }
}
