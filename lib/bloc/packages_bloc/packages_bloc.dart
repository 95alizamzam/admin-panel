import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_events.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/package.dart';
import 'package:marketing_admin_panel/repositories/packages/packages_repository.dart';

class PackagesBloc extends Bloc<PackagesEvent, PackagesState> {
  List<Package> packages = [];
  late Map<String, double> currencies;
  PackagesBloc() : super(PackagesInitialState()) {
    on<PackagesEvent>((event, emit) async {

      if(event is GetPackages){
        emit(GetPackagesLoading());
        try{
          packages = await locator.get<PackagesRepository>().getAllPackages();
          emit(GetPackagesDone());
        }catch(e){
          print(e.toString());
          emit(GetPackagesFailed('Error, please try again'));
        }
      }

      else if(event is AddNewPackage){
        emit(AddNewPackageLoading());
        try{
          Package packageAdded = await locator.get<PackagesRepository>().addNewPackage(event.package);
          packages.add(packageAdded);
          emit(AddNewPackageDone());
        }catch(e){
          emit(AddNewPackageFailed('Error, please try again'));
        }
      }

      else if(event is DeletePackage){
        emit(DeletePackageLoading());
        try{
          await locator.get<PackagesRepository>().deletePackage(event.packageId);
          packages.removeWhere((package) => package.id == event.packageId);
          emit(DeletePackageDone());
        }catch(e){
          emit(DeletePackageFailed('Error, please try again'));
        }

      }

      else if(event is UpdatePackage){
        emit(UpdatePackageLoading());
        try{
          await locator.get<PackagesRepository>().updatePackage(event.package);

          packages[packages.indexWhere((package) => package.id == event.package.id)] = event.package;
          emit(UpdatePackageDone());
        }catch(e){
          emit(UpdatePackageFailed('Error, please try again'));
        }
      }
    });
  }
}
