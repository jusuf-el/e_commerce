import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/strings.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_circular_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_input_field.dart';
import 'package:e_commerce/data/reusable_widgets/zen_app_bar.dart';
import 'package:e_commerce/data/reusable_widgets/zen_loader.dart';
import 'package:e_commerce/data/reusable_widgets/zen_tab_bar.dart';
import 'package:e_commerce/modules/product_details/blocs/product_details_bloc.dart';
import 'package:e_commerce/modules/product_details/view/product_details_view.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/modules/products/widgets/product_card.dart';
import 'package:e_commerce/utils/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController searchInputController = TextEditingController();

  late FilterBloc filterBloc;
  late ProductsBloc productsBloc;

  onProductPressed(Product product, {bool openEdit = false}) {
    if (openEdit) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
          bloc: ProductDetailsBloc(),
          child: ProductDetailsView(
            filterBloc: filterBloc,
            productId: product.id,
            openEdit: openEdit,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    filterBloc = BlocProvider.of<FilterBloc>(context);
    productsBloc = BlocProvider.of<ProductsBloc>(context);

    filterBloc.getCategories(context, productsBloc);

    searchInputController.addListener(() {
      productsBloc.onSearchChanged(searchInputController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: filterBloc.loadingStream,
        initialData: filterBloc.loading,
        builder: (BuildContext context,
            AsyncSnapshot<bool> categoriesLoadingSnapshot) {
          bool categoriesLoading = categoriesLoadingSnapshot.data ?? true;
          return Column(
            children: [
              const ZenAppBar(
                  leadingIcon: Assets.arrowBack, title: Strings.products),
              searchAndFilterSection,
              categoryFilterSection(categoriesLoading),
              productsSection,
            ],
          );
        },
      ),
    );
  }

  Widget get searchAndFilterSection => Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InputField(
                hintText: Strings.search,
                textEditingController: searchInputController,
                prefixIcon: SvgPicture.asset(
                  Assets.search,
                  height: 24.0,
                  width: 24.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(width: 11.0),
            ZenCircularButton(
              onTap: () => productsBloc.onFilterPressed(context, filterBloc),
              icon: Assets.filter,
            ),
          ],
        ),
      );

  Widget categoryFilterSection(bool categoriesLoading) => Visibility(
        visible: !categoriesLoading,
        child: StreamBuilder<List<String>>(
          stream: filterBloc.categoriesStream,
          initialData: filterBloc.categories,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            List<String> categories = snapshot.data ?? [];
            return StreamBuilder<String>(
              stream: productsBloc.selectedCategoryStream,
              initialData: productsBloc.selectedCategory,
              builder: (BuildContext context,
                  AsyncSnapshot<String> selectedCategorySnapshot) {
                String selectedCategory = selectedCategorySnapshot.data ?? '';
                return ZenTabBar(
                  tabs: categories,
                  selectedTab: selectedCategory,
                  onTabPressed: (category) => productsBloc.onCategoryChanged(
                      context, category, filterBloc),
                );
              },
            );
          },
        ),
      );

  Widget get productsSection => Expanded(
        child: StreamBuilder<bool>(
          stream: productsBloc.loadingStream,
          initialData: productsBloc.loading,
          builder: (BuildContext context, AsyncSnapshot<bool> loadingSnapshot) {
            bool loading = loadingSnapshot.data ?? true;
            return loading ? const ZenLoader() : productsList;
          },
        ),
      );

  Widget get productsList => StreamBuilder<List<Product>>(
        stream: productsBloc.productsStream,
        initialData: productsBloc.products,
        builder: (BuildContext context,
            AsyncSnapshot<List<Product>> productsSnapshot) {
          List<Product> products = productsSnapshot.data ?? [];
          return StreamBuilder<String>(
            stream: productsBloc.searchStream,
            initialData: productsBloc.search,
            builder:
                (BuildContext context, AsyncSnapshot<String> searchSnapshot) {
              String search = searchSnapshot.data ?? '';
              List<Product> filteredProducts = products
                  .where((e) =>
                      e.title.toLowerCase().contains(search.toLowerCase()))
                  .toList();
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 19.0,
                  horizontal: 16.0,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    onProductPressed: () =>
                        onProductPressed(filteredProducts[index]),
                    product: filteredProducts[index],
                    onMorePressed: () => productsBloc.onProductMorePressed(
                      context,
                      filteredProducts[index],
                      () => onProductPressed(filteredProducts[index],
                          openEdit: true),
                      () => productsBloc.onDeleteProductPressed(
                          context, filteredProducts[index].id),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemCount: filteredProducts.length,
              );
            },
          );
        },
      );
}
