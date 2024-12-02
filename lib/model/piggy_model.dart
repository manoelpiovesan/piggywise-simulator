///
///
///
class PiggyModel {
  int id = -1;
  String code = '';
  int balance = 0;
  String name = '';
  String description = '';

  ///
  ///
  ///
  PiggyModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    code = map['code'];
    balance = map['balance'];
    name = map['name'];
    description = map['description'];
  }

  ///
  ///
  ///
  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'code': code,
      'balance': balance,
      'name': name,
      'description': description,
    };
  }
}