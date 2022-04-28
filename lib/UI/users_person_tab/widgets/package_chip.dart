import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:provider/src/provider.dart';

class PackageChip extends StatefulWidget {
  final String userId;

  PackageChip({required this.userId});

  @override
  _PackageChipState createState() => _PackageChipState();
}

class _PackageChipState extends State<PackageChip> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserPackageName(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(
      builder: (ctx, state) {
        if (state is GetUserPackageNameDone)
          return Chip(
            padding: const EdgeInsets.all(12),
            label: Text(
              state.packageName,
              style: Constants.TEXT_STYLE9,
            ),
          );
        else
          return Container();
      },
    );
  }
}
