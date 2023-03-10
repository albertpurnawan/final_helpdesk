class ReportModel {
  String TicketNumber;
  String Status;
  String Username;
  String worklocation;
  String Name;
  String HelpdeskUsername;
  String HelpdeskName;
  String PICUsername;
  String PICName;
  String PICworklocation;
  String RequestDate;
  String HelpdeskResponseDate;
  String GetJobDate;
  String PICCloseDate;
  String FinishDate;
  String DurationbyHelpdesk;
  String DurationbyPIC;
  String Small;
  String CommunicationBy;
  String SupportCategory;
  String Category;
  String SubCategory1;
  String SubCategory2;
  String RepairType;
  String SupportType;
  String System;
  String Application;
  String Description;
  String ProblemIdentification;
  String CorrectiveAction;
  String Second;
  String Minute;
  String Hour;
  String Day;
  String RejectedNotes;

  ReportModel(
      {required this.TicketNumber,
      required this.Status,
      required this.Username,
      required this.Name,
      required this.HelpdeskUsername,
      required this.HelpdeskName,
      required this.PICUsername,
      required this.PICName,
      required this.RequestDate,
      required this.HelpdeskResponseDate,
      required this.GetJobDate,
      required this.PICCloseDate,
      required this.FinishDate,
      required this.DurationbyHelpdesk,
      required this.DurationbyPIC,
      required this.Small,
      required this.CommunicationBy,
      required this.SupportCategory,
      required this.Category,
      required this.SubCategory1,
      required this.SubCategory2,
      required this.RepairType,
      required this.SupportType,
      required this.System,
      required this.Application,
      required this.Description,
      required this.ProblemIdentification,
      required this.CorrectiveAction,
      required this.Second,
      required this.Minute,
      required this.Hour,
      required this.Day,
      required this.RejectedNotes,
      required this.worklocation,
      required this.PICworklocation});

  Map<String, dynamic> toMap() {
    return {
      "TicketNumber": TicketNumber,
      "Status": Status,
      "Username": Username,
      "Name": Name,
      "HelpdeskUsername": HelpdeskUsername,
      "HelpdeskName": HelpdeskName,
      "PICUsername": PICUsername,
      "PICName": PICName,
      "RequestDate": RequestDate,
      "HelpdeskResponseDate": HelpdeskResponseDate,
      "GetJobDate": GetJobDate,
      "PICCloseDate": PICCloseDate,
      "FinishDate": FinishDate,
      "DurationbyHelpdesk": DurationbyHelpdesk,
      "DurationbyPIC": DurationbyPIC,
      "Small": Small,
      "CommunicationBy": CommunicationBy,
      "SupportCategory": SupportCategory,
      "Category": Category,
      "SubCategory1": SubCategory1,
      "SubCategory2": SubCategory2,
      "RepairType": RepairType,
      "SupportType": SupportType,
      "System": System,
      "Application": Application,
      "Description": Description,
      "ProblemIdentification": ProblemIdentification,
      "CorrectiveAction": CorrectiveAction,
      "Second": Second,
      "Minute": Minute,
      "Hour": Hour,
      "Day": Day,
      "RejectedNotes": RejectedNotes,
      "worklocation": worklocation,
      "PICworklocation": PICworklocation
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
        TicketNumber: map['ticketnumber'] ?? '',
        Status: map['status'] ?? '',
        Username: map['username'] ?? '',
        Name: map['name'] ?? '',
        HelpdeskUsername: map['helpdeskusername'] ?? '',
        HelpdeskName: map['helpdeskname'] ?? '',
        PICUsername: map['picusername'] ?? '',
        PICName: map['picname'] ?? '',
        RequestDate: map['requestdate'] ?? '',
        HelpdeskResponseDate: map['helpdeskresponsedate'] ?? '',
        GetJobDate: map['getjobdate'] ?? '',
        PICCloseDate: map['picclosedate'] ?? '',
        FinishDate: map['finishdate'] ?? '',
        DurationbyHelpdesk: map['durationbyhelpdesk'] ?? '',
        DurationbyPIC: map['durationbypic'] ?? '',
        Small: map['small'] ?? '',
        CommunicationBy: map['communicationby'] ?? '',
        SupportCategory: map['supportcategory'] ?? '',
        Category: map['category'] ?? '',
        SubCategory1: map['subcategory1'] ?? '',
        SubCategory2: map['subcategory2'] ?? '',
        RepairType: map['repairtype'] ?? '',
        SupportType: map['supporttype'] ?? '',
        System: map['system'] ?? '',
        Application: map['application'] ?? '',
        Description: map['description'] ?? '',
        ProblemIdentification: map['problemidentification'] ?? '',
        CorrectiveAction: map['correctiveaction'] ?? '',
        Second: map['second'] ?? '',
        Minute: map['minute'] ?? '',
        Hour: map['hour'] ?? '',
        Day: map['day'] ?? '',
        RejectedNotes: map['rejectednotes'] ?? '',
        worklocation: map['worklocation'] ?? '',
        PICworklocation: map['picworklocation'] ?? '');
  }
}

// https://api.mayora.co.id/v1/myrapi/Joblist/GetShowStatus -> POST -> body docno=id
//https://api.mayora.co.id/v1/myrapi/Joblist/GetCurrentLines -> POST -> body docno=id
//https://api.mayora.co.id/qas/db/portalworkflow/myrwf/t_selectedworkflow/search -> POST -> header token->body docno=id