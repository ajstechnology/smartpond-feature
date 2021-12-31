import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartpond/helper/email_checker.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/helper/route_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/images.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:smartpond/view/base/custom_button.dart';
import 'package:smartpond/view/base/custom_snackbar.dart';
import 'package:smartpond/view/base/custom_text_field.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/screens/auth/create_account_screen.dart';
import 'package:smartpond/view/screens/auth/widget/code_picker_widget.dart';
import 'package:smartpond/view/screens/forgot_password/verification_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var bgColor = Color(0xffecf0f3);
  bool email = true;
  var neuMorphicDeco = BoxDecoration(
      color: Color(0xffecf0f3),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[500],
            offset: Offset(10, 10),
            spreadRadius: 1,
            blurRadius: 15),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-10, -10),
            spreadRadius: 1,
            blurRadius: 15)
      ]);

  bool phone = false;

  String _countryDialCode = '+880';
  TextEditingController _emailController;
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    // Provider.of<AuthProvider>(context, listen: false).clearVerificationMessage();
    _countryDialCode = CountryCode.fromCountryCode(
            Provider.of<SplashProvider>(context, listen: false)
                .configModel
                .country)
        .dialCode;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            physics: BouncingScrollPhysics(),
            child: Container(
              width: _width > 700 ? 700 : _width,
              padding: _width > 700
                  ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                  : null,
              decoration: _width > 700
                  ? BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    )
                  : null,
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    // Center(
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height / 3,
                    //   ),
                    // ),
                    Container(
                      height: 200,
                      width: 650,
                      child: Image.asset("assets/image/login_img.jpeg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            getTranslated('signup', context),
                            style: poppinsMedium.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.getTextColor(context)),
                          ),
                          SizedBox(height: 35),
                          Provider.of<SplashProvider>(context, listen: false)
                                  .configModel
                                  .emailVerification
                              ? Text(
                                  getTranslated('email', context),
                                  style: poppinsRegular.copyWith(
                                      color:
                                          ColorResources.getHintColor(context)),
                                )
                              : Text(
                                  getTranslated('mobile_number', context),
                                  style: poppinsRegular.copyWith(
                                      color:
                                          ColorResources.getHintColor(context)),
                                ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Provider.of<SplashProvider>(context, listen: false)
                                  .configModel
                                  .emailVerification
                              ? CustomTextField(
                                  hintText:
                                      getTranslated('demo_gmail', context),
                                  isShowBorder: true,
                                  inputAction: TextInputAction.done,
                                  inputType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                )
                              : Row(children: [
                                  // CodePickerWidget(
                                  //   onChanged:
                                  //       (CountryCode countryCode) {
                                  //     _countryDialCode =
                                  //         countryCode.dialCode;
                                  //   },
                                  //   initialSelection:
                                  //       _countryDialCode,
                                  //   favorite: [_countryDialCode],
                                  //   showDropDownButton: true,
                                  //   padding: EdgeInsets.zero,
                                  //   showFlagMain: true,
                                  //   textStyle: TextStyle(
                                  //       color: Theme.of(context)
                                  //           .textTheme
                                  //           .headline1
                                  //           .color),
                                  // ),
                                  Expanded(
                                      child: ClayContainer(
                                    emboss: true,
                                    spread: 5,
                                    depth: 100,
                                    borderRadius: 30,
                                    child: CustomTextField(
                                      hintText:
                                          getTranslated('number_hint', context),
                                      isShowBorder: false,
                                      fillColor: bgColor,
                                      controller: _emailController,
                                      inputType: TextInputType.phone,
                                      inputAction: TextInputAction.done,
                                    ),
                                  )),
                                ]),
                          SizedBox(height: 6),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_LARGE),
                              child: Divider(height: 1)),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              authProvider.verificationMessage.length > 0
                                  ? CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      radius: 5)
                                  : SizedBox.shrink(),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  authProvider.verificationMessage ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              )
                            ],
                          ),

                          // for continue button
                          SizedBox(height: 12),
                          !authProvider.isPhoneNumberVerificationButtonLoading
                              ? InkWell(
                                  onTap: () {
                                    String _email =
                                        _emailController.text.trim();
                                    if (_email.isEmpty) {
                                      if (Provider.of<SplashProvider>(context,
                                              listen: false)
                                          .configModel
                                          .emailVerification) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_email_address', context),
                                            context);
                                      } else {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_phone_number', context),
                                            context);
                                      }
                                    } else if (Provider.of<SplashProvider>(
                                                context,
                                                listen: false)
                                            .configModel
                                            .emailVerification &&
                                        EmailChecker.isNotValid(_email)) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              'enter_valid_email', context),
                                          context);
                                    } else {
                                      if (Provider.of<SplashProvider>(context,
                                              listen: false)
                                          .configModel
                                          .emailVerification) {
                                        authProvider
                                            .checkEmail(_email)
                                            .then((value) async {
                                          if (value.isSuccess) {
                                            authProvider.updateEmail(_email);
                                            if (value.message == 'active') {
                                              Navigator.of(context).pushNamed(
                                                RouteHelper.getVerifyRoute(
                                                    'sign-up', _email),
                                                arguments: VerificationScreen(
                                                    emailAddress: _email,
                                                    fromSignUp: true),
                                              );
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  RouteHelper.createAccount,
                                                  arguments:
                                                      CreateAccountScreen());
                                            }
                                          }
                                        });
                                      } else {
                                        authProvider
                                            .checkPhone(
                                                _countryDialCode + _email)
                                            .then((value) async {
                                          if (value.isSuccess) {
                                            authProvider.updateEmail(
                                                _countryDialCode + _email);
                                            if (value.message == 'active') {
                                              Navigator.of(context).pushNamed(
                                                RouteHelper.getVerifyRoute(
                                                    'sign-up',
                                                    _countryDialCode + _email),
                                                arguments: VerificationScreen(
                                                    emailAddress:
                                                        _countryDialCode +
                                                            _email,
                                                    fromSignUp: true),
                                              );
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  RouteHelper.createAccount,
                                                  arguments:
                                                      CreateAccountScreen());
                                            }
                                          }
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: neuMorphicDeco,
                                    height: 50,
                                    width: 500,
                                    child: Center(
                                      child: Text(
                                          getTranslated('continue', context)),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Theme.of(context).primaryColor))),

                          // for create an account
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(
                                        'already_have_account', context),
                                    style: poppinsRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: ColorResources.getHintColor(
                                            context)),
                                  ),
                                  SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL),
                                  Text(
                                    getTranslated('login', context),
                                    style: poppinsMedium.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: ColorResources.getTextColor(
                                            context)),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }
}
