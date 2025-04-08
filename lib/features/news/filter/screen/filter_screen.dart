import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/features/news/filter/screen/filter_view_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

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
          DSHeadlineLargeText('Filtrar Noticias!'),
          DSSpacing.md.y,
          Align(
            alignment: Alignment.centerLeft,
            child: DSBodyText('Categorias', fontWeight: FontWeight.bold),
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
                        final colorText =
                            viewModel.filter.categories.contains(category)
                                ? DSColors.neutralMediumWave
                                : DSColors.primary.shade600;
                        final Color colorBackground =
                            viewModel.filter.categories.contains(category)
                                ? DSColors.primary
                                : DSColors.transparent;

                        return DSChip(
                          background: colorBackground,
                          border: Border.all(color: colorText),
                          text: DSBodyText(
                            category.labelPtBr,
                            color: colorText,
                          ),
                          borderRadius: DSBorderRadius.all
                              .getCircularBorderRadius(maxRadius: 16),
                          onTap: () => viewModel.addCateroryFilter(category),
                        );
                      }).toList(),
                ),
          ),
          DSSpacing.md.y,
          DSTertiaryButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            label: 'Limpar Filtros',
          ),

          DSSpacing.md.y,
          DSPrimaryButton(
            backgroundColor: DSColors.secundary,
            onPressed: () {
              Navigator.pop(context, viewModel.filter);
            },
            label: 'Filtrar',
            autoSize: false,
          ),
        ],
      ),
    );
  }
}
