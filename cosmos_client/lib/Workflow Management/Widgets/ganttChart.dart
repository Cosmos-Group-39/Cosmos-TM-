import 'package:flutter/material.dart';

class GanttChartWidget extends StatelessWidget {
  final List<GanttTask> tasks;

  GanttChartWidget({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GanttChartPainter(tasks: tasks),
    );
  }
}

class GanttChartPainter extends CustomPainter {
  final List<GanttTask> tasks;

  GanttChartPainter({required this.tasks});

  @override
  void paint(Canvas canvas, Size size) {
    final double chartWidth = size.width;
    final double chartHeight = size.height;
    final double taskHeight = chartHeight / tasks.length;

    final Paint fillPaint = Paint()..color = Colors.blue;
    final Paint borderPaint = Paint()..color = Colors.black;
    final Paint textPaint = Paint()..color = Colors.black;
    final double textPadding = 4.0;
    final double barPadding = 8.0;

    for (int i = 0; i < tasks.length; i++) {
      final GanttTask task = tasks[i];

      final double taskStartX = task.start / task.maxValue * chartWidth;
      final double taskEndX = task.end / task.maxValue * chartWidth;
      final double taskY = i * taskHeight;

      final Rect taskRect = Rect.fromLTRB(
          taskStartX, taskY, taskEndX, taskY + taskHeight - barPadding);

      canvas.drawRect(taskRect, fillPaint);
      canvas.drawRect(taskRect, borderPaint);

      final TextSpan textSpan = TextSpan(
        text: task.name,
        style: TextStyle(color: Colors.black),
      );

      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(taskStartX + textPadding, taskY + textPadding),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class GanttTask {
  final String name;
  final double start;
  final double end;
  final double maxValue;

  GanttTask({
    required this.name,
    required this.start,
    required this.end,
    required this.maxValue,
  });
}
