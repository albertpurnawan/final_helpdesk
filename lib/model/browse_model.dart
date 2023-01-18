class BrowseIssue {
  String docno;
  String description;
  String username;
  String createby;
  String status;
  String supportcategory;
  String id;
  int isquickresponsehelpdesk;
  String createdate;
  String wl;

  BrowseIssue({
    required this.docno,
    required this.description,
    required this.username,
    required this.createby,
    required this.status,
    required this.supportcategory,
    required this.id,
    required this.isquickresponsehelpdesk,
    required this.createdate,
    required this.wl,
  });

  Map<String, dynamic> toMap() {
    return {
      'docno': docno,
      'description': description,
      'username': username,
      'createby': createby,
      'status': status,
      'supportcategory': supportcategory,
      'id': id,
      'isquickresponsehelpdesk': isquickresponsehelpdesk,
      'createdate': createdate,
      'wl': wl
    };
  }

  factory BrowseIssue.fromMap(Map<String, dynamic> map) {
    return BrowseIssue(
      docno: map['docno'] ?? '',
      description: map['description'] ?? '',
      username: map['username'] ?? '',
      createby: map['createby'] ?? '',
      status: map['status'] ?? '',
      supportcategory: map['supportcategory'] ?? '',
      id: map['id'] ?? '',
      isquickresponsehelpdesk: map['isquickresponsehelpdesk'] ?? '',
      createdate: map['createdate'] ?? '',
      wl: map['wl'] ?? '',
    );
  }
}

class BrowseIssueDetail {
  String docno;
  String id;
  String description;
  String username;
  String createby;
  String status;
  String supportcategory;
  int isquickresponsehelpdesk;
  String createdate;
  String wl;
  String closeticketdate;
  String userratedate;
  String updatedate;
  String scheduledate;
  String email;
  String subcategory2;
  String title;
  String subcategory1;
  String problemidentification;
  String updateby;
  String category;
  String attachments;
  String worklocationcode;
  String correctiveaction;
  String notes;
  String assigned;
  String userid;
  String modulecode;
  String systemcode;
  String supporttype;
  String type;
  String communicationby;
  int updatectr;
  String repairtype;
  String applicationcode;
  String phonenumber;
  String pic_ticket_docno;
  List<dynamic> d_comment;

  BrowseIssueDetail({
    required this.docno,
    required this.description,
    required this.username,
    required this.createby,
    required this.status,
    required this.supportcategory,
    required this.id,
    required this.isquickresponsehelpdesk,
    required this.createdate,
    required this.wl,
    required this.closeticketdate,
    required this.userratedate,
    required this.updatedate,
    required this.scheduledate,
    required this.email,
    required this.subcategory2,
    required this.title,
    required this.subcategory1,
    required this.problemidentification,
    required this.updateby,
    required this.category,
    required this.attachments,
    required this.worklocationcode,
    required this.correctiveaction,
    required this.notes,
    required this.assigned,
    required this.userid,
    required this.modulecode,
    required this.systemcode,
    required this.supporttype,
    required this.type,
    required this.communicationby,
    required this.updatectr,
    required this.repairtype,
    required this.applicationcode,
    required this.phonenumber,
    required this.pic_ticket_docno,
    required this.d_comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'docno': docno,
      'description': description,
      'username': username,
      'createby': createby,
      'status': status,
      'supportcategory': supportcategory,
      'id': id,
      'isquickresponsehelpdesk': isquickresponsehelpdesk,
      'createdate': createdate,
      'wl': wl,
      'closeticketdate': closeticketdate,
      'userratedate': userratedate,
      'updatedate': updatedate,
      'scheduledate': scheduledate,
      'email': email,
      'subcategory2': subcategory2,
      'title': title,
      'subcategory1': subcategory1,
      'problemidentification': problemidentification,
      'updateby': updateby,
      'category': category,
      'attachments': attachments,
      'worklocationcode': worklocationcode,
      'correctiveaction': correctiveaction,
      'notes': notes,
      'assigned': assigned,
      'userid': userid,
      'modulecode': modulecode,
      'systemcode': systemcode,
      'supporttype': supporttype,
      'type': type,
      'communicationby': communicationby,
      'updatectr': updatectr,
      'repairtype': repairtype,
      'applicationcode': applicationcode,
      'phonenumber': phonenumber,
      'pic_ticket_docno': pic_ticket_docno,
      'd_comment': d_comment,
    };
  }

  factory BrowseIssueDetail.fromMap(Map<String, dynamic> map) {
    return BrowseIssueDetail(
      docno: map['docno'] ?? '',
      description: map['description'] ?? '',
      username: map['username'] ?? '',
      createby: map['createby'] ?? '',
      status: map['status'] ?? '',
      supportcategory: map['supportcategory'] ?? '',
      id: map['id'] ?? '',
      isquickresponsehelpdesk: map['isquickresponsehelpdesk'] ?? '',
      createdate: map['createdate'] ?? '',
      wl: map['wl'] ?? '',
      closeticketdate: map['closeticketdate'] ?? '',
      userratedate: map['userratedate'] ?? '',
      updatedate: map['updatedate'] ?? '',
      scheduledate: map['scheduledate'] ?? '',
      email: map['email'] ?? '',
      subcategory2: map['subcategory2'] ?? '',
      title: map['title'] ?? '',
      subcategory1: map['subcategory1'] ?? '',
      problemidentification: map['problemidentification'] ?? '',
      updateby: map['updateby'] ?? '',
      category: map['category'] ?? '',
      attachments: map['attachments'] ?? '',
      worklocationcode: map['worklocationcode'] ?? '',
      correctiveaction: map['correctiveaction'] ?? '',
      notes: map['notes'] ?? '',
      assigned: map['assigned'] ?? '',
      userid: map['userid'] ?? '',
      modulecode: map['modulecode'] ?? '',
      systemcode: map['systemcode'] ?? '',
      supporttype: map['supporttype'] ?? '',
      type: map['type'] ?? '',
      communicationby: map['communicationby'] ?? '',
      updatectr: map['updatectr'] ?? '',
      repairtype: map['repairtype'] ?? '',
      applicationcode: map['applicationcode'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      pic_ticket_docno: map['pic_ticket_docno'] ?? '',
      d_comment: map['d_comment'] ?? '',
    );
  }
}
