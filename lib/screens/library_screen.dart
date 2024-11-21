import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:musicplayer/widgets/drawer.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _drawerController = AdvancedDrawerController();
  final player = AudioPlayer();
  List<FileSystemEntity> audioFiles = [];
  bool isLoading = false;

  Future<void> listAudioFile() async {
    if (await Permission.storage.request().isGranted) {
      try {
        String storagePath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_MUSIC);

        if (storagePath.isNotEmpty) {
          List<FileSystemEntity> files = Directory(storagePath)
              .listSync(recursive: true)
              .where((file) => file is File && file.path.endsWith('.mp3'))
              .toList();

          setState(() {
            audioFiles = files;
            isLoading = false;
          });
        }
      } catch (e) {
        //print('Erro ao listar arquivos: $e');
      }
    } else {
      //print('Permissão de armazenamento negada.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BuildDrawer(
      drawerController: _drawerController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Biblioteca'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _drawerController.showDrawer(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 24),
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await listAudioFile();
                },
                child: const Text("Listar Músicas"),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await player.play(
                                  UrlSource(audioFiles[index].uri.toString()));
                            },
                            child: ListTile(
                              title:
                                  Text(audioFiles[index].path.split('/').last),
                              subtitle: Text(audioFiles[index].uri.toString()),
                            ),
                          );
                        },
                        itemCount: audioFiles.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
