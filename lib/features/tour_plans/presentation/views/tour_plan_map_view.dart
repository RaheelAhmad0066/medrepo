import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medrep_pro/features/doctors/presentation/providers/doctor_providers.dart';
import 'package:medrep_pro/features/chemists/presentation/providers/chemist_providers.dart';
import 'package:medrep_pro/features/tour_plans/domain/entities/tour_plan.dart';
import 'package:medrep_pro/features/tour_plans/presentation/providers/tour_plan_providers.dart';

class TourPlanMapView extends ConsumerStatefulWidget {
  final TourPlan tourPlan;

  const TourPlanMapView({super.key, required this.tourPlan});

  @override
  ConsumerState<TourPlanMapView> createState() => _TourPlanMapViewState();
}

class _TourPlanMapViewState extends ConsumerState<TourPlanMapView> {
  bool _simulateDeviation = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tourPlanStopsProvider(widget.tourPlan.id));
    final docState = ref.watch(doctorListProvider);
    final chemState = ref.watch(chemistListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Tracking & Check-In'),
        actions: [
          Row(
            children: [
              const Text('Simulate Deviation', style: TextStyle(fontSize: 12)),
              Switch(
                value: _simulateDeviation,
                onChanged: (val) {
                  setState(() {
                    _simulateDeviation = val;
                  });
                },
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey.shade900,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _MapCanvasPainter(
                        stops: state.stops,
                        repPosition: const Offset(150, 320),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Card(
                      color: Colors.black87,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('ROUTE LEDGER MAP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('• Blue Dot: Your Position', style: TextStyle(color: Colors.cyan, fontSize: 11)),
                            Text('• Numbers: Stops Order', style: TextStyle(color: Colors.white70, fontSize: 11)),
                            Text('• Green Lines: Optimized Route Path', style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 10, spreadRadius: 2),
              ],
            ),
            child: state.stops.isEmpty
                ? const Center(child: Text('No route stops scheduled.'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(12),
                    itemCount: state.stops.length,
                    itemBuilder: (context, index) {
                      final stop = state.stops[index];

                      String name = 'Stop';
                      String typeLabel = stop.targetType;

                      if (stop.targetType == 'Doctor') {
                        final doc = docState.doctors.firstWhere(
                          (d) => d.id == stop.targetId,
                          orElse: () => _dummyDoc(),
                        );
                        name = 'Dr. ${doc.name}';
                      } else {
                        final chem = chemState.chemists.firstWhere(
                          (c) => c.id == stop.targetId,
                          orElse: () => _dummyChem(),
                        );
                        name = chem.name;
                      }

                      return Container(
                        width: 220,
                        margin: const EdgeInsets.only(right: 12),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: stop.targetType == 'Doctor' ? Colors.blue.shade50 : Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        typeLabel,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: stop.targetType == 'Doctor' ? Colors.blue : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (stop.checkedIn)
                                      const Icon(Icons.check_circle, color: Colors.green)
                                    else
                                      const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                Text('Sequence: #${stop.sequenceOrder}', style: const TextStyle(fontSize: 12)),
                                const Spacer(),
                                if (stop.checkedIn) ...[
                                  Text(
                                    'Checked-in: ${stop.checkInTime?.toLocal().toString().split(' ')[1].substring(0, 5) ?? ""}',
                                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                  if (stop.deviationReason != null && stop.deviationReason!.isNotEmpty)
                                    Text(
                                      'Deviation: ${stop.deviationReason}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.red.shade700, fontSize: 11),
                                    ),
                                ] else
                                  ElevatedButton(
                                    onPressed: () => _performCheckIn(context, stop),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(36),
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('GPS Check-In'),
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _performCheckIn(BuildContext context, TourPlanStop stop) {
    if (_simulateDeviation) {
      final reasonController = TextEditingController();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('⚠️ GPS Distance Deviation Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detected coordinates deviate > 100 meters from HCP standard location coordinates.',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Specify Deviation Reason *',
                  hintText: 'e.g., Doctor at alternate clinic branch...',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Deviation reason is required!')),
                  );
                  return;
                }
                final updatedStop = stop.copyWith(
                  checkedIn: true,
                  checkInTime: DateTime.now(),
                  checkInLatitude: 31.5204,
                  checkInLongitude: 74.3587,
                  deviationReason: reasonController.text.trim(),
                );
                ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).checkIn(updatedStop);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checked in with deviation log saved.')),
                );
              },
              child: const Text('Submit Reason & Check-in'),
            ),
          ],
        ),
      );
    } else {
      final updatedStop = stop.copyWith(
        checkedIn: true,
        checkInTime: DateTime.now(),
        checkInLatitude: 31.5204,
        checkInLongitude: 74.3587,
      );
      ref.read(tourPlanStopsProvider(widget.tourPlan.id).notifier).checkIn(updatedStop);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checked in successfully!')),
      );
    }
  }

  dynamic _dummyDoc() => _DummyDoc();
  dynamic _dummyChem() => _DummyChem();
}

class _DummyDoc {
  final String name = 'HCP Specialist';
}

class _DummyChem {
  final String name = 'Pharmacy Store';
}

class _MapCanvasPainter extends CustomPainter {
  final List<TourPlanStop> stops;
  final Offset repPosition;

  _MapCanvasPainter({required this.stops, required this.repPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 1.0;

    // Draw grid lines
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Positions of mock stops mapped on canvas screen coordinates
    final List<Offset> mockCoordinates = [
      const Offset(80, 100),
      const Offset(220, 80),
      const Offset(300, 200),
      const Offset(120, 250),
      const Offset(280, 360),
    ];

    if (stops.isNotEmpty) {
      // Connect route stops with optimized green lines path
      final routePaint = Paint()
        ..color = Colors.greenAccent
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(repPosition.dx, repPosition.dy);

      for (int i = 0; i < stops.length; i++) {
        final coord = mockCoordinates[i % mockCoordinates.length];
        path.lineTo(coord.dx, coord.dy);
      }
      canvas.drawPath(path, routePaint);

      // Draw pins
      for (int i = 0; i < stops.length; i++) {
        final stop = stops[i];
        final coord = mockCoordinates[i % mockCoordinates.length];

        final pinColor = stop.checkedIn ? Colors.green : (stop.targetType == 'Doctor' ? Colors.blue : Colors.orange);

        // Pin shadow
        canvas.drawCircle(Offset(coord.dx, coord.dy + 3), 10, Paint()..color = Colors.black45);

        // Pin body
        canvas.drawCircle(coord, 10, Paint()..color = pinColor);

        // Sequence number text
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${stop.sequenceOrder}',
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(coord.dx - 4, coord.dy - 6));
      }
    }

    // Draw representative pulsing current position dot
    final repPaint = Paint()..color = Colors.cyan;
    canvas.drawCircle(repPosition, 8, repPaint);

    final pulsePaint = Paint()
      ..color = Colors.cyan.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(repPosition, 16, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
