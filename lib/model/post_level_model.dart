class Profile {
  final int id;
  final String fatherName;
  final String contactNumber;
  final String emergencyContact;
  final String remarks;
  final String studentName;
  final String address;
  final String zipcode;
  final String aboutYourself;
  final String gender;
  final String age;
  final String level;
  final String image;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;

  Profile({
    required this.id,
    required this.fatherName,
    required this.contactNumber,
    required this.emergencyContact,
    required this.remarks,
    required this.studentName,
    required this.address,
    required this.zipcode,
    required this.aboutYourself,
    required this.gender,
    required this.age,
    required this.level,
    required this.image,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ Parse full JSON response from API
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      fatherName: json['f_father_name'] ?? '',
      contactNumber: json['f_contact_number'] ?? '',
      emergencyContact: json['f_emergency_contact'] ?? '',
      remarks: json['f_remarks'] ?? '',
      studentName: json['s_name'] ?? '',
      address: json['s_address'] ?? '',
      zipcode: json['s_zipcode'] ?? '',
      aboutYourself: json['s_about_youself'] ?? '',
      gender: json['s_gender'] ?? '',
      age: json['s_age'] ?? '',
      level: json['s_level'] ?? '',
      image: json['s_image'] ?? '',
      createdBy: json['created_by'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  /// ✅ Send only `s_level` when posting to API
  Map<String, dynamic> toJson() {
    return {'s_level': level};
  }
}
