class Client {
  late final String id;

  late final String name;

  late final int age;

  late final int cpf;

  late final int phone;

  late final String endereco;

  Client(
    this.age,
    this.name,
    this.endereco
  );

  //convert object MAP in Client
  Client.fromMap(Map<String, dynamic> map)
    : name = map["name"],
      age = map["age"];

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'age': age,
    };
  }

}