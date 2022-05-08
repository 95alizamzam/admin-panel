
class PackagesState {}

class PackagesInitialState extends PackagesState {}

class GetPackagesLoading extends PackagesState {}

class GetPackagesDone extends PackagesState {}

class GetPackagesFailed extends PackagesState {
  String message;

  GetPackagesFailed(this.message);
}

class AddNewPackageLoading extends PackagesState {}

class AddNewPackageDone extends PackagesState {}

class AddNewPackageFailed extends PackagesState {
  String message;

  AddNewPackageFailed(this.message);
}

class DeletePackageLoading extends PackagesState {}

class DeletePackageDone extends PackagesState {}

class DeletePackageFailed extends PackagesState {
  String message;

  DeletePackageFailed(this.message);
}

class UpdatePackageLoading extends PackagesState {}

class UpdatePackageDone extends PackagesState {}

class UpdatePackageFailed extends PackagesState {
  String message;

  UpdatePackageFailed(this.message);
}