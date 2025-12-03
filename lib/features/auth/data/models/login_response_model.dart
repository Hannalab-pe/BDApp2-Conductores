import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'login_response_model.g.dart';

/// Modelo para respuesta de login
@JsonSerializable()
class LoginResponseModel {
  final String token;
  final String? refreshToken;
  final UserModel user;

  const LoginResponseModel({
    required this.token,
    this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
