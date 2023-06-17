import 'package:cosmos_client/Workflow%20Management/Views/calenderView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/chartsView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/ganttChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/pieChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/progressBarView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/stepView.dart';
import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Screen 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              CalenderViewScreen(),
              StepViewWorksScreen(),
              ProgressBarWorksScreen(),
              GanttChartWorksScreen(),
              PieChartWorksScreen(),
              ChartViewWorksScreen(),
            ],
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(0),
                _buildDot(1),
                _buildDot(2),
                _buildDot(3),
                _buildDot(4),
                _buildDot(5),
                _buildDot(6),
                _buildDot(7),
              ],
            ),
          ),
          Positioned(
            bottom: -10,
            left: 50,
            right: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.blue,
                    onPressed: _goToPreviousPage,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.blue,
                    onPressed: _goToNextPage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int pageIndex) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: _currentPage == pageIndex ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == pageIndex ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
