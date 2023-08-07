// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_print, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 4)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter EasyLoading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter EasyLoading'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(),
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: Text('open test page'),
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TestPage(),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: Text('dismiss'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.dismiss();
                      print('EasyLoading dismiss');
                    },
                  ),
                  TextButton(
                    child: Text('show'),
                    onPressed: () async {
                      // _timer?.cancel();
                      await EasyLoading.show(
                        dismissOnTap: true,
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      // await EasyLoading.dismiss();
                      print('EasyLoading show');
                    },
                  ),
                  TextButton(
                    child: Text('showToast'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showToast(
                        'Toast',
                      );
                    },
                  ),
                  TextButton(
                    child: Text('showSuccess'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.showSuccess('Great Success!');
                      print('EasyLoading showSuccess');
                    },
                  ),
                  TextButton(
                    child: Text('showError'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showError('Failed with Error');
                    },
                  ),
                  TextButton(
                    child: Text('showInfo'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showInfo('Useful Information.');
                    },
                  ),
                  TextButton(
                    child: Text('showProgress'),
                    onPressed: () {
                      _progress = 0;
                      _timer?.cancel();
                      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
                        EasyLoading.showProgress(_progress, status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress += 0.03;

                        if (_progress >= 1) {
                          _timer?.cancel();
                          EasyLoading.dismiss();
                        }
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Style'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingStyle.dark: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('dark'),
                          ),
                          EasyLoadingStyle.light: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('light'),
                          ),
                          EasyLoadingStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.loadingStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('MaskType'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingMaskType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingMaskType.none: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('none'),
                          ),
                          EasyLoadingMaskType.clear: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('clear'),
                          ),
                          EasyLoadingMaskType.black: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('black'),
                          ),
                          EasyLoadingMaskType.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.maskType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Toast Positon'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingToastPosition>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingToastPosition.top: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('top'),
                          ),
                          EasyLoadingToastPosition.center: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('center'),
                          ),
                          EasyLoadingToastPosition.bottom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('bottom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.toastPosition = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Animation Style'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingAnimationStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingAnimationStyle.opacity: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('opacity'),
                          ),
                          EasyLoadingAnimationStyle.offset: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('offset'),
                          ),
                          EasyLoadingAnimationStyle.scale: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('scale'),
                          ),
                          EasyLoadingAnimationStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.animationStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              IndicatorSelection()
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorSelection extends StatelessWidget {
  final List<String> indicatorLabels = [
    'fadingCircle',
    'circle',
    'threeBounce',
    'chasingDots',
    'wave',
    'wanderingCubes',
    'rotatingPlain',
    'doubleBounce',
    'fadingFour',
    'fadingCube',
    'pulse',
    'cubeGrid',
    'rotatingCircle',
    'foldingCube',
    'pumpingHeart',
    'dualRing',
    'hourGlass',
    'pouringHourGlass',
    'fadingGrid',
    'ring',
    'ripple',
    'spinningCircle',
    'squareCircle',
  ];
  final List<EasyLoadingIndicatorType> indicators = [
    EasyLoadingIndicatorType.fadingCircle,
    EasyLoadingIndicatorType.circle,
    EasyLoadingIndicatorType.threeBounce,
    EasyLoadingIndicatorType.chasingDots,
    EasyLoadingIndicatorType.wave,
    EasyLoadingIndicatorType.wanderingCubes,
    EasyLoadingIndicatorType.rotatingPlain,
    EasyLoadingIndicatorType.doubleBounce,
    EasyLoadingIndicatorType.fadingFour,
    EasyLoadingIndicatorType.fadingCube,
    EasyLoadingIndicatorType.pulse,
    EasyLoadingIndicatorType.cubeGrid,
    EasyLoadingIndicatorType.rotatingCircle,
    EasyLoadingIndicatorType.foldingCube,
    EasyLoadingIndicatorType.pumpingHeart,
    EasyLoadingIndicatorType.dualRing,
    EasyLoadingIndicatorType.hourGlass,
    EasyLoadingIndicatorType.pouringHourGlass,
    EasyLoadingIndicatorType.fadingGrid,
    EasyLoadingIndicatorType.ring,
    EasyLoadingIndicatorType.ripple,
    EasyLoadingIndicatorType.spinningCircle,
    EasyLoadingIndicatorType.squareCircle,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text('IndicatorType(total: 23)'),
          IndicatorSegment(
            indicators: indicators,
            indicatoesLabels: indicatorLabels,
          ),
        ],
      ),
    );
  }
}

class IndicatorSegment extends StatelessWidget {
  final List indicators;
  final List indicatoesLabels;

  IndicatorSegment({required this.indicators, required this.indicatoesLabels});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 300,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 8),
          ),
          itemCount: indicatoesLabels.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () async {
                EasyLoading.instance.indicatorType = indicators[index];
                await EasyLoading.show(
                  dismissOnTap: true,
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                );
              },
              child: Center(
                child: Text(
                  indicatoesLabels[index],
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    // EasyLoading.dismiss();
    EasyLoading.showSuccess('Use in initState');
    EasyLoading.addStatusCallback(statusCallback);
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    EasyLoading.removeCallback(statusCallback);
    super.deactivate();
  }

  void statusCallback(EasyLoadingStatus status) {
    print('Test EasyLoading Status $status');
  }

  void loadData() async {
    try {
      await EasyLoading.show();
      HttpClient client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse('https://github.com'));
      HttpClientResponse response = await request.close();
      print(response);
      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.showError(e.toString());
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: TextButton(
          child: Text('loadData'),
          onPressed: () {
            EasyLoading.show(status: '加载中...');
            // loadData();
            // await Future.delayed(Duration(seconds: 2));
            // EasyLoading.show(status: 'loading...');
            // await Future.delayed(Duration(seconds: 5));
            // EasyLoading.dismiss();
          },
        ),
      ),
    );
  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
