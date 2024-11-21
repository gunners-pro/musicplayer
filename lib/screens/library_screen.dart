import 'dart:io';

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

  Future<bool> checkAndRequestStoragePermission() async {
    var status = await Permission.audio.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.audio.request();
    }

    return status.isGranted;
  }

  Future<void> listAudioFile() async {
    if (await checkAndRequestStoragePermission()) {
      Directory directory = Directory('/storage/emulated/0');

      if (await directory.exists()) {
        List<FileSystemEntity> files = directory.listSync(recursive: true);
        List<String> audiofiles = files
            .where((file) =>
                file is File &&
                ['.mp3'].contains(file.path.split('.').last.toLowerCase()))
            .map((file) => file.path)
            .toList();

        debugPrint("files: $files");
        debugPrint("directory: $directory");
        debugPrint("Arquivos: $audiofiles");
      } else {
        debugPrint("Diretório nao encontrado.");
      }
    } else {
      debugPrint("Permissão negada para acessar o armazenamento.");
    }
  }

  @override
  void initState() {
    super.initState();

    listAudioFile();
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
          child: const Column(
            children: [
              Text(
                "Biblioteca",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
