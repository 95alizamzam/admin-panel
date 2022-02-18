import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/left_part.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/middle_part.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';

class HomeScreen extends StatefulWidget {
  final navigator;
  const HomeScreen({
    Key? key,
    required this.navigator,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            const LeftPart(),
            MiddlePart(),
          ],
        ),
      ),
    );
  }
}
