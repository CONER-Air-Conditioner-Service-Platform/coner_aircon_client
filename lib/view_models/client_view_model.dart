import 'package:flutter/cupertino.dart';

import '../models/client.dart';

class ClientViewModel with ChangeNotifier {
  Client client = Client(
    clientId: '',
    clientPhoneNumber: '',
    clientName: '',
    clientAddress: '',
    clientDetailAddress: '',
    clientSignUpDate: '',
  );

  String get clientId => client.clientId;
  String get clientPhoneNumber => client.clientPhoneNumber;
  String get clientName => client.clientName;
  String get clientAddress => client.clientAddress;
  String get clientDetailAddress => client.clientDetailAddress;
  String get clientSignUpDate => client.clientSignUpDate;
}
