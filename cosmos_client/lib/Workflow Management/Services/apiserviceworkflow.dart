import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

void createWork(WorkModel work, List<WorkModel> workArray, String subId) {
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(
        work.startTime?.toString() ?? DateTime.now().toString())),
    'endTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
        DateTime.parse(work.endTime?.toString() ?? DateTime.now().toString())),
    'labels': work.labels,
    'user': work.user,
    'repetitive': {
      'amount': work.repetitive?.amount,
      'unit': work.repetitive?.unit,
    }
  };

  Dio().patch('$baseUrls/common/subWorkflow', data: {
    'head': {'_id': subId},
    'set': {
      '\$push': {"works": jsonObject}
    }
  }).then((value) {
    // workArray.add(work);
    print("Work Added");
  }).catchError((error) => print(error));
}

void deleteWork(WorkModel work, List<WorkModel> workArray, String subId) {
  print(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
      DateTime.parse(work.startTime?.toString() ?? DateTime.now().toString())));
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.parse(
        work.startTime?.toString() ?? DateTime.now().toString())),
    'endTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
        DateTime.parse(work.endTime?.toString() ?? DateTime.now().toString())),
    'labels': work.labels,
    'user': work.user,
    'repetitive': {
      'amount': work.repetitive?.amount,
      'unit': work.repetitive?.unit,
    }
  };
  print(work.workid);
  print(subId);
  Dio().patch('$baseUrls/common/subWorkflow', data: {
    'head': {'_id': subId},
    'set': {
      '\$pull': {
        "works": {"_id": work.workid}
      }
    }
  }).then((value) {
    // workArray.remove(work);
    print("Deleted");
  }).catchError((error) => print(error));
}

void editWork(WorkModel work, List<WorkModel> workArray, String subId) {
  print(work.workid);
  Dio().patch('$baseUrls/common/subWorkflow', data: {
    'head': {'_id': subId, 'works._id': work.workid},
    'set': {
      '\$set': {
        'works.\$.title': work.title,
        'works.\$.description': work.description,
        'works.\$.active': work.active,
        'works.\$.startTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
            DateTime.parse(
                work.startTime?.toString() ?? DateTime.now().toString())),
        'works.\$.endTime': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
            DateTime.parse(
                work.endTime?.toString() ?? DateTime.now().toString())),
        'works.\$.labels': work.labels,
        'works.\$.user': work.user,
        'works.\$.repetitive': {
          'amount': work.repetitive?.amount,
          'unit': work.repetitive?.unit,
        }
      }
    }
  }).then((value) {
    // workArray.add(work);
    print("Work Added");
  }).catchError((error) => print(error));
}

void editSubworkflow(String field, String value) {}
