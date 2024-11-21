import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:musicplayer/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BuildDrawer(
      drawerController: _drawerController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _drawerController.showDrawer(),
          ),
        ),
      ),
    );
  }
}
