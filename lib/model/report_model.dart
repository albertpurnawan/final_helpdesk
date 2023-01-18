class ReportModel {
  String TicketNumber;
  String Status;
  String Username;
  String Name;
  String HelpdeskUsername;
  String HelpdeskName;
  String PICUsername;
  String PICName;
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
      required this.RejectedNotes});

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
      "RejectedNotes": RejectedNotes
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
        TicketNumber: map['Ticket Number'] ?? '',
        Status: map['Status'] ?? '',
        Username: map['Username'] ?? '',
        Name: map['Name'] ?? '',
        HelpdeskUsername: map['Helpdesk Username'] ?? '',
        HelpdeskName: map['Helpdesk Name'] ?? '',
        PICUsername: map['PIC Username'] ?? '',
        PICName: map['PIC Name'] ?? '',
        RequestDate: map['Request Date'] ?? '',
        HelpdeskResponseDate: map['Helpdesk Response Date'] ?? '',
        GetJobDate: map['Get Job Date'] ?? '',
        PICCloseDate: map['PIC Close Date'] ?? '',
        FinishDate: map['Finish Date'] ?? '',
        DurationbyHelpdesk: map['Duration by Helpdesk'] ?? '',
        DurationbyPIC: map['Duration by PIC'] ?? '',
        Small: map['Small'] ?? '',
        CommunicationBy: map['Communication By'] ?? '',
        SupportCategory: map['Support Category'] ?? '',
        Category: map['Category'] ?? '',
        SubCategory1: map['Sub Category 1'] ?? '',
        SubCategory2: map['Sub Category 2'] ?? '',
        RepairType: map['Repair Type'] ?? '',
        SupportType: map['Support Type'] ?? '',
        System: map['System'] ?? '',
        Application: map['Application'] ?? '',
        Description: map['Description'] ?? '',
        ProblemIdentification: map['Problem Identification'] ?? '',
        CorrectiveAction: map['Corrective Action'] ?? '',
        Second: map['Second'] ?? '',
        Minute: map['Minute'] ?? '',
        Hour: map['Hour'] ?? '',
        Day: map['Day'] ?? '',
        RejectedNotes: map['Rejected Notes'] ?? '');
  }
}

// https://api.mayora.co.id/v1/myrapi/Joblist/GetShowStatus -> POST -> body docno=id
//https://api.mayora.co.id/v1/myrapi/Joblist/GetCurrentLines -> POST -> body docno=id
//https://api.mayora.co.id/qas/db/portalworkflow/myrwf/t_selectedworkflow/search -> POST -> header token->body docno=id