// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class Settings extends HookWidget {
//   const Settings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         body: Center(
//       child: Text("Rishad"),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Drawer/drawer.dart';
import 'Componet/ListtileCard.dart';
import 'Componet/Provider/value.dart';
import 'Componet/slider/Sensitivityslider.dart';
import 'Componet/slider/loadSlider.dart';
import 'Componet/slider/resolveslider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      // drawer: Drawer(child: Drawerr()),
      body: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Column(
          children: [
            ListTileCard(
              trailing: "",
              OnTap: () => null,
              title: "Select Theme",
            ),
            ListTileCard(
              trailing: "${context.watch<loadValue>().lvalue}",
              title: "Max Image Load Buffer",
              OnTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Material(
                            child: Container(
                              color: Colors.white,
                              height: 150.0,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Max Image Load Buffer",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    loadSlider(
                                      min: 20,
                                      max: 100,
                                      interval: 10,
                                      step: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
            ),
            ListTileCard(
              trailing: "${context.watch<ResolveValue>().rvalue}",
              title: "Max Image Resolve Buffer",
              OnTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Material(
                            child: Container(
                              color: Colors.white,
                              height: 150.0,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Max Image Resolve Buffer",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    ResolveSlider(
                                      min: 4,
                                      max: 20,
                                      interval: 2,
                                      step: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
            ),
            ListTileCard(
              trailing: "${context.watch<SensitivityValue>().svalue}",
              title: "Sensitivity",
              OnTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Material(
                            child: Container(
                              color: Colors.white,
                              height: 150.0,
                              width: 300,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Sensitivity",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    SensitivitySlider(
                                      min: 1,
                                      max: 30,
                                      interval: 4,
                                      step: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
