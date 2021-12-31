import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smartpond/helper/product_type.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/helper/route_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/banner_provider.dart';
import 'package:smartpond/provider/category_provider.dart';
import 'package:smartpond/provider/localization_provider.dart';
import 'package:smartpond/provider/product_provider.dart';
import 'package:smartpond/provider/profile_provider.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/provider/theme_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/images.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/base/title_widget.dart';
import 'package:smartpond/view/screens/cart/cart_screen.dart';
import 'package:smartpond/view/screens/chat/chat_screen.dart';
import 'package:smartpond/view/screens/home/comming_soon.dart';
import 'package:smartpond/view/screens/home/widget/banners_view.dart';
import 'package:smartpond/view/screens/home/widget/category_view.dart';
import 'package:smartpond/view/screens/home/widget/daily_item_view.dart';
import 'package:smartpond/view/screens/home/widget/product_view.dart';
import 'package:smartpond/view/screens/menu/menu_screen.dart';
import 'package:smartpond/view/screens/menu/widget/custom_drawer.dart';
import 'package:smartpond/view/screens/menu/widget/menu_button.dart';
import 'package:smartpond/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:smartpond/view/screens/notification/notification_screen.dart';
import 'package:smartpond/view/screens/order/my_order_screen.dart';
import 'package:smartpond/view/screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  RxInt pageIndex = 0.obs;

  Future<void> _loadData(BuildContext context, bool reload) async {
    // await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(context, reload);

    await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(context, reload);
    await Provider.of<ProductProvider>(context, listen: false).getDailyItemList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    // await Provider.of<ProductProvider>(context, listen: false).getPopularProductList(context, '1', true);
    Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
      context,
      '1',
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _loadData(context, false);

    final bool _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    final CustomDrawerController drawerController = CustomDrawerController();

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Consumer<SplashProvider>(
        builder: (context, splash, child) => Scaffold(
          appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
          body: Obx(
            () => IndexedStack(
              index: pageIndex.value,
              children: [
                Scrollbar(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Center(
                      child: SizedBox(
                        width: 1170,
                        child: Column(
                            // controller: _scrollController,
                            children: [
                              Consumer<BannerProvider>(
                                  builder: (context, banner, child) {
                                return banner.bannerList == null
                                    ? BannersView()
                                    : banner.bannerList.length == 0
                                        ? SizedBox()
                                        : BannersView();
                              }),

                              // Category
                              Consumer<CategoryProvider>(
                                  builder: (context, category, child) {
                                return category.categoryList == null
                                    ? CategoryView()
                                    : category.categoryList.length == 0
                                        ? SizedBox()
                                        : CategoryView();
                              }),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child:
                                        TitleWidget(title: "Market Indicies"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                CommingSoon("Market Indicies"),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/image/banner1.jpeg"),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: TitleWidget(title: "Sale Enqury"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CommingSoon(
                                                    "Sale Enqury")));
                                      },
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/image/banner2.jpeg"),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Category
                              Consumer<ProductProvider>(
                                  builder: (context, product, child) {
                                return product.dailyItemList == null
                                    ? DailyItemView()
                                    : product.dailyItemList.length == 0
                                        ? SizedBox()
                                        : DailyItemView();
                              }),

                              // Popular Item
                              Padding(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                child: TitleWidget(
                                    title:
                                        getTranslated('popular_item', context)),
                              ),
                              ProductView(
                                  productType: ProductType.POPULAR_PRODUCT,
                                  scrollController: _scrollController),
                            ]),
                      ),
                    ),
                  ),
                ),
                CartScreen(),
                MyOrderScreen(),
                ChatScreen(),
                // MenuScreen(),
                Scaffold(
                  backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
                      ? ColorResources.getBackgroundColor(context)
                      : ResponsiveHelper.isDesktop(context)
                          ? ColorResources.getBackgroundColor(context)
                          : Theme.of(context).primaryColor,
                  // appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
                  body: SafeArea(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Container(
                            width: 1170,
                            child: Consumer<SplashProvider>(
                              builder: (context, splash, child) {
                                return Column(children: [
                                  /*!ResponsiveHelper.isDesktop(context)
                                      ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(Icons.close,
                                          color: Provider.of<ThemeProvider>(context)
                                              .darkTheme
                                              ? ColorResources.getTextColor(context)
                                              : ResponsiveHelper.isDesktop(context)
                                              ? ColorResources
                                              .getBackgroundColor(context)
                                              : ColorResources
                                              .getBackgroundColor(context)),
                                      onPressed: () => drawerController.toggle(),
                                    ),
                                  )
                                      : SizedBox(),*/
                                  SizedBox(height: 10),
                                  Consumer<ProfileProvider>(
                                    builder:
                                        (context, profileProvider, child) =>
                                            Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  RouteHelper.profile,
                                                  arguments: ProfileScreen());
                                            },
                                            leading: ClipOval(
                                              child: _isLoggedIn
                                                  ? FadeInImage.assetNetwork(
                                                      placeholder:
                                                          Images.placeholder,
                                                      image:
                                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/'
                                                          '${profileProvider.userInfoModel != null ? profileProvider.userInfoModel.image : ''}',
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                      imageErrorBuilder: (c, o,
                                                              s) =>
                                                          Image.asset(
                                                              Images
                                                                  .placeholder,
                                                              height: 50,
                                                              width: 50,
                                                              fit:
                                                                  BoxFit.cover),
                                                    )
                                                  : Image.asset(
                                                      Images.placeholder,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover),
                                            ),
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _isLoggedIn
                                                      ? profileProvider
                                                                  .userInfoModel !=
                                                              null
                                                          ? Text(
                                                              '${profileProvider.userInfoModel.fName ?? ''} ${profileProvider.userInfoModel.lName ?? ''}',
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                color: Provider.of<ThemeProvider>(
                                                                            context)
                                                                        .darkTheme
                                                                    ? ColorResources.getTextColor(
                                                                        context)
                                                                    : ResponsiveHelper.isDesktop(
                                                                            context)
                                                                        ? ColorResources.getDarkColor(
                                                                            context)
                                                                        : ColorResources.getBackgroundColor(
                                                                            context),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 10,
                                                              width: 150,
                                                              color: ResponsiveHelper.isDesktop(context)
                                                                  ? ColorResources
                                                                      .getDarkColor(
                                                                          context)
                                                                  : ColorResources
                                                                      .getBackgroundColor(
                                                                          context))
                                                      : Text(
                                                          getTranslated(
                                                              'guest', context),
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .darkTheme
                                                                ? ColorResources
                                                                    .getTextColor(
                                                                        context)
                                                                : ResponsiveHelper
                                                                        .isDesktop(
                                                                            context)
                                                                    ? ColorResources
                                                                        .getDarkColor(
                                                                            context)
                                                                    : ColorResources
                                                                        .getBackgroundColor(
                                                                            context),
                                                          ),
                                                        ),
                                                  _isLoggedIn
                                                      ? profileProvider
                                                                  .userInfoModel !=
                                                              null
                                                          ? Text(
                                                              '${profileProvider.userInfoModel.phone ?? ''}',
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                color: Provider.of<ThemeProvider>(
                                                                            context)
                                                                        .darkTheme
                                                                    ? ColorResources.getTextColor(
                                                                        context)
                                                                    : ResponsiveHelper.isDesktop(
                                                                            context)
                                                                        ? ColorResources.getDarkColor(
                                                                            context)
                                                                        : ColorResources.getBackgroundColor(
                                                                            context),
                                                              ))
                                                          : Container(
                                                              height: 10,
                                                              width: 100,
                                                              color: ResponsiveHelper.isDesktop(context)
                                                                  ? ColorResources
                                                                      .getDarkColor(
                                                                          context)
                                                                  : ColorResources
                                                                      .getBackgroundColor(
                                                                          context))
                                                      : Text(
                                                          '0123456789',
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .darkTheme
                                                                ? ColorResources
                                                                    .getTextColor(
                                                                        context)
                                                                : ResponsiveHelper
                                                                        .isDesktop(
                                                                            context)
                                                                    ? ColorResources
                                                                        .getDarkColor(
                                                                            context)
                                                                    : ColorResources
                                                                        .getBackgroundColor(
                                                                            context),
                                                          ),
                                                        ),
                                                ]),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.notifications,
                                              color: Provider.of<ThemeProvider>(
                                                          context)
                                                      .darkTheme
                                                  ? ColorResources.getTextColor(
                                                      context)
                                                  : ResponsiveHelper.isDesktop(
                                                          context)
                                                      ? ColorResources
                                                          .getDarkColor(context)
                                                      : ColorResources
                                                          .getBackgroundColor(
                                                              context)),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                RouteHelper.notification,
                                                arguments:
                                                    NotificationScreen());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  ResponsiveHelper.isDesktop(context)
                                      ? SizedBox()
                                      : MenuButton(
                                          drawerController: drawerController,
                                          index: 0,
                                          icon: Images.home,
                                          title:
                                              getTranslated('home', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 1,
                                      icon: Images.more_icon,
                                      title: getTranslated(
                                          'all_categories', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 2,
                                      icon: Images.order_bag,
                                      title: getTranslated(
                                          'shopping_bag', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 3,
                                      icon: Images.order_list,
                                      title:
                                          getTranslated('my_order', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 4,
                                      icon: Images.location,
                                      title: getTranslated('address', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 5,
                                      icon: Images.coupon,
                                      title: getTranslated('coupon', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 6,
                                      icon: Images.chat,
                                      title:
                                          getTranslated('live_chat', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 7,
                                      icon: Images.settings,
                                      title:
                                          getTranslated('settings', context)),
                                  MenuButton(
                                    drawerController: drawerController,
                                    index: 8,
                                    icon: Images.terms_and_conditions,
                                    title: getTranslated(
                                        'terms_and_condition', context),
                                  ),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 9,
                                      icon: Images.privacy,
                                      title: getTranslated(
                                          'privacy_policy', context)),
                                  MenuButton(
                                      drawerController: drawerController,
                                      index: 10,
                                      icon: Images.about_us,
                                      title:
                                          getTranslated('about_us', context)),
                                  ListTile(
                                    onTap: () {
                                      if (_isLoggedIn) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) =>
                                                SignOutConfirmationDialog());
                                      } else {
                                        Provider.of<SplashProvider>(context,
                                                listen: false)
                                            .setPageIndex(0);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            RouteHelper.getLoginRoute(),
                                            (route) => false);
                                      }
                                    },
                                    leading: Image.asset(
                                      _isLoggedIn
                                          ? Images.log_out
                                          : Images.app_logo,
                                      color: Provider.of<ThemeProvider>(context)
                                              .darkTheme
                                          ? ColorResources.getTextColor(context)
                                          : ResponsiveHelper.isDesktop(context)
                                              ? ColorResources.getDarkColor(
                                                  context)
                                              : ColorResources
                                                  .getBackgroundColor(context),
                                      width: 25,
                                      height: 25,
                                    ),
                                    title: Text(
                                      getTranslated(
                                          _isLoggedIn ? 'log_out' : 'login',
                                          context),
                                      style: poppinsRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                          color: Provider.of<ThemeProvider>(
                                                      context)
                                                  .darkTheme
                                              ? ColorResources.getTextColor(
                                                  context)
                                              : ResponsiveHelper.isDesktop(
                                                      context)
                                                  ? ColorResources.getDarkColor(
                                                      context)
                                                  : ColorResources
                                                      .getBackgroundColor(
                                                          context)),
                                    ),
                                  ),
                                ]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Theme.of(context).cardColor,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                // primaryColor: Colors.red,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: Obx(
              () => new BottomNavigationBar(
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: pageIndex.value,
                onTap: (int index) {
                  pageIndex.value = index;
                  /*switch (index) {
                    case 0: splash.setPageIndex(0); break;
                    case 1: splash.setPageIndex(2); break;
                    case 2: splash.setPageIndex(3); break;
                    case 0: splash.setPageIndex(6); break;
                    case 0: splash.setPageIndex(7); break;
                  }*/
                },
                // selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                // unselectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                // selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                // unselectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                showUnselectedLabels: true,
                items: <BottomNavigationBarItem>[
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    label: "Home",
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.shopping_cart),
                    label: "Cart",
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.article_rounded),
                    label: "Orders",
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.chat),
                    label: "Notification",
                  ),
                  new BottomNavigationBarItem(
                    
                    icon: new Icon(Icons.menu),
                    label: "Menu",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
