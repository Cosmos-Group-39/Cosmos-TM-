import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

void createWork(WorkModel work, List<WorkModel> workArray) {
  print("hi");
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    // 'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(
    //     DateTime.fromMillisecondsSinceEpoch(
    //         work.startTime!.toUtc().millisecondsSinceEpoch,
    //         isUtc: true)),
    // 'endTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(
    //     DateTime.fromMillisecondsSinceEpoch(
    //         work.endTime!.toUtc().millisecondsSinceEpoch,
    //         isUtc: true)),
    'labels': work.labels,
    'user': work.user,
    'repetitive': {
      'amount': work.repetitive?.amount,
      'unit': work.repetitive?.unit,
    }
  };

  Dio().patch('$baseUrls/common/workflow', data: {
    '_id': '647f30610b223c7d9f21ace0',
    '\$push': {"works": jsonObject}
  }).then((value) {
    workArray.add(work);
    print("Work Added");
  }).catchError((error) => print(error));
}

void deleteSubworkflow(WorkModel work, List<WorkModel> workArray) {
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(
        DateTime.fromMillisecondsSinceEpoch(
            work.startTime!.toUtc().millisecondsSinceEpoch,
            isUtc: true)),
    'endTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(
        DateTime.fromMillisecondsSinceEpoch(
            work.endTime!.toUtc().millisecondsSinceEpoch,
            isUtc: true)),
    'labels': work.labels,
    'user': work.user,
    'repetitive': {
      'amount': work.repetitive?.amount,
      'unit': work.repetitive?.unit,
    }
  };
  Dio().patch('$baseUrls/common/workflow', data: {
    '_id': work.workid,
    '\$pull': {"works": jsonObject}
  }).then((value) {
    workArray.remove(work);
    print("Deleted");
  }).catchError((error) => print(error));
}
