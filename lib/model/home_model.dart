import 'package:helpdesk_skripsi/model/login_model.dart';

class Home {
  String token;
  Future<UserProfile> dataUser;
  Future<String> image;

  Home({required this.token, required this.dataUser, required this.image});

  Home copy({
    String? token,
    Future<UserProfile>? dataUser,
    Future<String>? image,
  }) =>
      Home(
        token: token ?? this.token,
        dataUser: dataUser ?? this.dataUser,
        image: image ?? this.image,
      );
}
