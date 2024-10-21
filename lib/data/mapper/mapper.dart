import 'package:flutter_application_1/app/extensions.dart';
import 'package:flutter_application_1/data/responses/responses.dart';
import 'package:flutter_application_1/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse {
  Customer toDomain() {
    return Customer(id?.orEmpty() ?? EMPTY, name?.orEmpty() ?? EMPTY,
        numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse {
  Contacts toDomain() {
    return Contacts(email?.orEmpty() ?? EMPTY, phone?.orEmpty() ?? EMPTY, link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(customer?.toDomain(), contacts?.toDomain());
  }
}
