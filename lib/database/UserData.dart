// Define your UserData model class
class UserData {
  final String name;
  final String email;
  final String password;
  // Add more fields as per your Firestore document

  UserData({
    required this.name,
    required this.email,
    required this.password,
    // Add more fields as per your Firestore document
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      // Add more fields as per your Firestore document
    );
  }
}