import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

class TipsViews extends StatefulWidget {
  const TipsViews({Key? key}) : super(key: key);

  @override
  State<TipsViews> createState() => _TipsViewsState();
}

class _TipsViewsState extends State<TipsViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Calendar View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 580,
                  width: 420,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Calender.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                const Text(
                  'Chart View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 450,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Chart.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                const Text(
                  'Gantt Chart View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 280,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/chartView.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                const Text(
                  'Pie Chart View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 300,
                  width: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/PieChart.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                const Text(
                  'Progress Bar View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 120,
                  width: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/ProgressBar.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                const Text(
                  'Step View',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                Container(
                  height: 120,
                  width: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/stepView.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
