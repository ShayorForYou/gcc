import 'package:flutter/material.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:gcc_portal/utils/widgets/button_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../utils/widgets/my_widgets.dart';
import '../../utils/widgets/textfield_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _userIdController = TextEditingController();
  bool visible = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _resetPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      context.loaderOverlay.show();
      Future.delayed(const Duration(seconds: 2), () {
        context.loaderOverlay.hide();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'পাসওয়ার্ড পুনরুদ্ধার', showBackButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: VectorGraphic(
                    loader: const AssetBytesLoader('assets/svg/security.svg'),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: CustomTextField(
                        title: '',
                        controller: _userIdController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ইউজার আইডি দিন';
                          }
                          return null;
                        },
                        decoration: textFieldDecoration.copyWith(
                          hintText: 'ইউজার আইডি দিন',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        title: 'পাসওয়ার্ড পুনরুদ্ধার',
                        onPressed: _resetPassword,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
