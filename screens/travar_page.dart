import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:lock_app/services/app_preferences.dart';

class TravarPage extends StatefulWidget {
  const TravarPage({super.key});

  @override
  State<TravarPage> createState() => _TravarPageState();
}

class _TravarPageState extends State<TravarPage> {
  List<String> _listaBloqueadosLocal = [];

  @override
  void initState() {
    super.initState();
    _listaBloqueadosLocal = AppPreferences.blockedApps;
  }

  void _alternarBloqueioApp(String packageName, bool deveBloquear) async {
    setState(() {
      if (deveBloquear) {
        if (!_listaBloqueadosLocal.contains(packageName)) {
          _listaBloqueadosLocal.add(packageName);
        }
      } else {
        _listaBloqueadosLocal.remove(packageName);
      }
    });

    await AppPreferences.setBlockedApps(_listaBloqueadosLocal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<AppInfo>>(
        
        future: InstalledApps.getInstalledApps(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 41, 131, 181),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum aplicativo encontrado.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          
          List<AppInfo> apps = snapshot.data!
              .where((app) => app.packageName.isNotEmpty)
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              AppInfo app = apps[index];
              
              String packageId = app.packageName; 

              bool isAppBlocked = _listaBloqueadosLocal.contains(packageId);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: app.icon != null
                      ? Image.memory(app.icon!, width: 40)
                      : const Icon(Icons.android, size: 40, color: Colors.green),
                  // Removido o "?? App sem nome" pois o nome agora é garantido
                  title: Text(
                    app.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    packageId,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Switch(
                    activeThumbColor: Color.fromARGB(255, 41, 131, 181),
                    value: isAppBlocked,
                    onChanged: (bool valor) {
                      _alternarBloqueioApp(packageId, valor);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}