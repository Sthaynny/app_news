import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/news/filter/screen/filter_view_model.dart';
import 'package:ufersa_hub/features/shared/components/category_tile.dart';
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.viewModel});
  final FilterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DSHeadlineLargeText(filterNewsString),
          DSSpacing.md.y,
          Align(
            alignment: Alignment.centerLeft,
            child: DSBodyText(categoriesString, fontWeight: FontWeight.bold),
          ),
          DSSpacing.md.y,
          ListenableBuilder(
            listenable: viewModel.filterNews,
            builder:
                (context, child) => Wrap(
                  runSpacing: DSSpacing.xs.value,
                  spacing: DSSpacing.xs.value,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children:
                      CategoryPost.values.map((category) {
                        return CategoryTile(
                          category: category,
                          onTap: () => viewModel.addCateroryFilter(category),
                          select: viewModel.filter.categories.contains(
                            category,
                          ),
                        );
                      }).toList(),
                ),
          ),
          DSSpacing.md.y,
          DSTertiaryButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            label: clearFilterString,
          ),

          DSSpacing.md.y,
          DSPrimaryButton(
            backgroundColor: DSColors.secundary,
            onPressed: () {
              Navigator.pop(context, viewModel.filter);
            },
            label: filterString,
            autoSize: false,
          ),
        ],
      ),
    );
  }
}
