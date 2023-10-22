abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userCountry;
  final String userBio;
  final String userPassword;

  RegisterUserEvent({
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userCountry,
    required this.userBio,
    required this.userPassword,
  });
}
