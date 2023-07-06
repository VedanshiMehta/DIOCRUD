import 'dart:io';

import 'package:crud_operation_dio/Utils/image_picker.dart';
import 'package:crud_operation_dio/Utils/show_snackbar.dart';
import 'package:crud_operation_dio/Utils/validator.dart';
import 'package:crud_operation_dio/constants/app_constants.dart';
import 'package:crud_operation_dio/enum/choose_photo.dart';
import 'package:crud_operation_dio/models/user.dart';
import 'package:crud_operation_dio/providers/user_provider.dart';
import 'package:crud_operation_dio/widgets/bottom_sheet.dart';
import 'package:crud_operation_dio/widgets/cupertino_button.dart';
import 'package:crud_operation_dio/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUser extends ConsumerStatefulWidget {
  const UpdateUser({
    super.key,
  });
  @override
  ConsumerState<UpdateUser> createState() {
    return _UpdateUserState();
  }
}

class _UpdateUserState extends ConsumerState<UpdateUser> {
  final _fromKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  var _isLoading = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late bool _isUpdated;
  late Datum _user;
  String? imageUrl;
  File? imageFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = ref.watch(userProvider).userDetails!;

    _isUpdated = ref.watch(userProvider).isUpdated;
    if (_isUpdated) {
      _firstNameController.text = _user.firstName;
      _lastNameController.text = _user.lastName;
      _emailController.text = _user.email;
      imageUrl = _user.avatar;
    }
  }

  void _onSubmitted(BuildContext context, int id) {
    bool isFormValid = _fromKey.currentState!.validate();
    setState(() {
      _isLoading = true;
    });
    if (isFormValid) {
      Future.delayed(const Duration(seconds: 3), () async {
        if (_isUpdated) {
          var result = await ref.read(userProvider).updateUser(id);
          if (result.isValid) {
            setState(() {
              _isLoading = false;
            });
            if (context.mounted) {
              Utils.showMessage(context, result.message);
              Navigator.pop(context);
            }
          }
        } else {
          var result = await ref.read(userProvider).addUser();
          if (result.isValid) {
            setState(() {
              _isLoading = false;
            });
            if (context.mounted) {
              Utils.showMessage(context, result.message);
              Navigator.pop(context);
            }
          }
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void selectImage(PhotoSelector photoSelector, BuildContext context) async {
    switch (photoSelector) {
      case PhotoSelector.gallery:
        var image = await ImagePickerWidget.pickImage(ImageSource.gallery);
        setState(() {
          imageFile = image;
        });

        break;
      case PhotoSelector.camera:
        var image = await ImagePickerWidget.pickImage(ImageSource.camera);
        setState(() {
          imageFile = image;
        });
        break;
      case PhotoSelector.remove:
        setState(() {
          imageFile = null;
          imageUrl = null;
        });

        break;
      case PhotoSelector.close:
        break;
    }
    if (context.mounted) Navigator.pop(context);
  }

  void _onTapImage() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxHeight: 300),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (ctx) => FileSelector(
        onTap: (photoselector, ctx) => selectImage(photoselector, ctx),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isUpdated ? AppConstants.update : AppConstants.add,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButtonWidget(onTap: _onTapImage, child: _addImage()),
                const SizedBox(height: 20),
                _buildFirstNameTextField(context),
                const SizedBox(height: 20),
                _buildLastNameTextField(context),
                const SizedBox(height: 20),
                _buildEmailTextField(context, _user.id),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: _isLoading
                              ? () {}
                              : () => _onSubmitted(context, _user.id),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          child: _isLoading
                              ? const LoaderWidget()
                              : _isUpdated
                                  ? const Text(AppConstants.update)
                                  : const Text(AppConstants.add)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty && imageFile == null) {
      return Container(
        width: 100, // Adjust the width as needed
        height: 100, // Adjust the height as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(_user.avatar),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (imageFile != null) {
      return Container(
        width: 100, // Adjust the width as needed
        height: 100, // Adjust the height as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(imageFile!),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        width: 100, // Adjust the width as needed
        height: 100, // Adjust the height as needed
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 61, 61, 61),
        ),
        child: const Center(
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 50,
          ),
        ),
      );
    }
  }

  Widget _buildFirstNameTextField(BuildContext context) {
    return TextFormField(
      controller: _firstNameController,
      autocorrect: false,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: _firstNameFocusNode,
      decoration: const InputDecoration(
        label: Text(AppConstants.labelfirstName),
        hintText: AppConstants.hintTextFirstName,
        border: OutlineInputBorder(),
      ),
      validator: Validator.validateFirstName,
      onFieldSubmitted: (value) {
        _firstNameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      },
    );
  }

  Widget _buildLastNameTextField(BuildContext context) {
    return TextFormField(
      controller: _lastNameController,
      autocorrect: false,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: _lastNameFocusNode,
      decoration: const InputDecoration(
        label: Text(AppConstants.labelLastName),
        hintText: AppConstants.hintTextLastName,
        border: OutlineInputBorder(),
      ),
      validator: Validator.validateLastName,
      onFieldSubmitted: (value) {
        _lastNameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }

  Widget _buildEmailTextField(BuildContext context, int userId) {
    return TextFormField(
      controller: _emailController,
      autocorrect: false,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      focusNode: _emailFocusNode,
      decoration: const InputDecoration(
        label: Text(AppConstants.labelEmail),
        hintText: AppConstants.hintTextEmail,
        border: OutlineInputBorder(),
      ),
      validator: Validator.validateEmail,
      onFieldSubmitted: (value) {
        _firstNameFocusNode.unfocus();
        _onSubmitted(context, userId);
      },
    );
  }
}
