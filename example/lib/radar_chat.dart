import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phoenix_charts/phoenix_charts.dart';

class RadarChartExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RadarChartExampleState();
  }
}

class _RadarChartExampleState extends State<RadarChartExample>
    with SingleTickerProviderStateMixin {
  late double radius;
  int? sideCount;
  double? angle;
  late double padding;
  Map<String, List<double>> dataList1 = Map();

  Map<String, List<double>> dataList2 = Map();

  late AnimationController controller;
  late Animation<double> animation;
  bool defaultStyle = true;

  @override
  void initState() {
    super.initState();
    radius = 80;
    sideCount = 6;
    padding = 4;
    angle = 0;
    for (int i = 3; i <= 8; i++) {
      List<double> data1 = [];
      List<double> data2 = [];

      for (int j = 0; j < i; j++) {
        data1.add(Random().nextDouble() * 10);
        data2.add(Random().nextDouble() * 10);
      }
      dataList1[i.toString()] = data1;
      dataList2[i.toString()] = data2;
    }
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = Tween(begin: 0.0, end: 1.0).animate(animation);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
            animation: animation,
            builder: (_, __) {
              if (defaultStyle) {
                return RadarChart.defaultStyle(
                  radius: radius,
                  sidesCount: 5,
                  markerMargin: padding,
                  rotateAngle: angle! * 2 * pi / 360,
                  data: [
                    dataList1[sideCount.toString()]!,
                    dataList2[sideCount.toString()]!
                  ],
                  tagNames: const [
                    '合作共赢诚实守信',
                    '合作共赢诚实守信',
                    '合作共赢诚实守信',
                    '合作共赢诚实守信',
                    '合作共赢诚实守信'
                  ],
                );
              } else {
                return RadarChart(
                  radius: radius,
                  provider: RadarProvider(sideCount, dataList1, dataList2),
                  sidesCount: sideCount!,
                  markerMargin: padding,
                  crossedAxisLine: true,
                  rotateAngle: angle! * 2 * pi / 360,
                  animateProgress: animation.value,
                  builder: (index) {
                    return Text(
                      '顶点${index.toString()}',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    );
                  },
                );
              }
            }),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('半径'),
            ),
            Expanded(
              child: Slider(
                  value: radius,
                  divisions: 100,
                  onChanged: (data) {
                    setState(() {
                      radius = data;
                    });
                    debugPrint('change:$data');
                  },
                  onChangeStart: (data) {
                    debugPrint('start:$data');
                  },
                  onChangeEnd: (data) {
                    debugPrint('end:$data');
                  },
                  min: 1,
                  max: 150,
                  label: radius.toStringAsFixed(0),
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}}';
                  }),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('标签间距'),
            ),
            Expanded(
              child: Slider(
                  value: padding,
                  divisions: 10,
                  onChanged: (data) {
                    setState(() {
                      padding = data;
                    });
                    debugPrint('change:$data');
                  },
                  onChangeStart: (data) {
                    debugPrint('start:$data');
                  },
                  onChangeEnd: (data) {
                    debugPrint('end:$data');
                  },
                  min: 0,
                  max: 10,
                  label: padding.toStringAsFixed(0),
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}}';
                  }),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('边数'),
            ),
            Expanded(
              child: Slider(
                  value: sideCount!.toDouble(),
                  divisions: 6,
                  onChanged: (data) {
                    if (data.toInt() != sideCount) {
                      setState(() {
                        sideCount = data.toInt();
                        controller.reset();
                        controller.forward();
                      });
                    }
                  },
                  onChangeStart: (data) {
                    debugPrint('start:$data');
                  },
                  onChangeEnd: (data) {
                    debugPrint('end:$data');
                  },
                  min: defaultStyle ? sideCount!.toDouble() : 3,
                  max: defaultStyle ? sideCount!.toDouble() : 8,
                  label: sideCount!.toStringAsFixed(0),
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}}';
                  }),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('旋转角度'),
            ),
            Expanded(
              child: Slider(
                  value: angle!.toDouble(),
                  divisions: 360,
                  onChanged: (data) {
                    if (data.toDouble() != angle) {
                      setState(() {
                        angle = data.toDouble();
                        controller.reset();
                        controller.forward();
                      });
                    }
                  },
                  onChangeStart: (data) {
                    debugPrint('start:$data');
                  },
                  onChangeEnd: (data) {
                    debugPrint('end:$data');
                  },
                  min: 0,
                  max: 360,
                  label: angle!.toStringAsFixed(0),
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}}';
                  }),
            ),
          ],
        ),
        MaterialButton(
          onPressed: () {
            setState(() {
              sideCount = 5;
              defaultStyle = !defaultStyle;
            });
          },
          color: Colors.orange,
          child: Text(defaultStyle ? '使用自定义风格' : '使用默认风格'),
        )
      ],
    );
  }
}

class RadarProvider extends RadarChartDataProvider {
  final Map<String, List<double>> dataList1;

  final Map<String, List<double>> dataList2;

  final int? sideCount;

  RadarProvider(this.sideCount, this.dataList1, this.dataList2);

  @override
  int getRadarCount() {
    return 2;
  }

  @override
  RadarChartStyle getRadarStyle(int radarIndex) {
    switch (radarIndex) {
      case 0:
        return const RadarChartStyle(
          strokeColor: Colors.blue,
          areaColor: Color(0x332196F3),
          dotted: true,
          dotColor: Colors.blue,
        );
      case 1:
        return const RadarChartStyle(
          strokeColor: Colors.green,
          areaColor: Color(0x334CAF50),
          dotted: true,
          dotColor: Colors.green,
        );
    }
    return const RadarChartStyle(
      strokeColor: Colors.blue,
      strokeWidth: 1,
      areaColor: Color(0x332196F3),
      dotted: true,
      dotColor: Colors.blue,
      dotRadius: 2,
    );
  }

  @override
  List<double> getRadarValues(int radarIndex) {
    switch (radarIndex) {
      case 0:
        return dataList1[sideCount.toString()]!;
      case 1:
        return dataList2[sideCount.toString()]!;
    }
    return dataList1[sideCount.toString()]!;
  }
}
