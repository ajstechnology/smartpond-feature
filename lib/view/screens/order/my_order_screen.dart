import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/order_provider.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/view/base/app_bar_base.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/base/not_login_screen.dart';
import 'package:smartpond/view/screens/order/widget/order_button.dart';
import 'package:smartpond/view/screens/order/widget/order_view.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<OrderProvider>(context, listen: false).getOrderList(context);
    }
    return Scaffold(
      appBar: ResponsiveHelper.isMobilePhone()
          ? null
          : ResponsiveHelper.isDesktop(context)
              ? MainAppBar()
              : AppBarBase(),
      body: SafeArea(
        child: _isLoggedIn
            ? Scrollbar(
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) =>
                          orderProvider.runningOrderList != null
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OrderButton(
                                                title: getTranslated(
                                                    'active', context),
                                                isActive: true),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            OrderButton(
                                                title: getTranslated(
                                                    'past_order', context),
                                                isActive: false),
                                          ]),
                                    ),
                                    Expanded(
                                        child: OrderView(
                                            isRunning:
                                                orderProvider.isActiveOrder
                                                    ? true
                                                    : false))
                                  ],
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor))),
                    ),
                  ),
                ),
              )
            : NotLoggedInScreen(),
      ),
    );
  }
}
