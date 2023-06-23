import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';

void createWork(WorkModel work, List<WorkModel> workArray, String subId) {
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    'startTime': work.startTime,
    'endTime': work.endTime,
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
  Map<String, dynamic> jsonObject = {
    'title': work.title,
    'description': work.description,
    'active': work.active,
    'startTime': work.startTime,
    'endTime': work.endTime,
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
      '\$pull': {"works": jsonObject}
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
        'works.\$.startTime': work.startTime,
        'works.\$.endTime': work.endTime,
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
