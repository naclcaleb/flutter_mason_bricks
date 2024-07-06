import 'package:flutter/material.dart';
{{#includeAppBar}}import '../../components/basic/product_app_bar.dart';{{/includeAppBar}}
import '../base_page.dart';
import '{{pageName.snakeCase()}}_viewmodel.dart';

class {{pageName.pascalCase()}}Page extends StatelessWidget {

  const {{pageName.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      viewModel: () => {{pageName.pascalCase()}}ViewModel(),
      buildPage: (context, viewModel) => Scaffold(
        {{#includeAppBar}}appBar: ProductAppBar(title: '{{pageName.pascalCase()}}'),{{/includeAppBar}}
        body: const Placeholder()
      )
    );
  }
}