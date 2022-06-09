class Func {
  String? id;

  String? name;

  int? age;

  int? phone;

  int? cpf;

  String? address;

  String? salary;

  Func(
    {this.age,
    this.name,
    this.phone,
    this.cpf,
    this.address,
    this.salary}
  );

  //convert object MAP in Client
  Func.fromMap(Map<String, dynamic> map)
    : name = map["name"],
      age = map["age"],
      address = map["address"],
      salary = map["salary"];

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'age': age,
      'address': address,
      'salary': salary
    };
  }

}