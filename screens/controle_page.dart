import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lock_app/screens/menu_page.dart';
import 'package:lock_app/screens/perfis_page.dart';
import 'package:lock_app/screens/travar_page.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ControlePage extends StatefulWidget {
  const ControlePage({super.key});

  @override
  State<ControlePage> createState() => _ControlePageState();
}

class _ControlePageState extends State<ControlePage> {
  
  final VolumeController _volumeController = VolumeController.instance;
  
  double _currentVolume = 0.0;
  double _currentBrightness = 0.5;
  
  
  StreamSubscription<double>? _volumeSubscription;

  @override
  void initState() {
    super.initState();
    _initVolume();
    _initBrightness();
  }

  void _initVolume() {
    _volumeController.getVolume().then((volume) {
      if (mounted) {
        setState(() {
          _currentVolume = volume;
        });
      }
    });

    _volumeController.addListener((volume) {
      if (mounted) {
        setState(() {
          _currentVolume = volume;
        });
      }
    });
  }

  
  void _initBrightness() async {
    try {
      
      double brightness = await ScreenBrightness.instance.application;
      if (mounted) {
        setState(() {
          _currentBrightness = brightness;
        });
      }
    } catch (e) {
      debugPrint("Erro ao obter brilho: $e");
    }
  }

  void _updateVolume(double value) {
    _volumeController.setVolume(value);
    if (mounted) {
      setState(() {
        _currentVolume = value;
      });
    }
  }

  
  void _updateBrightness(double value) async {
    try {
     
      await ScreenBrightness.instance.setApplicationScreenBrightness(value);
      if (mounted) {
        setState(() {
          _currentBrightness = value;
        });
      }
    } catch (e) {
      debugPrint("Erro ao definir brilho: $e");
    }
  }

  @override
  void dispose() {
    _volumeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 4, 54, 79),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 41, 131, 181),
        iconSize: 30,

        type: BottomNavigationBarType.fixed,
        items: [

          BottomNavigationBarItem(
            
           icon: IconButton(
            onPressed: (){
              Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                      ),
                    );
            }, 
            icon: Icon(Icons.home),
            ),
            label: "home",
          ),

          BottomNavigationBarItem(

            icon: IconButton(onPressed: (){
              Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => PerfisPage(),
                      ),
                    );
            }, 
            icon: Icon(Icons.person),
            ),
            label: "Perfis"
          ),

          BottomNavigationBarItem(
            
            icon: IconButton(onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => TravarPage(),
                  ),
                );
            }, 
            icon: Icon(Icons.feed_outlined),
            ),
            label: "Apps"
          ),
          
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => ControlePage(),
                  ),
                );
            }, 
            icon: Icon(Icons.settings),
            ),
            label: "Comntroles"
          ),

        ],
        ),

      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // --- CONTROLE DE VOLUME ---
              
              Card(
                elevation: 4,
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            _currentVolume == 0 
                                ? Icons.volume_mute 
                                : _currentVolume < 0.5 
                                    ? Icons.volume_down 
                                    : Icons.volume_up,
                            color: Colors.blue,
                          ),
                           SizedBox(width: 10),
                           Text(
                            "Volume do Dispositivo",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Slider(
                        value: _currentVolume,
                        min: 0.0,
                        max: 1.0,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue,
                        onChanged: _updateVolume,
                      ),
                      Text("${(_currentVolume * 100).toStringAsFixed(0)}%"),
                    ],
                  ),
                ),
              ),

               SizedBox(height: 25),

              // --- CONTROLE DE BRILHO ---

              Card(
                elevation: 4,
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            _currentBrightness < 0.3 
                                ? Icons.brightness_low 
                                : _currentBrightness < 0.7 
                                    ? Icons.brightness_medium 
                                    : Icons.brightness_high,
                            color: Colors.orange,
                          ),
                           SizedBox(width: 10),
                           Text(
                            "Brilho da Tela",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Slider(
                        value: _currentBrightness,
                        min: 0.0,
                        max: 1.0,
                        activeColor: Colors.orange,
                        inactiveColor: Colors.orange,
                        onChanged: _updateBrightness,
                      ),
                      Text("${(_currentBrightness * 100).toStringAsFixed(0)}%"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}