class WorkflowModel {
  String wid;
  String title;

  WorkflowModel({
    required this.wid,
    required this.title,
  });
}

class Workflow {
  final String accessCode;
  final String email;
  final String phoneNumber;

  Workflow({
    required this.accessCode,
    required this.email,
    required this.phoneNumber,
  });
}

class SubWorkflowModel {
  String swid;
  String title;

  SubWorkflowModel({
    required this.swid,
    required this.title,
  });
}

class WorksModel {
  String wwid;
  String title;

  WorksModel({
    required this.wwid,
    required this.title,
  });
}
