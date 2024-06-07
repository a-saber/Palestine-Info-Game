import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/core_widget/toasts.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';

import '../../../../../core/core_widget/custom_text_field.dart';
import '../../../../../core/manager/app_states.dart';

class EmailView extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var queController = TextEditingController();
  var answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
        backgroundColor: ColorsManager.green,
        appBar: AppBar(
          backgroundColor: ColorsManager.buttonColor,
          title: Text(
            "أرسل فكرة لغز جديد",
            style: StyleManager.normal.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      label: 'اسمك',
                      controller: nameController,
                      type: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      label: 'بريدك الإلكتروني',
                      controller: emailController,
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: 'أكتب اللغز',
                    controller: queController,
                    type: TextInputType.text,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      label: 'جواب اللغز',
                      controller: answerController,
                      type: TextInputType.text),
                  const SizedBox(
                    height: 40,
                  ),
                  state is AddQuestionLoadingState
                      ? Center(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            color: ColorsManager.buttonColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ), //Offset
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              /* AppCubit.get(context).addQuestion(
                                name: nameController.text,
                                email: emailController.text,
                                question: queController.text,
                                answer: answerController.text);
                            */
                            },
                            child: Text(
                              'أرسل',
                              style: StyleManager.normal
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is AddQuestionSuccessState) {
        makeToast(
            msg: "Added Successfully\nWe will contact you soon",
            state: ToastStates.SUCCESS);
        Navigator.pop(context);
      }
      if (state is AddQuestionErrorState) {
        makeToast(
            msg: "Internet Connection Error", state: ToastStates.ERRORCONNECT);
      }
    });
  }
}
