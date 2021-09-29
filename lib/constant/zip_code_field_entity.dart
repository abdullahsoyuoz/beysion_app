// Mock Test Item Class
class ZipCodeTextFieldEntity {
  String label;
  dynamic value;

  ZipCodeTextFieldEntity({this.label, this.value});

  factory ZipCodeTextFieldEntity.fromJson(Map<String, dynamic> json) {
    return ZipCodeTextFieldEntity(label: json['label'], value: json['value']);
  }
}