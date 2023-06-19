import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:cosmos_client/Workflow%20Management/Views/calenderView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/chartsView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/ganttChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/pieChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/progressBarView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/stepView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  final dynamic workflow;
  const SwipeScreen({Key? key, this.workflow}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  _SwipeScreenState();

  late PageController _pageController;
  int _currentPage = 0;
  String? _selectedTemplate;

  List<Widget> views = [];
  List<dynamic> subWorkflows = [];

  createViews() {
    for (int i = 0; i < subWorkflows.length; i++) {
      switch (subWorkflows[i]['view']) {
        case 'stepView':
          print('object');
          views.add(StepViewWorksScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        case 'progressBar':
          views.add(ProgressBarWorksScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        case 'ganttChart':
          views.add(GanttChartWorksScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        case 'calendar':
          views.add(CalenderViewScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        case 'chartView':
          views.add(ChartViewWorksScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        case 'pieChart':
          views.add(PieChartWorksScreen(
              subworkflow: subWorkflows[i],
              workflowName: widget.workflow['title']));
          break;
        default:
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    subWorkflows = widget.workflow['subWorkflows'];
    createViews();
    print(views.length);
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < 7) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 1),
                            Text(
                              'Create Sub Workflows',
                              style: kAlertBoxTopicTextStyle,
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Enter a Subworkflow Name',
                                  fillColor: Colors.blue[50],
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'Select View',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 220,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: DropdownButton<String>(
                                    underline: const Text(''),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    alignment: AlignmentDirectional.centerEnd,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      decoration: null,
                                    ),
                                    value: _selectedTemplate,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedTemplate = newValue;
                                      });
                                    },
                                    items: <String>[
                                      '    Calender View',
                                      '    Gantt Chart View',
                                      '    Chart View',
                                      '    Pie Chart View',
                                      '    ProgressBar View',
                                      '    Step View',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      minimumSize: const Size(100, 50),
                                      shadowColor: Colors.black,
                                      alignment: Alignment.center,
                                      elevation: 10,
                                    ),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      size: 25,
                                      color: kDefaultIconLightColor,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ...views,
              ],
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ...subWorkflows
                    .map((element) => _buildDot(subWorkflows.indexOf(element))),
              ]),
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
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.blue,
                      onPressed: _goToPreviousPage,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      color: Colors.blue,
                      onPressed: _goToNextPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int pageIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: _currentPage == pageIndex ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == pageIndex ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}