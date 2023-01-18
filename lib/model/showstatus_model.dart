class ShowStatusModel {
  String id;
  String docno;
  String modulecode;
  String modulename;
  String workflowid;
  String workflowcode;
  String workflowname;
  String workflowpathid;
  String workflowlinesid;
  String idpararelline;
  String groupworkflowcode;
  String groupworkflowdesc;
  String activity;
  String createdby;
  String username;
  String desclines;
  String closedate;
  String closebyusername;
  String rejectdate;
  String rejectbyusername;
  String email;
  String usingldap;
  String groupcode;
  String isdeleted;
  String empid;
  String name;
  String assigngroup;
  String assignedpic;
  String webname;
  String creatorname;
  String createddate;
  String lastdate;
  String lastuser;
  String lastapprove;
  List<ShowStatusModel> displayPIC;

  ShowStatusModel(
      {required this.id,
      required this.docno,
      required this.modulecode,
      required this.modulename,
      required this.workflowid,
      required this.workflowcode,
      required this.workflowname,
      required this.workflowpathid,
      required this.workflowlinesid,
      required this.idpararelline,
      required this.groupworkflowcode,
      required this.groupworkflowdesc,
      required this.activity,
      required this.createdby,
      required this.username,
      required this.desclines,
      required this.closedate,
      required this.closebyusername,
      required this.rejectdate,
      required this.rejectbyusername,
      required this.email,
      required this.usingldap,
      required this.groupcode,
      required this.isdeleted,
      required this.empid,
      required this.name,
      required this.assigngroup,
      required this.assignedpic,
      required this.webname,
      required this.creatorname,
      required this.createddate,
      required this.lastdate,
      required this.lastuser,
      required this.lastapprove,
      required this.displayPIC});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "docno": docno,
      "modulecode": modulecode,
      "workflowid": workflowid,
      "workflowcode": workflowcode,
      "workflowname": workflowname,
      "workflowpathid": workflowpathid,
      "workflowlinesid": workflowlinesid,
      "idpararelline": idpararelline,
      "groupworkflowcode": groupworkflowcode,
      "groupworkflowdesc": groupworkflowdesc,
      "activity": activity,
      "createdby": createdby,
      "username": username,
      "desclines": desclines,
      "closedate": closedate,
      "closebyusername": closebyusername,
      "rejectdate": rejectdate,
      "rejectbyusername": rejectbyusername,
      "email": email,
      "usingldap": usingldap,
      "groupcode": groupcode,
      "isdeleted": isdeleted,
      "empid": empid,
      "name": name,
      "assigngroup": assigngroup,
      "assignedpic": assignedpic,
      "webname": webname,
      "creatorname": creatorname,
      "createddate": createddate,
      "lastdate": lastdate,
      "lastuser": lastuser,
      "lastapprove": lastapprove,
      "displayPIC": displayPIC
    };
  }

  factory ShowStatusModel.fromMap(Map<String, dynamic> map) {
    return ShowStatusModel(
      id: map['id'] ?? '',
      docno: map['docno'] ?? '',
      modulecode: map['modulecode'] ?? '',
      modulename: map['modulename'] ?? '',
      workflowid: map['workflowid'] ?? '',
      workflowcode: map['workflowcode'] ?? '',
      workflowname: map['workflowname'] ?? '',
      workflowpathid: map['workflowpathid'] ?? '',
      workflowlinesid: map['workflowlinesid'] ?? '',
      idpararelline: map['idpararelline'] ?? '',
      groupworkflowcode: map['groupworkflowcode'] ?? '',
      groupworkflowdesc: map['groupworkflowdesc'] ?? '',
      activity: map['activity'] ?? '',
      createdby: map['createdby'] ?? '',
      username: map['username'] ?? '',
      desclines: map['desclines'] ?? '',
      closedate: map['closedate'] ?? '',
      closebyusername: map['closebyusername'] ?? '',
      rejectdate: map['rejectdate'] ?? '',
      rejectbyusername: map['rejectbyusername'] ?? '',
      assigngroup: map['assigngroup'] ?? '',
      assignedpic: map['assignedpic'] ?? '',
      webname: map['webname'] ?? '',
      creatorname: map['creatorname'] ?? '',
      createddate: map['createddate'] ?? '',
      lastdate: map['lastdate'] ?? '',
      lastuser: map['lastuser'] ?? '',
      lastapprove: map['lastapprove'] ?? '',
      email: map['email'] ?? '',
      usingldap: map['modulename'] ?? '',
      groupcode: map['groupcode'] ?? '',
      isdeleted: map['isdeleted'] ?? '',
      empid: map['empid'] ?? '',
      name: map['name'] ?? '',
      displayPIC: map['displayPIC'] ?? [],
    );
  }
}

// https://api.mayora.co.id/v1/myrapi/Joblist/GetShowStatus -> POST -> body docno=id
//https://api.mayora.co.id/v1/myrapi/Joblist/GetCurrentLines -> POST -> body docno=id
//https://api.mayora.co.id/qas/db/portalworkflow/myrwf/t_selectedworkflow/search -> POST -> header token->body docno=id