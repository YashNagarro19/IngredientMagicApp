import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI/O")),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0 , vertical: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text('About the app\n ', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 10,),
              Text(
                  '-You can see how your food is good for your health and what kind of data you can avoid.\n\n-Just take a picture for product components',
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraPage(cameras: value))));
                },
                child: const Text("Let's start"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
