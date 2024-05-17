import 'package:coner_client/database/firebase/client_firebase.dart';
import 'package:coner_client/database/shared_preferences/my_shared_preferences.dart';
import 'package:coner_client/models/client.dart';
import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/cupertino.dart';

import '../utils/address_util.dart';

class ClientProvider with ChangeNotifier {
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

  Future<bool> add(
    String clientPhoneNumber,
    String clientName,
    String clientAddress,
    String clientDetailAddress,
  ) async {
    client = Client(
      clientId: '',
      clientPhoneNumber: clientPhoneNumber,
      clientName: clientName,
      clientAddress: clientAddress,
      clientDetailAddress: clientDetailAddress,
      clientSignUpDate: getToday(),
    );
    String cid = await ClientFirebase.add(client);
    if (cid != '') {
      client.clientId = cid;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void setCId(String cid) {
    client.clientId = cid;
    notifyListeners();
  }

  bool checkRegion() {
    return checkRegionRestriction(clientAddress);
  }

  Future<bool> update(
    String clientName,
    String clientAddress,
    String clientDetailAddress,
  ) async {
    bool isSuccess = await ClientFirebase.update(
        client.clientId, clientName, clientAddress, clientDetailAddress);
    if (isSuccess) {
      client.clientName = clientName;
      client.clientAddress = clientAddress;
      client.clientDetailAddress = clientDetailAddress;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePhone(String clientPhoneNumber) async {
    bool isSuccess = await ClientFirebase.updatePhone(client.clientId, clientPhoneNumber);
    if (isSuccess) {
      client.clientPhoneNumber = clientPhoneNumber;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getData(String cid) async {
    client = await ClientFirebase.getData(cid);
    if (client.clientId != '') {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(BuildContext context, String phone) async {
    client = await ClientFirebase.login(context, phone);
    if (client.clientId != '') {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future logout() async {
    client = Client(
      clientId: '',
      clientPhoneNumber: '',
      clientName: '',
      clientAddress: '',
      clientDetailAddress: '',
      clientSignUpDate: '',
    );
    await MySharedPreferences.clear();
    notifyListeners();
  }

  Future withdrawal() async {
    bool isSuccess = await ClientFirebase.delete(clientId);
    if (isSuccess) {
      client = Client(
        clientId: '',
        clientPhoneNumber: '',
        clientName: '',
        clientAddress: '',
        clientDetailAddress: '',
        clientSignUpDate: '',
      );
      await MySharedPreferences.clear();
      notifyListeners();
    }
  }
}
