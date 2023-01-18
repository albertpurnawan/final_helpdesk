import 'dart:convert';
import 'dart:ffi';

class dataCategoryModel {
  suppCategoryModel supCat;
  CategoryModel cat;
  subCategory1Model subcat1;
  subCategory2Model subcat2;

  dataCategoryModel({
    required this.supCat,
    required this.cat,
    required this.subcat1,
    required this.subcat2,
  });

  Map<String, dynamic> toMap() {
    return {
      "supCat": supCat,
      "cat": cat,
      "subcat1": subcat1,
      "subcat2": subcat2,
    };
  }

  factory dataCategoryModel.fromMap(Map<String, dynamic> map) {
    return dataCategoryModel(
      supCat: map['supCat'],
      cat: map['cat'],
      subcat1: map['subcat1'],
      subcat2: map['subcat2'],
    );
  }
}

class suppCategoryModel {
  String createddate;
  String updateddate;
  String supportcategory;
  String createdby;
  String updatedby;
  String id;
  String status;
  String isdeleted;

  suppCategoryModel({
    required this.createddate,
    required this.updateddate,
    required this.supportcategory,
    required this.createdby,
    required this.updatedby,
    required this.id,
    required this.status,
    required this.isdeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      "createddate": createddate,
      "updateddate": updateddate,
      "supportcategory": supportcategory,
      "createdby": createdby,
      "updatedby": updatedby,
      "id": id,
      "status": status,
      "isdeleted": isdeleted,
    };
  }

  factory suppCategoryModel.fromMap(Map<String, dynamic> map) {
    return suppCategoryModel(
      createddate: map['createddate'] ?? '',
      updateddate: map['updateddate'] ?? '',
      supportcategory: map['supportcategory'] ?? '',
      createdby: map['createdby'] ?? '',
      updatedby: map['updatedby'] ?? '',
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      isdeleted: map['isdeleted'] ?? '',
    );
  }
}

class CategoryModel {
  String updateddate;
  String createddate;
  String category;
  String isdeleted;
  String id;
  String updatedby;
  String createdby;
  String m_qrh_supp_category_id;
  String status;

  CategoryModel({
    required this.updateddate,
    required this.createddate,
    required this.category,
    required this.isdeleted,
    required this.id,
    required this.updatedby,
    required this.createdby,
    required this.m_qrh_supp_category_id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "updateddate": updateddate,
      "createddate": createddate,
      "supportcategory": category,
      "isdeleted": isdeleted,
      "id": id,
      "updatedby": updatedby,
      "createdby": createdby,
      "m_qrh_supp_category_id": m_qrh_supp_category_id,
      "status": status,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      createddate: map['createddate'] ?? '',
      updateddate: map['updateddate'] ?? '',
      category: map['category'] ?? '',
      isdeleted: map['isdeleted'] ?? '',
      id: map['id'] ?? '',
      updatedby: map['updatedby'] ?? '',
      createdby: map['createdby'] ?? '',
      m_qrh_supp_category_id: map['m_qrh_supp_category_id'] ?? '',
      status: map['status'] ?? '',
    );
  }
}

class subCategory1Model {
  String updateddate;
  String createddate;
  String subcategory1;
  String isdeleted;
  String id;
  String updatedby;
  String createdby;
  String m_qrh_category_id;
  String status;

  subCategory1Model({
    required this.updateddate,
    required this.createddate,
    required this.subcategory1,
    required this.isdeleted,
    required this.id,
    required this.updatedby,
    required this.createdby,
    required this.m_qrh_category_id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "updateddate": updateddate,
      "createddate": createddate,
      "subcategory1": subcategory1,
      "isdeleted": isdeleted,
      "id": id,
      "updatedby": updatedby,
      "createdby": createdby,
      "m_qrh_category_id": m_qrh_category_id,
      "status": status,
    };
  }

  factory subCategory1Model.fromMap(Map<String, dynamic> map) {
    return subCategory1Model(
      createddate: map['createddate'] ?? '',
      updateddate: map['updateddate'] ?? '',
      subcategory1: map['subcategory1'] ?? '',
      isdeleted: map['isdeleted'] ?? '',
      id: map['id'] ?? '',
      updatedby: map['updatedby'] ?? '',
      createdby: map['createdby'] ?? '',
      m_qrh_category_id: map['m_qrh_category_id'] ?? '',
      status: map['status'] ?? '',
    );
  }
}

class subCategory2Model {
  String updateddate;
  String createddate;
  String subcategory2;
  String isdeleted;
  String id;
  String updatedby;
  String createdby;
  String m_qrh_subcategory1_id;
  String status;

  subCategory2Model({
    required this.updateddate,
    required this.createddate,
    required this.subcategory2,
    required this.isdeleted,
    required this.id,
    required this.updatedby,
    required this.createdby,
    required this.m_qrh_subcategory1_id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "updateddate": updateddate,
      "createddate": createddate,
      "subcategory2": subcategory2,
      "isdeleted": isdeleted,
      "id": id,
      "updatedby": updatedby,
      "createdby": createdby,
      "m_qrh_subcategory1_id": m_qrh_subcategory1_id,
      "status": status,
    };
  }

  factory subCategory2Model.fromMap(Map<String, dynamic> map) {
    return subCategory2Model(
      createddate: map['createddate'] ?? '',
      updateddate: map['updateddate'] ?? '',
      subcategory2: map['subcategory2'] ?? '',
      isdeleted: map['isdeleted'] ?? '',
      id: map['id'] ?? '',
      updatedby: map['updatedby'] ?? '',
      createdby: map['createdby'] ?? '',
      m_qrh_subcategory1_id: map['m_qrh_subcategory1_id'] ?? '',
      status: map['status'] ?? '',
    );
  }
}

class dataFilterModel {
  appProblemPICModel ProbPIC;
  allowToOpenIssuePoolPageModel OpenIssue;
  optionsWorklocationModel Worklocation;
  optionsCommunicationByModel CommuniBy;

  dataFilterModel({
    required this.ProbPIC,
    required this.OpenIssue,
    required this.Worklocation,
    required this.CommuniBy,
  });

  Map<String, dynamic> toMap() {
    return {
      "ProbPIC": ProbPIC,
      "OpenIssue": OpenIssue,
      "Worklocation": Worklocation,
      "CommuniBy": CommuniBy,
    };
  }

  factory dataFilterModel.fromMap(Map<String, dynamic> map) {
    return dataFilterModel(
      ProbPIC: map['ProbPIC'],
      OpenIssue: map['OpenIssue'],
      Worklocation: map['Worklocation'],
      CommuniBy: map['CommuniBy'],
    );
  }
}

class appProblemPICModel {
  List<Object> data;
  appProblemPICModel({required this.data});
  Map<String, dynamic> toMap() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
  }

  factory appProblemPICModel.fromMap(Map<String, dynamic> map) {
    return appProblemPICModel(
      data: (json.decode(map['application_problem_pic']) as List)
          .map((i) => Object.fromMap(i))
          .toList(),
    );
  }
}

class Object {
  List<String> applicationCode;
  List<PIC> pic;

  Object({required this.applicationCode, required this.pic});

  Map<String, dynamic> toMap() => {
        "applicationCode": List<String>.from(applicationCode),
        "pic": List<dynamic>.from(pic.map((x) => x.toMap())),
      };

  factory Object.fromMap(Map<String, dynamic> map) {
    return Object(
        applicationCode: List<String>.from(json.decode(map['applicationCode'])),
        pic: (json.decode(map['pic']) as List)
            .map((i) => PIC.fromMap(i))
            .toList());
  }
}

class PIC {
  String name;
  String username;

  PIC({required this.name, required this.username});

  Map<String, dynamic> toMap() => {
        "name": name,
        "username": username,
      };

  factory PIC.fromMap(Map<String, dynamic> map) {
    return PIC(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

class allowToOpenIssuePoolPageModel {
  Bool bool;

  allowToOpenIssuePoolPageModel({required this.bool});

  Map<String, dynamic> toMap() => {
        "bool": bool,
      };

  factory allowToOpenIssuePoolPageModel.fromMap(Map<String, dynamic> map) {
    return allowToOpenIssuePoolPageModel(
      bool: map['bool'] ?? false,
    );
  }
}

class optionsWorklocationModel {
  String worklocationcode;
  String worklocationname;

  optionsWorklocationModel(
      {required this.worklocationcode, required this.worklocationname});

  Map<String, dynamic> toMap() => {
        "bool": bool,
      };

  factory optionsWorklocationModel.fromMap(Map<String, dynamic> map) {
    return optionsWorklocationModel(
      worklocationcode: map['worklocationcode'] ?? '',
      worklocationname: map['worklocationname'] ?? '',
    );
  }
}

class optionsCommunicationByModel {
  String data;

  optionsCommunicationByModel({
    required this.data,
  });

  Map<String, dynamic> toMap() => {
        "data": data,
      };

  factory optionsCommunicationByModel.fromMap(Map<String, dynamic> map) {
    return optionsCommunicationByModel(
      data: map['data'] ?? '',
    );
  }
}
