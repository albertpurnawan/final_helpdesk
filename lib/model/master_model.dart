import 'dart:convert';
import 'dart:ffi';

class CategoryModel {
  String createddate;
  String updateddate;
  String supportcategory;
  String createdby;
  String updatedby;
  String id;
  String category;
  String subcategory1;
  String subcategory2;

  CategoryModel({
    required this.createddate,
    required this.updateddate,
    required this.supportcategory,
    required this.createdby,
    required this.updatedby,
    required this.id,
    required this.category,
    required this.subcategory1,
    required this.subcategory2,
  });

  Map<String, dynamic> toMap() {
    return {
      "createddate": createddate,
      "updateddate": updateddate,
      "supportcategory": supportcategory,
      "createdby": createdby,
      "updatedby": updatedby,
      "id": id,
      "category": category,
      "subcategory1": subcategory1,
      "subcategory2": subcategory2,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      createddate: map['createddate'] ?? '',
      updateddate: map['updateddate'] ?? '',
      supportcategory: map['supportcategory'] ?? '',
      createdby: map['createdby'] ?? '',
      updatedby: map['updatedby'] ?? '',
      id: map['id'] ?? '',
      category: map['category'] ?? '',
      subcategory1: map['subcategory1'] ?? '',
      subcategory2: map['subcategory2'] ?? '',
    );
  }
}

// class dataFilterModel {
//   appProblemPICModel ProbPIC;
//   allowToOpenIssuePoolPageModel OpenIssue;
//   optionsWorklocationModel Worklocation;
//   optionsCommunicationByModel CommuniBy;

//   dataFilterModel({
//     required this.ProbPIC,
//     required this.OpenIssue,
//     required this.Worklocation,
//     required this.CommuniBy,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       "ProbPIC": ProbPIC,
//       "OpenIssue": OpenIssue,
//       "Worklocation": Worklocation,
//       "CommuniBy": CommuniBy,
//     };
//   }

//   factory dataFilterModel.fromMap(Map<String, dynamic> map) {
//     return dataFilterModel(
//       ProbPIC: map['ProbPIC'],
//       OpenIssue: map['OpenIssue'],
//       Worklocation: map['Worklocation'],
//       CommuniBy: map['CommuniBy'],
//     );
//   }
// }

// class appProblemPICModel {
//   List<Object> data;
//   appProblemPICModel({required this.data});
//   Map<String, dynamic> toMap() {
//     return {
//       "data": List<dynamic>.from(data.map((x) => x.toMap())),
//     };
//   }

//   factory appProblemPICModel.fromMap(Map<String, dynamic> map) {
//     return appProblemPICModel(
//       data: (json.decode(map['application_problem_pic']) as List)
//           .map((i) => Object.fromMap(i))
//           .toList(),
//     );
//   }
// }

// class Object {
//   List<String> applicationCode;
//   List<PIC> pic;

//   Object({required this.applicationCode, required this.pic});

//   Map<String, dynamic> toMap() => {
//         "applicationCode": List<String>.from(applicationCode),
//         "pic": List<dynamic>.from(pic.map((x) => x.toMap())),
//       };

//   factory Object.fromMap(Map<String, dynamic> map) {
//     return Object(
//         applicationCode: List<String>.from(json.decode(map['applicationCode'])),
//         pic: (json.decode(map['pic']) as List)
//             .map((i) => PIC.fromMap(i))
//             .toList());
//   }
// }

// class PIC {
//   String name;
//   String username;

//   PIC({required this.name, required this.username});

//   Map<String, dynamic> toMap() => {
//         "name": name,
//         "username": username,
//       };

//   factory PIC.fromMap(Map<String, dynamic> map) {
//     return PIC(
//       name: map['name'] ?? '',
//       username: map['username'] ?? '',
//     );
//   }
// }

// class allowToOpenIssuePoolPageModel {
//   Bool bool;

//   allowToOpenIssuePoolPageModel({required this.bool});

//   Map<String, dynamic> toMap() => {
//         "bool": bool,
//       };

//   factory allowToOpenIssuePoolPageModel.fromMap(Map<String, dynamic> map) {
//     return allowToOpenIssuePoolPageModel(
//       bool: map['bool'] ?? false,
//     );
//   }
// }

// class optionsWorklocationModel {
//   String worklocationcode;
//   String worklocationname;

//   optionsWorklocationModel(
//       {required this.worklocationcode, required this.worklocationname});

//   Map<String, dynamic> toMap() => {
//         "bool": bool,
//       };

//   factory optionsWorklocationModel.fromMap(Map<String, dynamic> map) {
//     return optionsWorklocationModel(
//       worklocationcode: map['worklocationcode'] ?? '',
//       worklocationname: map['worklocationname'] ?? '',
//     );
//   }
// }

// class optionsCommunicationByModel {
//   String data;

//   optionsCommunicationByModel({
//     required this.data,
//   });

//   Map<String, dynamic> toMap() => {
//         "data": data,
//       };

//   factory optionsCommunicationByModel.fromMap(Map<String, dynamic> map) {
//     return optionsCommunicationByModel(
//       data: map['data'] ?? '',
//     );
//   }
// }
