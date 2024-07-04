import 'package:flutter/material.dart';
import '../base_page.dart';
import '{{pageName.snakeCase()}}_viewmodel.dart';

class {{pageName.pascalCase()}}Page extends StatelessWidget {

  const {{pageName.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      viewModel: () => {{pageName.pascalCase()}}ViewModel(),
      buildPage: (context, viewModel) => const Placeholder()
    );
  }
}