import 'package:crud_operation_dio/constants/app_constants.dart';
import 'package:crud_operation_dio/enum/choose_photo.dart';
import 'package:crud_operation_dio/widgets/bottom_sheet_item.dart';
import 'package:flutter/material.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({super.key, required this.onTap});
  final void Function(PhotoSelector photoselector, BuildContext ctx) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onTap(PhotoSelector.remove, context),
                    icon: const Icon(
                      Icons.delete_rounded,
                      size: 26,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () => onTap(PhotoSelector.close, context),
                    icon: const Icon(
                      Icons.cancel_sharp,
                      size: 26,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              FileSelectorItems(
                text: AppConstants.gallery,
                icons: Icons.photo,
                onTap: () => onTap(PhotoSelector.gallery, context),
              ),
              const SizedBox(height: 15),
              const Text(
                AppConstants.or,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              FileSelectorItems(
                text: AppConstants.camera,
                icons: Icons.camera_alt,
                onTap: () => onTap(PhotoSelector.camera, context),
              ),
            ]),
      ),
    );
  }
}
