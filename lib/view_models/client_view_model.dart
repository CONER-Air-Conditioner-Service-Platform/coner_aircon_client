import '../models/client.dart';

class ClientViewModel {
  late Client client;

  String get clientId => client.clientId;
  String get clientPhoneNumber => client.clientPhoneNumber;
  String get clientName => client.clientName;
  String get streetAddress => client.streetAddress;
  String get detailedAddress => client.detailedAddress;
  String get registrationDate => client.registrationDate;
}
