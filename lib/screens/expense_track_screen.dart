import 'package:expense_track/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              // Radial progress
              const Text(
                "Buy Dream House",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 300,
                width: 300,
                child: RadialExpenseTracker(
                  icon: Icons.home_filled,
                ),
              ),

              // Goal / Finance info
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Goal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "by Jan 2030",
                          style: TextStyle(color: Colors.white38),
                        ),
                      ],
                    ),
                    Text(
                      "\$ 50,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 120,
                color: Colors.white10,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More to go!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "Prediction",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$ 30,000",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "\$ 300",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RadialExpenseTracker extends StatelessWidget {
  const RadialExpenseTracker({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
          pointers: const <GaugePointer>[
            RangePointer(
              value: 70,
              cornerStyle: CornerStyle.bothCurve,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              color: Color.fromARGB(255, 255, 255, 255),
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
                    const Text(
                      "\$ 1000",
                      style: TextStyle(fontSize: 30, color: Colors.white),
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
