import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hi, Name",
                    style: const TextTheme().bodyMedium,
                  ),
                  Text(
                    "Current Savings ",
                    style: const TextTheme().bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                height: 200,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: [
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Color.fromARGB(30, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: const <GaugePointer>[
                        RangePointer(
                          value: 70,
                          cornerStyle: CornerStyle.bothCurve,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color.fromARGB(255, 1, 51, 91),
                        )
                      ],
                      annotations: const <GaugeAnnotation>[
                        GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "\$ 20",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                Text("SPENT"),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
