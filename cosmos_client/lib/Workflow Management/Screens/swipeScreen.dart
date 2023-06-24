import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/Home.dart';
import 'package:cosmos_client/Workflow%20Management/Views/calenderView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/chartsView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/ganttChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/pieChartView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/progressBarView.dart';
import 'package:cosmos_client/Workflow%20Management/Views/stepView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SwipeScreen extends StatefulWidget {
  final dynamic workflow;
  const SwipeScreen({Key? key, this.workflow}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  TextEditingController _subworkflowNameController = TextEditingController();
  TextEditingController _subworkflowDescriptonController =
      TextEditingController();
  _SwipeScreenState();

  late PageController _pageController;
  int _currentPage = 0;
  String? _selectedTemplate;

  List<Widget> views = [];
  List<dynamic> subWorkflows = [];
  List<String> templates = [
    'calendar',
    'ganttChart',
    'chartView',
    'pieChart',
    'progressBar',
    'stepView',
  ];

  List<String> templateDisplay = [
    '    Calender View',
    '    Gantt Chart View',
    '    Chart View',
    '    Pie Chart View',
    '    ProgressBar View',
    '    Step View',
  ];
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void createSubworkflow() {
    // deleteSubworkflow(subWorkflows[0]);
    if (_subworkflowNameController.text.isEmpty) {
      showErrorMessage('Subworkflow Name cannot be empty');
      return;
    }
    if (_selectedTemplate == null) {
      showErrorMessage('Please select a view');
      return;
    }
    Map<String, dynamic> jsonObject = {
      'title': _subworkflowNameController.text,
      'description': _subworkflowDescriptonController.text,
      'works': [],
      'view': templates[templateDisplay.indexOf(_selectedTemplate!)],
      'labels': [],
    };

    Dio().post('$baseUrls/common/subWorkflow', data: jsonObject).then((res) {
      subWorkflows.insert(0, res.data);
      createViews(res.data);
      Dio().patch('$baseUrls/common/workflow', data: {
        '_id': widget.workflow['_id'],
        '\$push': {"subWorkflows": res.data['_id']}
      }).then((value) {
        print("Added");
        _subworkflowNameController.clear();
        _subworkflowDescriptonController.clear();
        _goToNextPage();
      }).catchError(
          (error) => print(error)); // subworkflow couldn't link to workflow
    }).catchError((error) => print(error)); //subworkflow can't be create
  }

  void deleteSubworkflow(dynamic subWorflow) {
    Dio()
        .delete('$baseUrls/common/subWorkflow/${subWorflow['_id']}')
        .then((res) {
      int index =
          subWorkflows.indexWhere((item) => item['_id'] == res.data['_id']);
      subWorkflows.removeAt(index);
      views.removeAt(index);
      Dio().patch('$baseUrls/common/workflow', data: {
        '_id': widget.workflow['_id'],
        '\$pull': {"subWorkflows": res.data['_id']}
      }).then((value) {
        print("Deleted");
        _goToPreviousPage();
      }).catchError((error) => print(error)); //about link
    }).catchError((error) => print(error)); // can't be delete
  }

  createViews(dynamic subworkflow) {
    switch (subworkflow['view']) {
      case 'stepView':
        views.add(StepViewWorksScreen(
          subworkflow: subworkflow,
          workflowName: widget.workflow['title'],
          onDelete: deleteSubworkflow,
        ));
        break;
      case 'progressBar':
        views.add(ProgressBarWorksScreen(
          subworkflow: subworkflow,
          workflowName: widget.workflow['title'],
          onDelete: deleteSubworkflow,
        ));
        break;
      case 'ganttChart':
        views.add(GanttChartWorksScreen(
          subworkflow: subworkflow,
          workflowName: widget.workflow['title'],
          onDelete: deleteSubworkflow,
        ));
        break;
      case 'calendar':
        views.insert(
          0,
          CalenderViewScreen(
            subworkflow: subworkflow,
            workflowName: widget.workflow['title'],
            onDelete: deleteSubworkflow,
          ),
        );
        break;
      case 'chartView':
        views.add(ChartViewWorksScreen(
          subworkflow: subworkflow,
          workflowName: widget.workflow['title'],
          onDelete: deleteSubworkflow,
        ));
        break;
      case 'pieChart':
        views.add(PieChartWorksScreen(
          subworkflow: subworkflow,
          workflowName: widget.workflow['title'],
          onDelete: deleteSubworkflow,
        ));
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    subWorkflows = widget.workflow['subWorkflows'];
    for (int i = 0; i < subWorkflows.length; i++) {
      createViews(subWorkflows[i]);
    }
    // print(subWorkflows);
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
                                controller: _subworkflowNameController,
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
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                controller: _subworkflowDescriptonController,
                                decoration: InputDecoration(
                                  labelText: 'Enter a Subworkflow Discription',
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
                                    items: templateDisplay
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
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
                                    onPressed: () {
                                      createSubworkflow();
                                    },
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
                _buildDot(0),
                ...subWorkflows.map(
                    (element) => _buildDot(subWorkflows.indexOf(element) + 1)),
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
