import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/lib/domain/bloc/bloc/bloc/record_bloc_bloc.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    recor;

    super.initState();
  }

  @override
  void dispose() {
    recor.dispose();
    play.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Voice Recorder'),
        ),
        body: CustomBody());
  }
}

class CustomBody extends StatefulWidget {
  CustomBody({
    super.key,
  });

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    path;
    // final recor = context.watch<RecorderVoice>();
    return Column(
      children: [
        Center(
          child: BlocProvider(
            create: (context) => RecordBlocBloc(),
            child: BlocBuilder<RecordBlocBloc, RecordBlocState>(
              builder: (context, state) {
                return Tooltip(
                  message: 'Graba audio',
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<RecordBlocBloc>(context).add(
                        Recorder(),
                      );
                    },
                    child: const Icon(Icons.mic),
                  ),
                );
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            final play = RecordBlocBloc();
            play.reproducerAudio();
          },
          icon: const Icon(Icons.play_arrow),
        )
      ],
    );
  }
}
