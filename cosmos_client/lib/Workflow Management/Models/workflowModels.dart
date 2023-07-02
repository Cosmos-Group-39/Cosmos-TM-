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
class AccessModel {
  String accessLevel;
  String userId;

  AccessModel({
    required this.accessLevel,
    required this.userId,
  });
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
  int amount;
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
