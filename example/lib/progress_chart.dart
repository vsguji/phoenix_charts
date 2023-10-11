/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2023-10-11 17:31:01
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-11 17:31:49
 * @FilePath: /phoenix_charts/example/lib/progress_chart.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_charts/phoenix_charts.dart';

class ProgressChartExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProgressChartExampleState();
  }
}

class ProgressChartExampleState extends State<ProgressChartExample> {
  double count = 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 44,
        ),
        ProgressChart(
          width: 300,
          height: 20,
          value: count,
          duration: const Duration(milliseconds: 500),
          colors: const [Colors.lightBlueAccent, Colors.blue],
          backgroundColor: Colors.grey,
          showAnimation: true,
          isFromLastValue: true,
          progressIndicatorBuilder: (BuildContext context, double value) {
            return Text(
              '自定义：$value',
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('进度'),
            ),
            Expanded(
              child: Slider(
                  value: count,
                  divisions: 10,
                  onChanged: (data) {
                    if (!mounted) return;
                    setState(() {
                      count = data;
                    });
                  },
                  onChangeStart: (data) {},
                  onChangeEnd: (data) {},
                  min: 0,
                  max: 1,
                  label: '$count',
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '$newValue';
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
