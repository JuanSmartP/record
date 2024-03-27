// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:widgets/lib/domain/peticiones/audio.dart';

part 'record_bloc_event.dart';

part 'record_bloc_state.dart';

//  '/data/user/0/com.example.widgets/cache/${date}myFile.m4a';

String path = '';
bool isRecording = false;
bool isPlaytin = false;
final recor = AudioRecorder();

final play = AudioPlayer();

class RecordBlocBloc extends Bloc<RecordBlocEvent, RecordBlocState> {
  RecordBlocBloc() : super(Recording()) {
    on<RecordBlocEvent>((event, emit) {
      recordpanicaudio();
    });
  }

  //Funcion para iniciar y detener la grabacion
  Future<void> recordpanicaudio() async {
    String customPath =
        await getApplicationDocumentsDirectory().then((value) => value.path);

    final date = DateTime.now().millisecond;

    path = '$customPath/${date}myfile.m4a';

    print(' PATH ======>>>>>>>> $path');

    if (!isRecording && await recor.hasPermission()) {
      //await recor.startStream(RecordConfig());
      await recor.start(const RecordConfig(), path: path);

      /// path: '/data/user/0/com.example.widgets/cache/${date}myFile.m4a');
      ///  print(
      ///   'PATH ========================================>>>>>>>> $customPath');

      setTimeOut();
    }

    isRecording = !isRecording;
  }

  void setTimeOut() {
    const durarion = Duration(seconds: 20);
    Timer(durarion, () async {
      final pathStop = await recor.stop();
      recor.stop();
      print('PATH DEL STOP ====================> $pathStop');
      isRecording = false;

      print('PATH TO CONVERT BASE64 ====================>>> $pathStop');
      convertBase64(pathStop);
      print('SE DETIENE LA GRABACION');
    });
  }

//Convertir audio a base64
  Future<void> convertBase64(pathBase64) async {
    if (pathBase64 != null) {
      File file = File(pathBase64);
      file.openRead();
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64.encode(fileBytes);

      // log(' BASE64====> data:audio/mp3;base64,$base64String');

      final peticiones = Peticiones();
      peticiones.sendAudio('data:audio/mp3base64,$base64String');
    } else {
      print('No Path');
    }
  }

  Future<void> reproducerAudio() async {
    if (!isPlaytin) {
      await play.setUrl(path);
      play.play();

      isPlaytin = !isPlaytin;
    } else {
      await play.stop();
    }
    isPlaytin = !isPlaytin;
  }
}
