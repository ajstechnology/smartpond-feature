import 'package:flutter/material.dart';
import 'package:smartpond/data/model/response/order_details_model.dart';
import 'package:smartpond/data/model/response/order_model.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/order_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:smartpond/view/base/custom_app_bar.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/screens/review/widget/deliver_man_review_widget.dart';
import 'package:smartpond/view/screens/review/widget/product_review_widget.dart';
import 'package:provider/provider.dart';

class RateReviewScreen extends StatefulWidget {
  final List<OrderDetailsModel> orderDetailsList;
  final DeliveryMan deliveryMan;
  RateReviewScreen(
      {@required this.orderDetailsList, @required this.deliveryMan});

  @override
  _RateReviewScreenState createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends State<RateReviewScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.deliveryMan == null ? 1 : 2,
        initialIndex: 0,
        vsync: this);
    Provider.of<OrderProvider>(context, listen: false)
        .initRatingData(widget.orderDetailsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? MainAppBar()
          : CustomAppBar(title: getTranslated('rate_review', context)),
      body: Center(
        child: Container(
          width: 1170,
          child: Column(children: [
            Container(
              color: Theme.of(context).cardColor,
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).textTheme.bodyText1.color,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                unselectedLabelStyle: poppinsRegular.copyWith(
                    color: ColorResources.getHintColor(context),
                    fontSize: Dimensions.FONT_SIZE_SMALL),
                labelStyle: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL),
                tabs: widget.deliveryMan != null
                    ? [
                        Tab(
                            text: getTranslated(
                                widget.orderDetailsList.length > 1
                                    ? 'items'
                                    : 'item',
                                context)),
                        Tab(text: getTranslated('delivery_man', context)),
                      ]
                    : [
                        Tab(
                            text: getTranslated(
                                widget.orderDetailsList.length > 1
                                    ? 'items'
                                    : 'item',
                                context)),
                      ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: widget.deliveryMan != null
                  ? [
                      ProductReviewWidget(
                          orderDetailsList: widget.orderDetailsList),
                      DeliveryManReviewWidget(
                          deliveryMan: widget.deliveryMan,
                          orderID:
                              widget.orderDetailsList[0].orderId.toString()),
                    ]
                  : [
                      ProductReviewWidget(
                          orderDetailsList: widget.orderDetailsList),
                    ],
            )),
          ]),
        ),
      ),
    );
  }
}
