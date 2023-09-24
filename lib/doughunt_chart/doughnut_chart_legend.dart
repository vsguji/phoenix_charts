import 'package:flutter/material.dart';

import 'doughnut_chart.dart';

/// 排列方式
enum DoughnutChartLegendStyle {
  /// 横向排列式
  wrap,

  /// 竖向列表式
  list,
}

/// DoughnutChartLegend 组件的图例
/// 饼状图、环状图展示所使用的图例
/// [legendStyle] 图例的样式
/// [data] 图例数据
class DoughnutChartLegend extends StatelessWidget {
  /// [options] 图例的样式
  /// wrap: 横向排列
  /// list: 纵向排列
  /// 默认值为 wrap
  final DoughnutChartLegendStyle legendStyle;

  /// 图例展示所用数据
  final List<DoughnutDataItem> data;

  /// create DoughnutChartLegend
  DoughnutChartLegend(
      {this.legendStyle = DoughnutChartLegendStyle.wrap, required this.data});

  @override
  Widget build(BuildContext context) {
    if (DoughnutChartLegendStyle.list == legendStyle) {
      List<Widget> items = [];
      data.forEach((DoughnutDataItem item) {
        items.add(_genItem(item));
      });
      return Column(
        children: items,
      );
    } else if (DoughnutChartLegendStyle.wrap == legendStyle) {
      List<Widget> items = [];
      data.forEach((DoughnutDataItem item) {
        items.add(_genItem(item));
      });

      return Wrap(
        direction: Axis.horizontal,
        spacing: 20,
        children: items,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _genItem(DoughnutDataItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(1.5)),
          child: Container(
            width: 12,
            height: 3,
            color: item.color,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          item.title,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
