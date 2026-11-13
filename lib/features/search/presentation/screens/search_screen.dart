import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/search_cubit.dart';
import '../widgets/search_header.dart';
import '../widgets/search_results.dart';
import '../widgets/categories_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..requestFocus();

    // Forward every text change into the cubit with debounce.
    _controller.addListener(
      () => context.read<SearchCubit>().onQueryChanged(_controller.text),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            spacing: 16.h,
            children: [
              SearchHeader(
                controller: _controller,
                focusNode: _focusNode,
              ),
              CategoriesBar(
                onCategoryChanged: (category) => context.read<SearchCubit>().onCategoryChanged(category),
              ),
              const Expanded(child: SearchResults()),
            ],
          ),
        ),
      ),
    );
  }
}
