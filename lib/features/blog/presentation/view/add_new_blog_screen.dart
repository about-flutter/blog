import 'dart:io';

import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/widgets/blog_edt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        // Use proper logging instead of print statements
        debugPrint('Image selected: ${image?.path}');
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin người dùng hiện tại để gán posterId
    final appUserCubit = BlocProvider.of<AppUserCubit>(context);
    final appUserState = appUserCubit.state;
    final userId = appUserState is AppUserLoggedIn ? appUserState.user.id : '';

    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Use Modular navigation to maintain consistent navigation
          Modular.to.pop();
        },
      ),
      actions: [
        BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUpLoadSuccess) {
            showSnackBar(context, 'Blog uploaded successfully!');
            // Use a single navigation method consistently
            Modular.to.navigate('/blog/');
          } else if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Loader(),
          );
          }
          return IconButton(
          onPressed: () {
            if (titleController.text.isEmpty ||
              contentController.text.isEmpty) {
            showSnackBar(context, 'Please fill all fields');
            return;
            }

            if (selectedTopics.isEmpty) {
            showSnackBar(context, 'Please select at least one topic');
            return;
            }

            BlocProvider.of<BlogBloc>(context).add(
            BlogUpload(
              image: image,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              posterId: userId,
              topics: selectedTopics,
            ),
            );
          },
          icon: const Icon(Icons.done_rounded),
          );
        },
        ),
      ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(image!),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppPalette.borderColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Select your image',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertaiment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {
                                    // Use proper logging instead of print statements
                                    debugPrint('Selected topics: $selectedTopics');
                                  });
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPalette.gradient1,
                                        )
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPalette.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(height: 10),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
