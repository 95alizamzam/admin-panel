
import 'package:marketing_admin_panel/models/package.dart';

class PackagesEvent {}

class GetPackages  extends PackagesEvent {}

class AddNewPackage  extends PackagesEvent {
  Map<String, dynamic> package;

  AddNewPackage(this.package);
}

class DeletePackage extends PackagesEvent {
  String packageId;

  DeletePackage(this.packageId);
}

class UpdatePackage extends PackagesEvent {
  Package package;

  UpdatePackage(this.package);
}