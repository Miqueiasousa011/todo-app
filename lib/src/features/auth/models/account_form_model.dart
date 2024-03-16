class AccountFormModel {
  String? name;
  String? email;
  String? password;

  AccountFormModel({
    this.name,
    this.email,
    this.password,
  });

  bool get isValid =>
      name?.isNotEmpty == true && email?.isNotEmpty == true && password?.isNotEmpty == true;
}
