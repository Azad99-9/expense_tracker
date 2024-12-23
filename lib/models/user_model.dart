class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String dailyThresold;
  final String monthlyThresold;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    required this.dailyThresold,
    required this.monthlyThresold,
  });

  // From JSON method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] ?? 'user',
      dailyThresold: json['dailyThresold'] ?? '0',
      monthlyThresold: json['monthlyThresold'] ?? '0',
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name ?? '',
      'dailyThresold': dailyThresold,
      'monthlyThresold': monthlyThresold,
    };
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, dailyThresold: $dailyThresold, monthlyThresold: $monthlyThresold)';
  }
}
