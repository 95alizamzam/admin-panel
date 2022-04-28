import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_text_form_field.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_bloc.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_events.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {
  final navigator;
  const LoginScreen({Key? key, this.navigator}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    icon: 'email',
                    width: screenWidth * 0.3,
                    hint: 'Email',
                    validateInput: (userInput) {
                      if (userInput == '')
                        return 'Email required';
                      else
                        return null;
                    },
                    saveInput: (userInput) {
                      email = userInput;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    icon: 'person',
                    width: screenWidth * 0.3,
                    hint: 'Password',
                    validateInput: (userInput) {
                      if (userInput == '')
                        return 'Password required';
                      else
                        return null;
                    },
                    saveInput: (userInput) {
                      password = userInput;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AdminBloc, AdminState>(
                builder: (context, state) {
                  if(state is AdminSignInLoading)
                    return CircularProgressIndicator(
                      color: MyColors.secondaryColor,
                    );
                  else
                    return CustomButton(
                      ontap: () {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          context.read<AdminBloc>().add(SignInAdmin(email, password));
                        }
                      },
                      buttonLabel: 'Log In',
                      padding: 12,
                      radius: 15,
                      color: MyColors.secondaryColor,
                      labelColor: MyColors.primaryColor,
                      labelSize: 20,
                      width: screenWidth * 0.3,
                    );
                },
                listener: (context, state) {
                  if(state is AdminSignInFailed)
                    EasyLoading.showError(state.message);
                  else if(state is AdminSignInSuccess)
                    NavigatorImpl().push(NamedRoutes.HOME_SCREEN);
                }),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ),
    );
  }
}
