
import 'package:marketing_admin_panel/utils/enums.dart';

abstract class UserEvents {}

class FetchAllUsers extends UserEvents {
  final String userType;
  FetchAllUsers(this.userType);
}

class FetchMoreUsers extends UserEvents {
  final String userType;
  final String lastFetchedDocument;
  FetchMoreUsers(this.userType, this.lastFetchedDocument);
}

class FilterUsers extends UserEvents {
  double minAge;
  double maxAge;
  String gender;
  List<String> countries;
  UserType userType;

  FilterUsers(this.minAge, this.maxAge, this.gender, this.countries, this.userType);
}

class DeleteUser extends UserEvents {
  String uId;
  String userType;

  DeleteUser(this.uId, this.userType);
}

class SearchUsers extends UserEvents {
  SearchType searchType;
  String searchText;
  String userType;

  SearchUsers(this.searchType, this.searchText, this.userType);
}

class GetUserPackageName extends UserEvents {
  String userId;

  GetUserPackageName(this.userId);
}