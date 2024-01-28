import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/strings.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_app_bar.dart';
import 'package:e_commerce/data/reusable_widgets/zen_divider.dart';
import 'package:e_commerce/data/reusable_widgets/zen_image_error_builder.dart';
import 'package:e_commerce/data/reusable_widgets/zen_loader.dart';
import 'package:e_commerce/modules/product_details/blocs/product_details_bloc.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/utils/bloc/bloc_provider.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:e_commerce/utils/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProductDetailsView extends StatefulWidget {
  final FilterBloc filterBloc;
  final int? productId;
  final bool openEdit;

  const ProductDetailsView({
    super.key,
    required this.filterBloc,
    required this.productId,
    this.openEdit = false,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();

  late ProductDetailsBloc productDetailsBloc;

  setEditInitialValues(Product product) {
    titleEditingController.text = product.title;
    priceEditingController.text = product.price;
    descriptionEditingController.text = product.description;

    productDetailsBloc.onEditProductChanged(product);

    titleEditingController.addListener(() {
      productDetailsBloc.onEditTitleChanged(titleEditingController.text);
    });
    priceEditingController.addListener(() {
      productDetailsBloc.onEditPriceChanged(priceEditingController.text);
    });
    descriptionEditingController.addListener(() {
      productDetailsBloc
          .onEditDescriptionChanged(descriptionEditingController.text);
    });
  }

  openEditModal() {
    productDetailsBloc.onEditProductPressed(
      context,
      productDetailsBloc.product,
      setEditInitialValues,
      titleEditingController,
      priceEditingController,
      descriptionEditingController,
      widget.filterBloc.categories,
    );
  }

  @override
  void initState() {
    super.initState();
    productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    productDetailsBloc.getProduct(context, widget.productId,
        openEdit: widget.openEdit, openEditCallback: openEditModal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: productDetailsBloc.loadingStream,
        initialData: productDetailsBloc.loading,
        builder: (BuildContext context, AsyncSnapshot<bool> loadingSnapshot) {
          bool loading = loadingSnapshot.data ?? true;
          return loading
              ? const ZenLoader()
              : StreamBuilder<Product>(
                  stream: productDetailsBloc.productStream,
                  initialData: productDetailsBloc.product,
                  builder: (BuildContext context,
                      AsyncSnapshot<Product> productSnapshot) {
                    Product product = productSnapshot.data ?? Product();
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        headerSection(product),
                        productInfoSection(product),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }

  Widget headerSection(Product product) => Stack(
        alignment: Alignment.topCenter,
        children: [
          headerImage(product),
          ZenAppBar(
            leadingIcon: Assets.arrowBack,
            onLeadingPressed: () => Navigator.of(context).pop(),
            trailingIcon: Assets.edit,
            onTrailingPressed: openEditModal,
          ),
        ],
      );

  Widget headerImage(Product product) => Container(
        height: MediaQuery.of(context).size.height * 0.44,
        width: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                left: 85.5,
                right: 85.5,
                bottom: MediaQuery.of(context).size.height * 0.085),
            child: Image.network(
              product.image,
              loadingBuilder: (context, widget, event) {
                if (event?.expectedTotalBytes != event?.cumulativeBytesLoaded) {
                  return const ZenLoader(padding: 15.0);
                } else {
                  return widget;
                }
              },
              errorBuilder: (context, object, trace) {
                return const ZenImageErrorBuilder(size: 75.0);
              },
            ),
          ),
        ),
      );

  Widget productInfoSection(Product product) => SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.35),
            Expanded(
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorConstants.lightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModalService.modalTitle(product.title),
                        const SizedBox(height: 16.0),
                        productPrice(product),
                        const SizedBox(height: 32.0),
                        const ZenDivider(),
                        const SizedBox(height: 32.0),
                        productCategoryAndRatingSection(product),
                        const SizedBox(height: 32.0),
                        productSectionTitleAndLabel(
                            Strings.description, product.description),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget productPrice(Product product) => Text(
        '${Strings.dollarSign}${product.price}',
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
          color: ColorConstants.baseBlack,
          letterSpacing: -0.64,
        ),
      );

  Widget productCategoryAndRatingSection(Product product) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                productSectionTitleAndLabel(Strings.category, product.category),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productInfoSectionTitle(Strings.rating),
                const SizedBox(height: 8.0),
                productRatingSection(product),
              ],
            ),
          ),
        ],
      );

  Widget productSectionTitleAndLabel(String title, String label) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productInfoSectionTitle(title),
          const SizedBox(height: 8.0),
          productInfoSectionLabel(label),
        ],
      );

  Widget productInfoSectionTitle(String title) => Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: ColorConstants.baseBlack,
          letterSpacing: 1.4,
        ),
      );

  Widget productInfoSectionLabel(String label) => Text(
        label.capitalize(),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: ColorConstants.main,
          letterSpacing: -0.32,
        ),
      );

  Widget productRatingSection(Product product) => Row(
        children: [
          SizedBox(
            height: 16.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return productRatingStar(product, index + 1);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4.0);
              },
              itemCount: 5,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            product.rating.count.toString().bracket(),
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: ColorConstants.main,
              letterSpacing: -0.2,
            ),
          ),
        ],
      );

  Widget productRatingStar(Product product, int index) => SvgPicture.asset(
        Assets.star,
        width: 16.0,
        height: 16.0,
        colorFilter: ColorFilter.mode(
          index <= product.rating.rate.round()
              ? ColorConstants.main
              : ColorConstants.baseBlack,
          BlendMode.srcIn,
        ),
      );
}
