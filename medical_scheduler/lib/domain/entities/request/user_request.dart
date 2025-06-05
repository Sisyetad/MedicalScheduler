class UserRequest {
  final String? name;
  final String? location;
  final String email;
  final String? phone;
  final int? registedby;

  UserRequest({
    required this.email,
    this.location,
    this.name,
    this.phone,
    this.registedby
  });
}
