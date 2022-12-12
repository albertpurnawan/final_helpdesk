class TicketPool {
  int ticketNum;
  String status;
  String issueDesc;
  String requester;
  String requesterEmail;
  String requesterPhoneNum;
  String createdBy;
  DateTime createdDate;
  List<String> comunicationBy;
  List<String> supportCategory;
  List<String> category;

  TicketPool(
      {required this.ticketNum,
      required this.status,
      required this.issueDesc,
      required this.requester,
      required this.requesterEmail,
      required this.requesterPhoneNum,
      required this.createdBy,
      required this.createdDate,
      required this.comunicationBy,
      required this.supportCategory,
      required this.category});

  TicketPool copy({
    int? ticketNum,
    String? status,
    String? issueDesc,
    String? requester,
    String? requesterEmail,
    String? requesterPhoneNum,
    String? createdBy,
    DateTime? createdDate,
    List<String>? comunicationBy,
    List<String>? supportCategory,
    List<String>? category,
  }) =>
      TicketPool(
          ticketNum: ticketNum ?? this.ticketNum,
          createdDate: createdDate ?? this.createdDate,
          issueDesc: issueDesc ?? this.issueDesc,
          requester: requester ?? this.requester,
          requesterEmail: requesterEmail ?? this.requesterEmail,
          requesterPhoneNum: requesterPhoneNum ?? this.requesterPhoneNum,
          createdBy: createdBy ?? this.createdBy,
          status: status ?? this.status,
          comunicationBy: comunicationBy ?? this.comunicationBy,
          supportCategory: supportCategory ?? this.supportCategory,
          category: category ?? this.category);
}
