import 'package:flutter/cupertino.dart';

import '../models/client.dart';

class ClientViewModel with ChangeNotifier {
  Client client = Client(
    clientId: '',
    clientPhoneNumber: '',
    clientName: '',
    streetAddress: '',
    detailedAddress: '',
    registrationDate: '',
  );

  String get clientId => client.clientId;
  String get clientPhoneNumber => client.clientPhoneNumber;
  String get clientName => client.clientName;
  String get streetAddress => client.streetAddress;
  String get detailedAddress => client.detailedAddress;
  String get registrationDate => client.registrationDate;
}
