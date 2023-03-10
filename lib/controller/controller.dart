import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/master_model.dart';
import 'package:helpdesk_skripsi/model/report_model.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/pages/dashboard_page.dart';
import 'package:helpdesk_skripsi/pages/master_category_page.dart';
import 'package:helpdesk_skripsi/util/statusCode.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;

class controller {
  static var connections = PostgreSQLConnection(
      "10.0.2.2",
      // "localhost",
      // "192.168.1.5",
      5432,
      "helpdesk_mayora",
      username: "postgres",
      password: "12345",
      timeoutInSeconds: 3600);

  static Future<User> Login(
      {required BuildContext context,
      required String username,
      required String password}) async {
    User dataUser = User(
        username: "",
        password: "",
        email: "",
        ua: "",
        image: "",
        name: "",
        groupcode: "",
        empid: "",
        groupname: "");
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<
          Map<
              String,
              Map<String,
                  dynamic>>> result = await connections.mappedResultsQuery(
          "SELECT * FROM data.user WHERE username = @USERNAME AND password = @PASSWORD",
          substitutionValues: {
            "USERNAME": username,
            "PASSWORD": password,
          });
      if (result.length == 1) {
        for (var element in result) {
          var data = element.values.toList();
          dataUser = User.fromMap(data[0]);
        }
      } else {
        showSnackBar(context, "Login Failed", "Invalid Username or Password");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Login Failed", "Invalid Username or Password");
    }
    return dataUser;
  }

  static Future<List<BrowseIssue>> Browse(
      {required BuildContext context,
      required String groupcode,
      required String ua,
      required String username,
      required String name}) async {
    print(groupcode);
    print(ua);
    print(username);
    print(name);
    var data;
    var query;
    List<BrowseIssue> listData = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (groupcode == 'IT002') {
        query = "";
      } else if (groupcode == 'IT001' || groupcode == 'IT003') {
        query = " WHERE groupcode in ('$groupcode', 'IT004')";
      } else {
        query =
            " WHERE (createby like '%$username%' and createby like '%$name%') or (assigned like '%$username%' and assigned like '%$name%') or userid = '$username' or groupcode = 'IT004'";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.t_issue$query",
      );
      print(result);
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          listData.add(BrowseIssue.fromMap(data[0]));
        }
        listData.sort((a, b) => b.docno.compareTo(a.docno));
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry 2");
    }

    return listData;
  }

  static Future<BrowseIssueDetail> BrowseDetail(
      {required BuildContext context,
      required String id,
      required String docno}) async {
    var data;
    List<BrowseIssueDetail> listData = [];
    print(id);
    print(docno);
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.t_issue WHERE id = '$id' and docno = '$docno'",
      );

      if (result.length == 1) {
        print("masuk");
        for (var element in result) {
          data = element.values.toList();
          print(data);
          listData.add(BrowseIssueDetail.fromMap(data[0]));
          print(listData.length);
        }
      } else {
        showSnackBar(context, "Connection Failed", "Retry");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return listData[0];
  }

  static Future<List<TicketPoolModel>> TicketPool(
      {required BuildContext context,
      required String search,
      required String category}) async {
    var data;
    List<TicketPoolModel> listData = [];
    String query = "";
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (category == "_NEW") {
        query = " where status = 'Pending'";
      } else if (category == "_OPEN") {
        query = " where status = 'Open'";
      } else {
        query = " where status = 'Close'";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "select * from data.t_issue t$query",
      );

      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          listData.add(TicketPoolModel.fromMap(data[0]));
        }
      }
      listData.sort((a, b) => b.docno.compareTo(a.docno));
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry 2");
    }
    return listData;
  }

  static Future<TicketPoolModel> TicketPoolDetail(
      {required BuildContext context,
      required String docno,
      required String id}) async {
    var data;
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<
          Map<
              String,
              Map<String,
                  dynamic>>> result = await connections.mappedResultsQuery(
          "SELECT * FROM data.t_issue WHERE docno = '$docno' and id = '$id'");

      if (result.length == 1) {
        for (var element in result) {
          data = element.values.toList();
        }
      } else {
        showSnackBar(context, "Connection Failed", "Retry");
      }
    } catch (e) {
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return TicketPoolModel.fromMap(data[0]);
  }

  static Future<String> reviewTicketpool(
      {required BuildContext context,
      required String supportcategory,
      required String username,
      required String category,
      required String notes,
      required String id,
      required String docno,
      required String comu}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var updateworkflow = await connections.query(
          "UPDATE data.workflow SET currentlines = '0', isdone = '1',closedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),closebyusername = '$username',closedatestamp = now() where docno = '$docno' and currentlines = '1' ");

      print(supportcategory);
      if (supportcategory == "Application Problem") {
        List<Map<String, Map<String, dynamic>>> result =
            await connections.mappedResultsQuery(
                "SELECT * FROM data.user WHERE useraccess = 'picsupport'");
        for (int i = 0; i < result.length; i++) {
          print(result[i].values.toList()[0]['name'].toString());
          var insert3 = await connections.query(
              "INSERT INTO data.workflow (id,docno,modulecode,"
              "workflowid,workflowcode,workflowname,workflowpathid,workflowlinesid,idpararelline,groupworkflowcode"
              ",activity,createdby,username,desclines,currentlines,name,isdone,isreject,isreturn,createdatestamp) "
              "VALUES ('${uuid.v4()}','$docno','HD-IS','4','HD-IS_WF','Helpdesk Quick Response Issue Workflow'"
              ",'1','1','1','QRH_HELPDESK','Review','$username'"
              ",'${result[i].values.toList()[0]['username'].toString()}','Superior IT Application Problem Assign Ticket','1','${result[i].values.toList()[0]['name'].toString()}','0','0','0',now())");
        }
        var updattickete = await connections.query(
            "UPDATE data.t_issue SET status = 'Open',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),supportcategory = '$supportcategory',updateby = '$username',category = '$category',notes='$notes',communicationby = '$comu', groupcode = 'IT003' where id = '$id'");
      } else {
        List<Map<String, Map<String, dynamic>>> result =
            await connections.mappedResultsQuery(
                "SELECT * FROM data.user WHERE useraccess = 'itsupport'");
        for (int i = 0; i < result.length; i++) {
          var insert3 = await connections.query(
              "INSERT INTO data.workflow (id,docno,modulecode,"
              "workflowid,workflowcode,workflowname,workflowpathid,workflowlinesid,idpararelline,groupworkflowcode"
              ",activity,createdby,username,desclines,currentlines,name,isdone,isreject,isreturn,createdatestamp) "
              "VALUES ('${uuid.v4()}','$docno','HD-IS','4','HD-IS_WF','Helpdesk Quick Response Issue Workflow'"
              ",'1','1','1','QRH_HELPDESK','Review','$username'"
              ",'${result[i].values.toList()[0]['username'].toString()}','IT Support Get Job','1','${result[i].values.toList()[0]['name'].toString()}','0','0','0',now())");
        }
        var updattickete = await connections.query(
            "UPDATE data.t_issue SET status = 'Open',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),supportcategory = '$supportcategory',updateby = '$username',category = '$category',notes='$notes',communicationby = '$comu', groupcode = 'IT001' where id = '$id'");
      }

      var insert3 = await connections.query(
          "INSERT INTO data.workflow (id,docno,modulecode,"
          "workflowid,workflowcode,workflowname,workflowpathid,workflowlinesid,idpararelline,groupworkflowcode"
          ",activity,createdby,username,desclines,currentlines,name,isdone,isreject,isreturn,createdatestamp) "
          "VALUES ('${uuid.v4()}','$docno','HD-IS','4','HD-IS_WF','Helpdesk Quick Response Issue Workflow'"
          ",'1','2','1','QRH_HELPDESK','Review','$username'"
          ",'#SYSTEM#','IT Support Get Job','0','#SYSTEM#','0','0','0',now())");
      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<String> review2Ticketpool(
      {required BuildContext context,
      required String system,
      required String username,
      required String app,
      required String task,
      required String id,
      required String docno,
      required String pic}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var updateworkflow = await connections.query(
          "UPDATE data.workflow SET currentlines = '0', isdone = '1',closedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),closebyusername = '$username',closedatestamp = now() where docno = '$docno' and currentlines = '1' ");

      // var updateworkflow = await connections.query(
      //     "UPDATE data.workflow SET currentlines = '0', isdone = '1',username = '${pic.split(" - ")[0]}' where docno = '$docno' and currentlines = '1' ");

      var updateworkflow2 = await connections.query(
          "UPDATE data.workflow SET currentlines = '1', isdone = '0', username = '${pic.split('-')[0]}',name = '${pic.split('-')[1]}' where docno = '$docno' and username = '#SYSTEM#' ");

      var updattickete = await connections.query(
          "UPDATE data.t_issue SET status = 'Open',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),application = '$app',assigned = '$pic',system = '$system',task='$task' where id = '$id'");
      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<String> rejectTicketpool(
      {required BuildContext context,
      required String docno,
      required String username}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }
      var updattickete = await connections.query(
          "UPDATE data.t_issue SET status = 'Rejected',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),updateby = '$username' where docno = '$docno'");
      var updateworkflow = await connections.query(
          "UPDATE data.workflow SET currentlines = '0', isdone = '0', isreject = '1' where docno = '$docno' and currentlines = '1' ");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<List<ReportModel>> Report(
      {required BuildContext context,
      required String from,
      required String to}) async {
    var data;
    List<ReportModel> listData = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      print('ini from $from ini to $to');
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.report where TO_DATE(requestdate,'DD/Mon/YYYY') BETWEEN TO_DATE('$from','DD/Mon/YYYY') and TO_DATE('$to','DD/Mon/YYYY')",
      );
      print(result.length);
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          listData.add(ReportModel.fromMap(data[0]));
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return listData;
  }

  static Future<List<ShowStatusModel>> Showstatus({
    required BuildContext context,
    required String docno,
  }) async {
    var data1;
    var data2;
    List<ShowStatusModel> listData = [];
    String cases = "";
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<Map<String, Map<String, dynamic>>> resultGroup =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.workflow WHERE DOCNO = '$docno' and  id in (select max(id) from data.workflow where DOCNO = '$docno' group by workflowid,workflowpathid,workflowlinesid,idpararelline)",
      );
      if (resultGroup.length > 0) {
        for (var element in resultGroup) {
          data1 = element.values.toList();
          print(data1[0]['closedate'].toString());
          if (data1[0]['closedate'] != null) {
            cases = "and closedate is not null and username = closebyusername";
          } else {
            cases = "";
          }
          List<Map<String, Map<String, dynamic>>> result =
              await connections.mappedResultsQuery(
            "SELECT * FROM data.workflow WHERE docno = '$docno' and workflowid = '${data1[0]['workflowid'].toString()}' and workflowlinesid = '${data1[0]['workflowlinesid'].toString()}' $cases",
          );
          List<ShowStatusModel> displayPIC = [];
          if (result.length > 0) {
            for (var element in result) {
              print(element.toString());
              data2 = element.values.toList();
              displayPIC.add(ShowStatusModel.fromMap(data2[0]));
            }
          }
          ShowStatusModel dataTemp = ShowStatusModel.fromMap(data1[0]);
          dataTemp.displayPIC = displayPIC;
          listData.add(dataTemp);
        }
      } else {
        showSnackBar(context, "Connection Failed", "Retry workflow 1");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry workflow 2");
    }
    return listData;
  }

  static Future<String> createTicket(
      {required BuildContext context,
      required String description,
      required String username,
      required String createdby,
      required String status,
      required String email,
      required String updateby,
      required String attachments,
      required String userid,
      required String phone}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }
      String docnos = "2300000000000001";
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.t_issue",
      );

      if (result.length > 0) {
        var docno = await connections
            .query("select max(docno::DECIMAL)+1 from data.t_issue");
        docnos = docno.toString().replaceAll("[", "").replaceAll("]", "");
      }
      List<Map<String, Map<String, dynamic>>> listUser =
          await connections.mappedResultsQuery(
        "select username, name from data.user where useraccess = 'helpdesk'",
      );

      for (var element in listUser) {
        data = element.values.toList();
        print(data[0]['name'].toString());
        var name = data[0]['name'].toString();
        var username = data[0]['username'].toString();
        var insert3 = await connections.query(
          "INSERT INTO data.workflow (id,docno,modulecode,"
          "workflowid,workflowcode,workflowname,workflowpathid,workflowlinesid,idpararelline,groupworkflowcode"
          ",activity,createdby,username,desclines,currentlines,name,isdone,isreject,isreturn,createdatestamp) "
          "VALUES ('${uuid.v4()}','$docnos','HD-IS','2','HD-IS_WF','Helpdesk Issue Workflow'"
          ",'1','1','1','QRH_HELPDESK','Review','$username'"
          ",'$username','Review Helpdesk','1','$name','0','0','0',NOW())",
        );
      }
      var insert1 = await connections.query(
        "INSERT INTO data.t_issue (isquickresponsehelpdesk,updatectr,description,"
        "username,createby,status,createdate,updatedate,email,updateby"
        ",attachments,docno,id,userid,phonenumber,worklocation,picworklocation) "
        "VALUES ('1','0','$description','$username','$createdby','$status'"
        ",to_char(CURRENT_DATE, 'dd-mon-yyyy'),to_char(CURRENT_DATE, 'dd-mon-yyyy'),'$email','$updateby','$attachments'"
        ",'$docnos','${uuid.v4()}','$userid','$phone','Inbisco - Daan Mogot','Inbisco - Daan Mogot')",
      );
      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<List<String>> requestFor(
      {required BuildContext context,
      required String username,
      required String ua}) async {
    var data;
    var query;
    List<String> listData = [];
    List<Map<String, Map<String, dynamic>>> result = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (ua != 'helpdesk') {
        result = await connections.mappedResultsQuery(
          "SELECT (username || ' - ' || name ||  '/' || email) as user FROM data.user where username = '$username'",
        );
      } else {
        List<Map<String, Map<String, dynamic>>> resultTemp =
            await connections.mappedResultsQuery(
          "SELECT (username || ' - ' || name ||  '/' || email) as user FROM data.user where username != '$username'",
        );
        result = await connections.mappedResultsQuery(
          "SELECT (username || ' - ' || name ||  '/' || email) as user FROM data.user where username = '$username'",
        );
        result.addAll(resultTemp);
      }

      print(result);
      if (result.length > 0) {
        print(result);
        // for (int i = 0; i < result.length; i++) {
        //   Map<String, Map<String, dynamic>> data = result[i];

        //   print(data[]);
        //   // listData.add(data["user"]);
        // }

        for (var element in result) {
          data = element.values.toList();
          listData.add(data[0]['user'].toString());
        }
      } else {
        showSnackBar(context, "Connection Failed", "Retry 1");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry 2");
    }
    return listData;
  }

  static Future<String> getEmail(
      {required BuildContext context, required String username}) async {
    var data;
    var query;
    String email = "";
    List<Map<String, Map<String, dynamic>>> result = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      result = await connections.mappedResultsQuery(
        "SELECT (email) as user FROM data.user where username like '%$username%'",
      );

      print(result);
      if (result.length > 0) {
        // for (int i = 0; i < result.length; i++) {
        //   Map<String, Map<String, dynamic>> data = result[i];

        //   print(data[]);
        //   // listData.add(data["user"]);
        // }

        for (var element in result) {
          data = element.values.toList();
          email = data[0]['user'].toString();
        }
      } else {
        showSnackBar(context, "Connection Failed", "Retry 1");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry 2");
    }
    return email;
  }

  static Future<List<CategoryModel>> master({
    required BuildContext context,
    required String supp,
    required String category,
    required String sub1,
  }) async {
    var data;
    List<CategoryModel> listData = [];
    String cases = "";
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (supp == "" && category == "" && sub1 == "") {
        cases =
            " where id in (select max(id) from data.master group by supportcategory)";
      } else if (supp != "" && category == "" && sub1 == "") {
        cases =
            " where supportcategory = '$supp' and category != '' and id in(select max(id) from data.master group by supportcategory,category)";
      } else if (supp != "" && category != "" && sub1 == "") {
        cases =
            " where supportcategory = '$supp' and category = '$category' and subcategory1 != '' and id in(select max(id) from data.master group by supportcategory,category,subcategory1)";
      } else {
        cases =
            " where supportcategory = '$supp' and category = '$category' and subcategory1 = '$sub1' and subcategory2 != '' and id in(select max(id) from data.master group by supportcategory,category,subcategory1,subcategory2)";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.master $cases",
      );
      print('ini length${listData.length}');
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          print(data[0].toString());
          // if (data[0]['supportcategory'] != null) {
          //   listData.add(CategoryModel.fromMap(data[0]));
          // } else if (data[0]['category'] != null) {
          //   listData.add(CategoryModel.fromMap(data[0]));
          // } else if (data[0]['subcategory1'] != null) {
          //   listData.add(CategoryModel.fromMap(data[0]));
          // } else if (data[0]['subcategory2'] != null) {
          //   listData.add(CategoryModel.fromMap(data[0]));
          // }
          listData.add(CategoryModel.fromMap(data[0]));
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry master 2");
    }
    return listData;
  }

  static Future<List<String>> filterMaster({
    required BuildContext context,
    required String supp,
    required String category,
    required String sub1,
  }) async {
    var data;
    List<String> listData = [];
    String cases = "";
    String select = "";
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (supp == "" && category == "" && sub1 == "") {
        select = "supportcategory";
      } else if (supp != "" && category == "" && sub1 == "") {
        print("1");
        cases = " where supportcategory = '$supp'";
        select = "category";
      } else if (supp != "" && category != "" && sub1 == "") {
        print("2");
        cases = " where supportcategory = '$supp' and category = '$category'";
        select = "subcategory1";
      }
      print(cases);
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT distinct $select as data FROM data.master $cases",
      );
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          if (data[0]['data'] != null && data[0]['data'] != '') {
            listData.add(data[0]['data']);
          }
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry master 2");
    }
    return listData;
  }

  static Future<List<String>> topdashboard(
      {required BuildContext context, required String filter}) async {
    String cases = "";
    var data;
    List<String> listData = [];
    final rnd = math.Random();
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (filter == "Day") {
        cases = "to_date(createdate, 'dd-mon-yyyy') = CURRENT_DATE ";
      } else if (filter == "Week") {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '1 week' ";
      } else {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '4 week' ";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "select (supportcategory || ' / ' || count(supportcategory)) as data from data.t_issue where $cases and supportcategory is not null group by supportcategory",
      );
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          print(data[0].toString());
          listData.add(data[0]['data']);
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry master 2");
    }
    return listData;
  }

  static Future<List<DashboardData>> dashboard(
      {required BuildContext context, required String filter}) async {
    String cases = "";
    var data;
    List<DashboardData> listData = [];
    final rnd = math.Random();
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (filter == "Day") {
        cases = "to_date(createdate, 'dd-mon-yyyy') = CURRENT_DATE ";
      } else if (filter == "Week") {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '1 week' ";
      } else {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '4 week' ";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "select status || ' / ' || count(status) as data from data.t_issue where $cases and supportcategory is not null group by status",
      );
      if (result.length > 0) {
        // varchar
        for (var element in result) {
          data = element.values.toList();
          print(data[0]['data'].toString());
          listData.add(DashboardData(
              data[0]['data'].toString().split("/")[0],
              double.parse(data[0]['data'].toString().split("/")[1]),
              Color(rnd.nextInt(0xffffffff))));
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry master 2");
    }
    return listData;
  }

  static Future<List<String>> categorydashboard({
    required BuildContext context,
    required String filter,
  }) async {
    String cases = "";
    var data;
    List<String> listData = [];
    final rnd = math.Random();
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      if (filter == "Day") {
        cases = "to_date(createdate, 'dd-mon-yyyy') = CURRENT_DATE";
      } else if (filter == "Week") {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '1 week'";
      } else {
        cases =
            "to_date(createdate, 'dd-mon-yyyy') >= CURRENT_DATE - interval '4 week'";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "select supportcategory as data from data.t_issue where $cases and supportcategory is not null group by supportcategory",
      );
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          print(data[0]['data'].toString());
          listData.add(data[0]['data'].toString());
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry master 2");
    }
    return listData;
  }

  static Future<String> createMaster({
    required BuildContext context,
    required String supportcategory,
    required String username,
    required String category,
    required String subcategory1,
    required String subcategory2,
  }) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var insert = await connections.query(
          "INSERT INTO data.master ( updateddate, createddate, supportcategory, id, updatedby, createdby, category, subcategory1, subcategory2)"
          "VALUES ( to_char(CURRENT_DATE, 'dd-mon-yyyy'), to_char(CURRENT_DATE, 'dd-mon-yyyy'), '$supportcategory', '${uuid.v4()}', '$username', '$username', '$category', '$subcategory1', '$subcategory2' )");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<String> updateMaster(
      {required BuildContext context,
      required String supportcategory,
      required String username,
      required String category,
      required String subcategory1,
      required String subcategory2,
      required String id}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var update = await connections.query(
          "UPDATE data.master SET updateddate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),supportcategory = '$supportcategory',id = '${uuid.v4()}',updatedby = '$username',category = '$category', subcategory1 = '$subcategory1', subcategory2 = '$subcategory2' where id = '$id'");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<String> deleteMaster({
    required BuildContext context,
    required String id,
  }) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var insert =
          await connections.query("DELETE FROM data.master where id = '$id'");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<List<String>> pic(
      {required BuildContext context,
      required String ua,
      required String groupcode}) async {
    List<String> dataUser = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<
          Map<
              String,
              Map<String,
                  dynamic>>> result = await connections.mappedResultsQuery(
          "SELECT (username || '-' || name) as data  FROM data.user WHERE useraccess = '$ua' AND groupcode = '$groupcode'");
      if (result.length > 0) {
        for (var element in result) {
          var data = element.values.toList();
          dataUser.add(data[0]['data'].toString());
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Login Failed", "Invalid Username or Password");
    }
    return dataUser;
  }

  static Future<List<BrowseIssueDetail>> joblist(
      {required BuildContext context,
      required String username,
      required String type}) async {
    var data;
    String cases = "";
    List<BrowseIssueDetail> listData = [];
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      // if (type == 'progress') {
      //   cases = " and status = 'Open' ";
      // } else {
      //   cases = " and status = 'Close' ";
      // }
      // List<Map<String, Map<String, dynamic>>> result =
      //     await connections.mappedResultsQuery(
      //   "SELECT * FROM data.t_issue where assigned = '$username' $cases",
      // );

      if (type == 'progress') {
        cases =
            " status = 'Open' and docno in(SELECT docno FROM data.workflow where username = '$username' and currentlines = '1')";
      } else {
        cases =
            " status = 'Close' or status = 'Returned' and docno in(SELECT docno FROM data.workflow where username = '$username' and isdone = '1')";
      }
      List<Map<String, Map<String, dynamic>>> result =
          await connections.mappedResultsQuery(
        "SELECT * FROM data.t_issue where $cases",
      );
      print(result);
      if (result.length > 0) {
        for (var element in result) {
          data = element.values.toList();
          listData.add(BrowseIssueDetail.fromMap(data[0]));
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Connection Failed", "Retry 2");
    }

    return listData;
  }

  static Future<String> review3Ticketpool(
      {required BuildContext context,
      required String username,
      required String correctiveaction,
      required String id,
      required String docno,
      required String problemidentification,
      required String support,
      required String repair}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }

      var updateworkflow = await connections.query(
          "UPDATE data.workflow SET currentlines = '0', isdone = '1',closedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),closebyusername = '$username',closedatestamp = now() where docno = '$docno' and currentlines = '1' ");

      var updattickete = await connections.query(
          "UPDATE data.t_issue SET status = 'Close',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),problemidentification = '$problemidentification',updateby = '$username',correctiveaction = '$correctiveaction',supporttype= '$support',repairtype = '$repair'   where id = '$id'");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<String> returnTicketpool(
      {required BuildContext context,
      required String docno,
      required String username}) async {
    String statusQuery;
    var data;
    try {
      var uuid = Uuid();
      if (await connections.isClosed) {
        await connections.open();
      }
      var updattickete = await connections.query(
          "UPDATE data.t_issue SET status = 'Returned',updatedate = to_char(CURRENT_DATE, 'dd-mon-yyyy'),updateby = '$username' where docno = '$docno'");
      var updateworkflow = await connections.query(
          "UPDATE data.workflow SET currentlines = '0', isdone = '0', isreject = '0', isreturn = '1' where docno = '$docno' and currentlines = '1' ");

      statusQuery = "true";
    } catch (e) {
      statusQuery = "false";
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }

  static Future<bool> checkgroupcode({
    required BuildContext context,
    required String username,
    required String docno,
  }) async {
    bool statusQuery;
    var data;
    try {
      if (await connections.isClosed) {
        await connections.open();
      }
      List<
          Map<
              String,
              Map<String,
                  dynamic>>> result = await connections.mappedResultsQuery(
          "select * from data.workflow wf where wf.docno = '$docno' and wf.currentlines = '1' AND wf.username = '$username'");
      if (result.length > 0) {
        statusQuery = true;
      } else {
        statusQuery = false;
      }
    } catch (e) {
      statusQuery = false;
      print(e);
      showSnackBar(context, "Connection Failed", "Retry");
    }
    return statusQuery;
  }
}
