import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/UI/packages_tab/widgets/package_info_item.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_bloc.dart';
import 'package:marketing_admin_panel/bloc/packages_bloc/packages_events.dart';
import 'package:marketing_admin_panel/models/package.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:provider/src/provider.dart';

class PackageItem extends StatefulWidget {
  final Package package;

  PackageItem({required this.package});

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool isEnabled = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  Map<String, dynamic> packageData = {};

  void updatePackage(String key, int value){
    packageData[key] = value;
  }

  @override
  void initState() {
    nameController.text = widget.package.packageName ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.package.packageName!,
        style: Constants.TEXT_STYLE4,
      ),
      iconColor: MyColors.secondaryColor,
      collapsedIconColor: MyColors.grey,
      childrenPadding: EdgeInsets.all(16),
      backgroundColor: MyColors.lightBlue.withOpacity(0.2),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              icon: isEnabled
                  ? Icon(
                      Icons.save_outlined,
                      color: MyColors.secondaryColor,
                    )
                  : SvgPicture.asset('assets/images/edit_profile.svg'),
              label: Text(
                isEnabled ? 'Save' : 'Edit',
                style: Constants.TEXT_STYLE9,
              ),
              onPressed: () {
                if(isEnabled){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    context.read<PackagesBloc>().add(UpdatePackage(Package.fromMap(packageData, widget.package.id!)));
                    setState(() {
                      isEnabled = false;
                    });
                  }
                }else
                  setState(() {
                    isEnabled = true;
                  });

              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/images/trash.svg'),
              onPressed: (){
                context.read<PackagesBloc>().add(DeletePackage(widget.package.id!));
              },
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.package.packageName != 'Free Package')
                PackageInfoItem(
                  packageInfoTitle: 'package name',
                  packageInfoValue: widget.package.packageName,
                  isEnabled: isEnabled,
                  width: 200.0,
                  onValidate: (userInput){

                    if(userInput == '')
                      return 'Please enter a name';

                    else return null;
                  },
                  onSaved: (userInput){
                    packageData['packageName'] = userInput;
                  },
                ),
              if (widget.package.packageName != 'Free Package')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PackageInfoItem(
                      packageInfoTitle: 'expires',
                      packageInfoValue: widget.package.expires,
                      isEnabled: isEnabled,
                      onSaved: (userInput){
                        updatePackage('expires', int.parse(userInput));
                      },
                    ),
                    PackageInfoItem(
                      packageInfoTitle: 'price',
                      packageInfoValue: widget.package.price,
                      isEnabled: isEnabled,
                      onSaved: (userInput){
                        updatePackage('price', int.parse(userInput));
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PackageInfoItem(
                    packageInfoTitle: 'products',
                    packageInfoValue: widget.package.products,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('products', int.parse(userInput));
                    },
                  ),
                  PackageInfoItem(
                    packageInfoTitle: 'posts',
                    packageInfoValue: widget.package.posts,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('posts', int.parse(userInput));
                    },
                  ),
                  PackageInfoItem(
                    packageInfoTitle: 'images',
                    packageInfoValue: widget.package.images,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('images', int.parse(userInput));
                    },
                  ),
                  PackageInfoItem(
                    packageInfoTitle: 'videos',
                    packageInfoValue: widget.package.videos,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('videos', int.parse(userInput));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PackageInfoItem(
                    packageInfoTitle: 'chat days',
                    packageInfoValue: widget.package.chatInDays,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('chatInDays', int.parse(userInput));
                    },
                  ),
                  PackageInfoItem(
                    packageInfoTitle: 'story days',
                    packageInfoValue: widget.package.storyInDays,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('storyInDays', int.parse(userInput));
                    },
                  ),
                  PackageInfoItem(
                    packageInfoTitle: 'story count',
                    packageInfoValue: widget.package.storyCount,
                    isEnabled: isEnabled,
                    onSaved: (userInput){
                      updatePackage('storyCount', int.parse(userInput));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
