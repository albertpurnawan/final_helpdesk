class BrowseIssue {
  int ticketNum;
  DateTime createdDate;
  String issueDesc;
  String requestFor;
  String createdBy;
  String status;
  String supportCategory;

  BrowseIssue({
    required this.ticketNum,
    required this.createdDate,
    required this.issueDesc,
    required this.requestFor,
    required this.createdBy,
    required this.status,
    required this.supportCategory,
  });

  BrowseIssue copy({
    int? ticketNum,
    DateTime? createdDate,
    String? issueDesc,
    String? requestFor,
    String? createdBy,
    String? status,
    String? supportCategory,
  }) =>
      BrowseIssue(
        ticketNum: ticketNum ?? this.ticketNum,
        createdDate: createdDate ?? this.createdDate,
        issueDesc: issueDesc ?? this.issueDesc,
        requestFor: requestFor ?? this.requestFor,
        createdBy: createdBy ?? this.createdBy,
        status: status ?? this.status,
        supportCategory: supportCategory ?? this.supportCategory,
      );
}
