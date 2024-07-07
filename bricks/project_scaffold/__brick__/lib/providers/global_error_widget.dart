import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rctv/rctv.dart';
import '../service_locator.dart';

import '../model/services/error_service.dart';

class GlobalErrorWidget extends StatelessWidget {

  final ErrorService _errorService = sl();
  final Widget child;

  GlobalErrorWidget({super.key, required this.child});

  SnackBar _buildSnackbar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.background)),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveListenerWidget(_errorService, listener: (error, _) {
      if (error == null) return;
      log(error);
      ScaffoldMessenger.of(context).showSnackBar( _buildSnackbar(context, error) );
    }, child: child);
  }
}

