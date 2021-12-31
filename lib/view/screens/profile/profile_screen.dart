import 'package:flutter/material.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/helper/route_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/profile_provider.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/images.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/base/not_login_screen.dart';
import 'package:smartpond/view/screens/profile/profile_edit_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: ResponsiveHelper.isDesktop(context)
          ? MainAppBar()
          : AppBar(
              backgroundColor: Theme.of(context).cardColor,
              leading: IconButton(
                  icon: Image.asset(Images.list,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Provider.of<SplashProvider>(context, listen: false)
                        .setPageIndex(0);
                    Navigator.of(context).pop();
                  }),
              title: Text(getTranslated('profile', context),
                  style: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  )),
            ),
      body: SafeArea(
          child: _isLoggedIn
              ? Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Center(
                          child: SizedBox(
                            width: 1170,
                            child: Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    ColorResources.getGreyColor(
                                                        context),
                                                width: 2),
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: profileProvider.file == null
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      Images.placeholder,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                  image:
                                                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${profileProvider.userInfoModel.image}',
                                                  imageErrorBuilder:
                                                      (c, o, s) => Image.asset(
                                                          Images.placeholder,
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover))
                                              : Image.file(profileProvider.file,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fill),
                                        )),
                                    Positioned(
                                      right: -10,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteHelper.getProfileEditRoute(
                                              profileProvider
                                                  .userInfoModel.fName,
                                              profileProvider
                                                  .userInfoModel.lName,
                                              profileProvider
                                                  .userInfoModel.email,
                                              profileProvider
                                                  .userInfoModel.phone,
                                            ),
                                            arguments: ProfileEditScreen(
                                                userInfoModel: profileProvider
                                                    .userInfoModel),
                                          );
                                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEditScreen(userInfoModel: profileProvider.userInfoModel)));
                                        },
                                        child: Text(
                                          getTranslated('edit', context),
                                          style: poppinsMedium.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // for name
                                Center(
                                    child: Text(
                                  '${profileProvider.userInfoModel.fName ?? ''} ${profileProvider.userInfoModel.lName ?? ''}',
                                  style: poppinsMedium.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_LARGE),
                                )),

                                //mobileNumber,email,gender
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // for first name section
                                      Text(
                                        getTranslated('mobile_number', context),
                                        style: poppinsRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_SMALL,
                                            color: ColorResources.getHintColor(
                                                context)),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        '${profileProvider.userInfoModel.phone ?? ''}',
                                        style: poppinsRegular.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT),
                                      ),
                                      Divider(),
                                      SizedBox(height: 25),

                                      // for email section
                                      Text(
                                        getTranslated('email', context),
                                        style: poppinsRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_SMALL,
                                            color: ColorResources.getHintColor(
                                                context)),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        '${profileProvider.userInfoModel.email ?? ''}',
                                        style: poppinsRegular.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : NotLoggedInScreen()),
    );
  }
}
