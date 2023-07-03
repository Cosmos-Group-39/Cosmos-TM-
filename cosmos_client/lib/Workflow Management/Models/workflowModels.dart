// class WorkflowModel {
//   String wid;
//   String title;

//   WorkflowModel({
//     required this.wid,
//     required this.title,
//   });
// }

// class SubWorkflowModel {
//   String swid;
//   String title;

//   SubWorkflowModel({
//     required this.swid,
//     required this.title,
//   });
// }

// class WorksModel {
//   String wwid;
//   String title;

//   WorksModel({
//     required this.wwid,
//     required this.title,
//   });
// }

//Workflows
import 'package:flutter/material.dart';

class AccessModel {
  String accessLevel;
  String userId;

  AccessModel({
    required this.accessLevel,
    required this.userId,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) {
    return AccessModel(
      accessLevel: json['accessLevel'] ?? '',
      userId: json['user'] ?? '',
    );
  }
}

class WorkflowModel {
  String? wid;
  String title;
  String type = 'free';
  List<String>? subWorkflows;
  List<AccessModel>? users;
  List<String>? accessCodes;
  String? chat;
  List<String>? labels;
  bool active = true;

  WorkflowModel({
    this.wid,
    required this.title,
    required this.type,
    this.subWorkflows,
    this.users,
    this.accessCodes,
    this.chat,
    this.labels,
    required this.active,
  });

  factory WorkflowModel.fromJson(Map<String, dynamic> json) {
    return WorkflowModel(
      // wid: json['_id'],
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? 'free',
      subWorkflows:
          List<String>.from(json['subWorkflows'] as List<dynamic>? ?? []),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => AccessModel.fromJson(e))
          ?.toList(),
      accessCodes:
          List<String>.from(json['accessCodes'] as List<dynamic>? ?? []),
      chat: json['chat'] as String? ?? '',
      labels: List<String>.from(json['labels'] as List<dynamic>? ?? []),
      active: json['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        // '_id': wid,
        'title': title,
        'type': type,
        'subWorkflows': subWorkflows,
        'users': users,
        'accessCodes': accessCodes,
        'chat': chat,
        'labels': labels,
        'active': active
      };
}

//Subworkflows

class SubWorkflowModel {
  String? subid;
  String title;
  String? description;
  List<WorkModel>? works;
  String view;
  List<String>? labels;

  SubWorkflowModel({
    this.subid,
    required this.title,
    this.description,
    this.works,
    required this.view,
    this.labels,
  });
}

//Works
class WorkModel {
  String? workid;
  String title;
  String? description;
  bool active = false;
  DateTime? startTime;
  DateTime? endTime;
  List<String>? labels;
  String? user;
  RepetitiveModel? repetitive;

  WorkModel({
    this.workid,
    required this.title,
    this.description,
    required this.active,
    this.startTime,
    this.endTime,
    this.labels,
    this.user,
    this.repetitive,
  });
}

class RepetitiveModel {
  double amount;
  String unit;

  RepetitiveModel({
    required this.amount,
    required this.unit,
  });
}

class LabelModel {
  String name;
  String color;

  LabelModel({
    required this.name,
    required this.color,
  });
}
