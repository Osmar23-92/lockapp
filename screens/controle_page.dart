import 'dart:async';
import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:lock_app/services/user_data.dart';


class ControlePage extends StatefulWidget {
  const ControlePage({super.key});

  @override
  State<ControlePage> createState() => _ControlePageState();
}

class _ControlePageState extends State<ControlePage> {
  
  final VolumeController _volumeController = VolumeController.instance;
  final TextEditingController _senhaConfimaController = TextEditingController();


  double _currentVolume = 0.0;
  double _currentBrightness = 0.5;
  bool _isLocked = false;
  
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
    if (_isLocked) return;
    _volumeController.setVolume(value);
    if (mounted) {
      setState(() {
        _currentVolume = value;
      });
    }
  }

  
  void _updateBrightness(double value) async {
    if (_isLocked) return;
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


    void _exibeDialogoDsetravar(){
      _senhaConfimaController.clear();

      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Dsebloquear controles",
              style: TextStyle(
                color: Color.fromARGB(255, 4, 54, 79),
                fontWeight: FontWeight.bold
               ),
              ),
              content: TextField(
                controller: _senhaConfimaController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock,
                  color: Color.fromARGB(255, 41, 131, 181)
                  ),
                  labelText: "Digite sua senha de login:",
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 54, 79),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

            actions: [
              TextButton(
                onPressed: () =>  Navigator.pop(context), 
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: Colors.red),),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 41, 131, 181),
                      ),
                      onPressed: () {
                        final senhaDigitada = _senhaConfimaController.text.trim();

                        if (senhaDigitada == UserData.senhaCadastrada) {
                          setState(() {
                            _isLocked = false;
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Controles liberados!"),
                            backgroundColor: Colors.green),
                          ); 
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Senha incorreta!"),
                            backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }, 
                      child: Text("Confirmar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 54, 79),
                        ),
                       ),
                     ),
             ],  

            );
           },
         );
    }



  @override
  void dispose() {
    _volumeSubscription?.cancel();
    super.dispose();
  }

       @override
       Widget build(BuildContext context) {
    
      return Center(
        
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if (_isLocked)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_clock_outlined,
                      color: Colors.red,
                      size: 28,),
                      SizedBox(width: 8),

                      Text("Controles bloqueados",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                       ),
                      ),
                    ],
                   ),
                  ),

              //  CONTROLE DE VOLUME 
              
              Card(
                elevation: 4,
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 10,
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
                        onChanged:  _isLocked ? null : _updateVolume,
                      ),
                      Text("${(_currentVolume * 100).toStringAsFixed(0)}%"),
                    ],
                  ),
                ),
              ),

             

              //  CONTROLE DE BRILHO

              Card(
                elevation: 4,
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 10,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16),
                          ),
                        ],
                      ),
                      Slider(
                        value: _currentBrightness,
                        min: 0.0,
                        max: 1.0,
                        activeColor: Colors.orange,
                        inactiveColor: Colors.orange,
                        onChanged: _isLocked ? null : _updateBrightness,
                      ),
                      Text("${(_currentBrightness * 100).toStringAsFixed(0)}%"),
                    ],
                  ),
                ),
              ),

                SizedBox(width: 40,),

                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isLocked
                      ? Colors.red
                      : Color.fromARGB(255, 4, 54, 79),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                    ),
                    onPressed: (){
                      if (_isLocked) {
                        _exibeDialogoDsetravar();
                      } else {
                        setState(() {
                          _isLocked = true;
                        },
                      );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Controles bloqueados!",
                            ),
                        backgroundColor: Colors.amber,
                         ),
                        );
                      }
                    }, 
                    icon: Icon(_isLocked ? Icons.lock_open : Icons.lock,
                    color: Colors.white,
                    size: 24,
                    ),

                    label: Text(
                     _isLocked ? "DESTRAVAR AJUSTES" : "TRAVAR AJUSTES",
                    style: TextStyle( color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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