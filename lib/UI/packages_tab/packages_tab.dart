import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/packages_tab/widgets/package_item.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_bloc.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_events.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_states.dart';
import 'package:marketing_admin_panel/models/package.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
import 'package:provider/src/provider.dart';

class PackagesTab extends StatefulWidget {
  @override
  _PackagesTabState createState() => _PackagesTabState();
}

class _PackagesTabState extends State<PackagesTab> {
  @override
  void initState() {
    context.read<PackagesBloc>().add(GetPackages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackagesBloc, PackagesState>(
      listener: (ctx, state) {
        if(state is UpdatePackageLoading || state is AddNewPackageLoading || state is DeletePackageLoading)
          EasyLoading.show(status: 'Please wait');
        else if(state is UpdatePackageFailed){
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.message);
        }
        else if(state is AddNewPackageFailed){
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.message);
        }
        else if(state is DeletePackageFailed){
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.message);
        }
        else if(state is UpdatePackageDone || state is AddNewPackageDone || state is DeletePackageDone){
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Done');
        }
      },
      builder: (ctx, state) {
        if (state is GetPackagesLoading)
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.secondaryColor,
            ),
          );
        else if (state is GetPackagesFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else {
          List<Package> packages = context.read<PackagesBloc>().packages;
          if (packages.isEmpty)
            return Center(
              child: Text(
                'No packages',
                style: Constants.TEXT_STYLE4,
              ),
            );
          else
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Available Packages',
                        style: Constants.TEXT_STYLE2.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => ModalSheets().showAddPackageSheet(context),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.secondaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                              Text(
                                'Add New Package',
                                style: Constants.TEXT_STYLE4
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(child: ListView.separated(
                    itemCount: packages.length,
                    separatorBuilder: (ctx, index) => const SizedBox(height: 8,),
                    itemBuilder: (ctx, index) => PackageItem(package: packages[index],),
                  ),),
                ],
              ),
            );
        }
      },
    );
  }
}
