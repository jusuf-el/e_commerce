import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/constants/strings.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/data/reusable_widgets/zen_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_divider.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:e_commerce/utils/services/modal_service.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatelessWidget {
  final FilterBloc filterBloc;
  final ProductsBloc productsBloc;

  const FilterModal({
    super.key,
    required this.filterBloc,
    required this.productsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, left: 16.0, bottom: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModalService.modalDragHandle(),
          const SizedBox(height: 24.0),
          ModalService.modalTitle(Strings.filter),
          const SizedBox(height: 16.0),
          const ZenDivider(),
          const SizedBox(height: 24.0),
          filterSectionTitle(Strings.category),
          const SizedBox(height: 8.0),
          filterCategoriesSectionOptions,
          const SizedBox(height: 16.0),
          filterSectionTitle(Strings.sortByPrice),
          const SizedBox(height: 8.0),
          filterPriceSortSectionOptions,
          const SizedBox(height: 16.0),
          filterSectionTitle(Strings.numberOfResults),
          const SizedBox(height: 8.0),
          filterResultsLimitSectionOptions,
          const SizedBox(height: 32.0),
          const ZenDivider(),
          const SizedBox(height: 24.0),
          PrimaryButton(
            text: Strings.applyFilter,
            onPressed: () =>
                filterBloc.onApplyFilterPressed(context, productsBloc),
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            text: Strings.cancel,
            filled: false,
            onPressed: () =>
                filterBloc.onCancelFilterPressed(context, productsBloc),
          ),
        ],
      ),
    );
  }

  Widget filterSectionTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: ColorConstants.dark,
          letterSpacing: -0.34,
        ),
      );

  Widget get filterCategoriesSectionOptions => StreamBuilder<List<String>>(
        stream: filterBloc.categoriesStream,
        initialData: filterBloc.categories,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          List<String> categories = snapshot.data ?? [];
          return StreamBuilder<String>(
            stream: filterBloc.filterCategoryStream,
            initialData: filterBloc.filterCategory,
            builder: (BuildContext context,
                AsyncSnapshot<String> filterCategorySnapshot) {
              String selectedCategory = filterCategorySnapshot.data ?? '';
              return filterSectionOptionsList(
                categories,
                (String category) =>
                    filterBloc.onFilterCategoryChanged(category),
                selectedCategory,
              );
            },
          );
        },
      );

  Widget get filterPriceSortSectionOptions => StreamBuilder<Sort>(
        stream: filterBloc.filterSortStream,
        initialData: filterBloc.filterSort,
        builder:
            (BuildContext context, AsyncSnapshot<Sort> filterSortSnapshot) {
          Sort selectedSort = filterSortSnapshot.data ?? Sort();
          return filterSectionOptionsList(
            FilterConstants.priceSorting.map((e) => e.title).toList(),
            (String sort) => filterBloc.onFilterSortChanged(FilterConstants
                .priceSorting
                .firstWhere((e) => e.title == sort)),
            selectedSort.title,
          );
        },
      );

  Widget get filterResultsLimitSectionOptions => StreamBuilder<int>(
        stream: filterBloc.filterLimitStream,
        initialData: filterBloc.filterLimit,
        builder:
            (BuildContext context, AsyncSnapshot<int> filterLimitSnapshot) {
          int selectedLimit = filterLimitSnapshot.data ?? 10;
          return filterSectionOptionsList(
            FilterConstants.resultNumbers.map((e) => e.toString()).toList(),
            (String limit) => filterBloc.onFilterLimitChanged(int.parse(limit)),
            selectedLimit.toString(),
          );
        },
      );

  Widget filterSectionOptionsList(List<String> options,
          Function(String) onOptionPressed, String selectedOption) =>
      Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runSpacing: 8.0,
        children: List.generate(
          options.length,
          (index) {
            return filterOptionBadge((option) => onOptionPressed(option),
                options[index], selectedOption);
          },
        ),
      );

  Widget filterOptionBadge(Function(String) onOptionPressed, String option,
          String selectedOption) =>
      InkWell(
        onTap: () => onOptionPressed(option),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: ColorConstants.light,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: selectedOption == option
                ? Border.all(
                    color: ColorConstants.third,
                    width: 1.0,
                    strokeAlign: BorderSide.strokeAlignInside,
                  )
                : const Border.fromBorderSide(BorderSide.none),
          ),
          child: Text(
            option.capitalize(),
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: ColorConstants.dark,
              letterSpacing: -0.26,
            ),
          ),
        ),
      );
}
