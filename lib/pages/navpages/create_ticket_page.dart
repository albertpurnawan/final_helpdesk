// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/login_form_field.dart';
import 'package:helpdesk_skripsi/util/statusCode.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pick_or_save/pick_or_save.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  String _fileText = "";

  var selectedValue;

  String imgurl = "";
  List<File> listFile = [];
  List<File> listPath = [];
  Future<void> saveFile(String fileName, List<int> bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
  }

  List<File> _selectedFiles = [];
  // Future<void> _storeFiles() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   for (File file in _selectedFiles) {
  //     String fileName = file.path.split("/").last;
  //     File storedFile = await file.copy(fileName);
  //     print("File stored at: ${storedFile.path}");
  //     Directory dir = Directory("C:/Users/alber/OneDrive/Pictures/");
  //     await dir.create();
  //   }
  // }
  final _pickOrSavePlugin = PickOrSave();

  List<bool> isSelected = [true, false];

  bool _isBusy = false;
  final bool _localOnly = false;
  List<String>? _pickedFilePath;

  String? _pickedDirectoryPath;
  DocumentFile? whatsappDocumentsDirectoryFile;

  List<String>? persistedUris;

  void selectMultipleFile() async => debounce(() async {
        // List<String>? filesPaths = await PickOrSave().filePicker(
        //   params: FilePickerParams(
        //       getCachedFilePath: false, enableMultipleSelection: true),
        // );
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'xls',
            'pdf',
            'docx',
            'xlsx',
            'jpeg',
            'jpg',
            'png',
            'gif',
            'doc',
            'ppt',
            'pptx',
            'txt'
          ],
          allowMultiple: true,
        );
        // print(filesPaths.toString());
        if (result != null) {
          List<File> files = result!.paths.map((path) => File(path!)).toList();
          List<File> files2 = result!.names.map((path) => File(path!)).toList();
          for (int i = 0; i < files.length; i++) {
            int sizeInBytes = files[i].lengthSync();
            double sizeInMb = sizeInBytes / (1024 * 1024);
            if (sizeInMb > 2) {
              showSnackBar(
                  context, "Failed", "Can't upload file more than 2MB");
            } else {
              print(files[i].toString().replaceAll("File: ", ""));
              print(files2[i].toString().replaceAll("File: ", ""));
              setState(() {
                listFile.add(files2[i]);
                listPath.add(files[i]);
                _selectedFiles = files;
                _fileText = result.names.toString();
              });
            }
          }
        } else {
          // user canceled the picker
        }
      });

  void downloadFile(att, bytes) async => debounce(() async {
        Uint8List data = await bytes.readAsBytes();
        print("ini att = $att");
        List<String> splitString = att
            .toString()
            .replaceAll("File: ", "")
            .replaceAll("'", "")
            .split(".");
        print("ini length ${splitString[splitString.length - 1]}");
        MimeType type = MimeType.OTHER;
        if (splitString.length > 1) {
          String typeFile = splitString[splitString.length - 1];
          if (typeFile.toLowerCase() == "pdf") {
            type = MimeType.PDF;
          } else if (typeFile.toLowerCase() == "xls" ||
              typeFile.toLowerCase() == "xlsx") {
            type = MimeType.MICROSOFTEXCEL;
          } else if (typeFile.toLowerCase() == "docx" ||
              typeFile.toLowerCase() == "doc") {
            type = MimeType.MICROSOFTWORD;
          } else if (typeFile.toLowerCase() == "jpeg" ||
              typeFile.toLowerCase() == "jpg") {
            type = MimeType.JPEG;
          } else if (typeFile.toLowerCase() == "png") {
            type = MimeType.PNG;
          } else if (typeFile.toLowerCase() == "gif") {
            type = MimeType.GIF;
          } else if (typeFile.toLowerCase() == "ppt" ||
              typeFile.toLowerCase() == "pptx") {
            type = MimeType.MICROSOFTPRESENTATION;
          } else if (typeFile.toLowerCase() == "txt") {
            type = MimeType.TEXT;
          }
          String path = await FileSaver.instance.saveAs(
              att.toString().replaceAll("File: ", "").replaceAll("'", ""),
              data,
              "",
              type);
          print(" ini contoh path = $path");
        } else {
          showSnackBar(context, "Failed", "Failed to download file");
        }
      });

  void saveMultipleFiles(List<Uint8List> dataList, List<String> fileNameList,
      List<String> mimeTypeList) {
    DocumentFileSavePlus.saveMultipleFiles(
        dataList, fileNameList, mimeTypeList);
  }

  final TextEditingController req = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController desc = TextEditingController();
  String emails = "";
  final _formKey = GlobalKey<FormState>();
  User user = User(
      username: '',
      password: '',
      ua: '',
      email: '',
      image: '',
      name: '',
      groupcode: '',
      empid: "",
      groupname: "");
  bool loading = true;
  bool _readOnly = false;
  bool _enable = true;
  List<String> items = [];
  Timer? debouncer;
  String search = "";
  @override
  void initState() {
    super.initState();
    loading = true;
    // setState(() {
    //   desc.text = "";
    //   req.text = "";
    //   email.text = "";
    //   listPath = [];
    //   listFile = [];
    //   phone.text = "";
    // });
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callBack, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callBack);
  }

  void dataLoaded() {
    setState(() {
      loading = false;
    });
  }

  Future init() async => debounce(() async {
        setState(() {
          desc.text = "";
          req.text = "";
          email.text = "";
          listPath = [];
          listFile = [];
          phone.text = "";
        });
        final itemsTemp = await controller.requestFor(
            context: context, username: user.username, ua: user.ua);
        print(itemsTemp);
        if (!mounted) return;
        List<String> items = [];
        setState(() {
          selectedValue = itemsTemp[0].split('/')[0];
          req.text = itemsTemp[0];
          email.text = itemsTemp[0].split('/')[1];
          print(req.text);
          for (int i = 0; i < itemsTemp.length; i++) {
            items.add(itemsTemp[i].split('/')[0]);
          }
          this.items = items;
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    print(user.ua);
    setState(() {
      if (user.ua != 'helpdesk') {
        _enable = false;
        _readOnly = true;
      } else {
        _readOnly = false;
      }
      this.user = user;
    });
    return Scaffold(
      backgroundColor: primaryColor,
      // drawer: const MyDrawer(),
      appBar: MyAppBar(
        title: "Create Ticket",
        showBackBtn: false,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: loading
          ? loadingImage()
          : SingleChildScrollView(
              // child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Create Ticket Card
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        // width: 300,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Ticket',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '* Please fill all required inputs',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: secondaryColor,
                                ),
                              ),
                              Divider(
                                color: secondaryColor,
                                thickness: 2,
                              ),
                              const SizedBox(height: 20),
                              DropdownSearch<String>(
                                enabled: _enable,
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  disabledItemFn: (String s) =>
                                      s.startsWith('I'),
                                ),
                                items: items,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Request For *",
                                  ),
                                ),
                                onChanged: (value) async {
                                  final emailCurr = await controller.getEmail(
                                      context: context,
                                      username: value!.split(" - ")[0]);
                                  setState(() {
                                    print(value);
                                    req.text = value;
                                    selectedValue = value;
                                    email.text = emailCurr;
                                  });
                                },
                                selectedItem: selectedValue,
                              ),

                              // LoginFormField(
                              //   hintText: 'Request For *',
                              //   obscureText: false,
                              //   icon: Icons.person,
                              //   color: greyColor,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter request for';
                              //     } else {
                              //       setState(() {
                              //         req.text = value;
                              //       });
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const SizedBox(height: 20),
                              LoginFormField(
                                enable: _readOnly,
                                hintText: 'Email *',
                                defaultValue: email,
                                obscureText: false,
                                icon: Icons.email,
                                color: greyColor,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  } else {
                                    setState(() {
                                      email.text = value!;
                                    });
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              LoginFormField(
                                hintText: 'Phone Number',
                                obscureText: false,
                                icon: Icons.phone,
                                color: greyColor,
                                type: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  } else {
                                    setState(() {
                                      phone.text = value;
                                    });
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              LoginFormField(
                                hintText: 'Description *',
                                obscureText: false,
                                icon: Icons.description,
                                color: greyColor,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter description';
                                  } else {
                                    setState(() {
                                      desc.text = value;
                                    });
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              // Add file and submit btn
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: greyColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: _isBusy
                                        ? null
                                        : () {
                                            selectMultipleFile();
                                          },
                                    icon: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    ),
                                    label: Text(
                                      "Add New File",
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Map<Permission, PermissionStatus> statuses =
                                      //     await [
                                      //   Permission.storage,
                                      //   //add more permission to request here.
                                      // ].request();

                                      // if (statuses[Permission.storage]!.isGranted) {
                                      //   var dir = await DownloadsPathProvider
                                      //       .downloadsDirectory;
                                      //   if (dir != null) {
                                      //     String savename = "banner.png";
                                      //     String savePath = dir.path + "/$savename";
                                      //     print(savePath);
                                      //     //output:  /storage/emulated/0/Download/banner.png

                                      //     try {
                                      //       await Dio().download(imgurl, savePath,
                                      //           onReceiveProgress: (received, total) {
                                      //         if (total != -1) {
                                      //           print((received / total * 100)
                                      //                   .toStringAsFixed(0) +
                                      //               "%");
                                      //           //you can build progressbar feature too
                                      //         }
                                      //       });
                                      //       print(
                                      //           "Image is saved to download folder.");
                                      //     } on DioError catch (e) {
                                      //       print(e.message);
                                      //     }
                                      //   }
                                      // } else {
                                      //   print("No permission to read and write.");
                                      // }
                                      // print(req.text);

                                      if (_formKey.currentState!.validate()) {
                                        String insert = await controller.createTicket(
                                            context: context,
                                            description: desc.text,
                                            username: req.text
                                                .split(" - ")[1]
                                                .split("/")[0],
                                            createdby:
                                                '${user.username} - ${user.name}',
                                            status: "Pending",
                                            email: email.text,
                                            updateby: user.username,
                                            attachments:
                                                "${listPath.toString().replaceAll("File:", "").replaceAll("'", "")}",
                                            userid: req.text.split(" - ")[0],
                                            phone: phone.text);
                                        if (insert == "true") {
                                          setState(() {
                                            loading = false;
                                          });
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.scale,
                                            headerAnimationLoop: true,
                                            dialogType: DialogType.success,
                                            title: 'Succes',
                                            desc: 'Successfully create ticket',
                                            btnOkOnPress: () {
                                              if (user.groupcode != 'IT004') {
                                                Get.toNamed(
                                                    RouteClass.ticketPool,
                                                    arguments: user);
                                              } else {
                                                Get.toNamed(RouteClass.main,
                                                    arguments: user);
                                              }
                                            },
                                            btnOkIcon: Icons.check_circle,
                                          ).show();
                                        }
                                      }
                                      // _storeFiles();
                                    },
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // notes
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 20,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "File size must less than 2Mb",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: secondaryColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // file attachment card
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text("Attachments",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: listFile.length,
                                    separatorBuilder: (_, __) =>
                                        const Divider(),
                                    itemBuilder: (context, index) {
                                      var att = listFile[index];
                                      if (listFile.isNotEmpty && att != '[]') {
                                        return Column(
                                          children: [
                                            Card(
                                              elevation: 5,
                                              color: primaryColor,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  downloadFile(
                                                      att, listPath[index]);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      att
                                                          .toString()
                                                          .replaceAll(
                                                              "File: ", "")
                                                          .replaceAll("'", ""),
                                                      style: GoogleFonts.inter(
                                                          fontSize: 12,
                                                          color: secondaryColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Text("No Attachment",
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: primaryColor,
                                            ));
                                      }
                                    },
                                  ),
                                ])),
                            listFile.isEmpty
                                ? Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Lottie.asset(
                                            "assets/lottie/sleep.json"),
                                      ),
                                      Text(
                                        "No files attached",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: blackColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // ),
            ),
      // bottomNavigationBar: const BottomNavbar(),
    );
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottie/loading.json"),
          ),
        ],
      ),
    );
  }
}
