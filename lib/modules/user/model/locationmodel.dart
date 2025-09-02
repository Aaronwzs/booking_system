class locationModel{

final String? id;
final String locName;
final int? locAddress;
final int locAvailability;
final int status;


locationModel({
     this.id,
    required this.locName,
    required this.locAddress,
    required this.locAvailability,
    required this.status,
  });

  factory locationModel.fromMap(Map<String, dynamic> map) {
    return locationModel(
      id: map['id']?.toString(),
      locName: map['loc_name'],
      locAddress: map['loc_address'],
      locAvailability: map['loc_availability'],
      status: map['status'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'loc_name': locName,
      'loc_address': locAddress,
      'loc_availabilty': locAvailability,
      'status': status,
    };
  }
}