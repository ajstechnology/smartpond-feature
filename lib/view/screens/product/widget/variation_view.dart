import 'package:flutter/material.dart';
import 'package:smartpond/data/model/response/product_model.dart';
import 'package:smartpond/provider/product_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:provider/provider.dart';

class VariationView extends StatelessWidget {
  final Product product;
  VariationView({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: product.choiceOptions.length,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.choiceOptions[index].title,
                      style: poppinsMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: (1 / 0.25),
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: product.choiceOptions[index].options.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          productProvider.setCartVariationIndex(index, i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            color: productProvider.variationIndex[index] != i
                                ? ColorResources.getBackgroundColor(context)
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: productProvider.variationIndex[index] != i
                                ? Border.all(
                                    color: ColorResources.getGreyColor(context),
                                    width: 2)
                                : null,
                          ),
                          child: Text(
                            product.choiceOptions[index].options[i].trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: poppinsRegular.copyWith(
                              color: productProvider.variationIndex[index] != i
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                      height: index != product.choiceOptions.length - 1
                          ? Dimensions.PADDING_SIZE_LARGE
                          : 0),
                ]);
          },
        );
      },
    );
  }
}
