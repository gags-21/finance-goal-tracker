import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialExpenseTracker extends StatelessWidget {
  const RadialExpenseTracker({
    super.key,
    required this.icon,
    required this.totalTarget,
    required this.completedTarget,
  });
  final IconData icon;
  final int totalTarget;
  final int completedTarget;

  @override
  Widget build(BuildContext context) {
    double percent = totalTarget != 0 ? (completedTarget / totalTarget) * 100 : 0;
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.1,
            cornerStyle: CornerStyle.bothCurve,
            color: Color.fromARGB(30, 152, 152, 152),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: percent,
              cornerStyle: CornerStyle.bothCurve,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              color: const Color.fromARGB(255, 255, 255, 255),
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 100,
                    ),
                     Text(
                      "\$ $completedTarget",
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const Text(
                      "You Saved",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ],
    );
  }
}
