import 'package:clay_containers/clay_containers.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smartpond/helper/email_checker.dart';
import 'package:smartpond/helper/responsive_helper.dart';
import 'package:smartpond/helper/route_helper.dart';
import 'package:smartpond/localization/language_constrants.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/utill/color_resources.dart';
import 'package:smartpond/utill/dimensions.dart';
import 'package:smartpond/utill/styles.dart';
import 'package:smartpond/view/base/custom_button.dart';
import 'package:smartpond/view/base/custom_snackbar.dart';
import 'package:smartpond/view/base/custom_text_field.dart';
import 'package:smartpond/view/base/main_app_bar.dart';
import 'package:smartpond/view/base/my_arc.dart';
import 'package:smartpond/view/screens/auth/signup_screen.dart';
import 'package:smartpond/view/screens/auth/widget/code_picker_widget.dart';
import 'package:smartpond/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:smartpond/view/screens/menu/menu_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  FocusNode _emailFocus = FocusNode();
  GlobalKey<FormState> _formKeyLogin;
  FocusNode _numberFocus = FocusNode();
  TextEditingController _passwordController;
  FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserNumber() ??
            null;
    _passwordController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserPassword() ??
            null;
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
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  width: _width > 700 ? 700 : _width,
                  padding: _width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE)
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
                    builder: (context, authProvider, child) => Form(
                      key: _formKeyLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  physics: BouncingScrollPhysics(),
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                Text(
                                  getTranslated('login', context),
                                  style: poppinsMedium.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          ColorResources.getTextColor(context)),
                                ),
                                // //SizedBox(height: 20),

                                SizedBox(height: 35),
                                Provider.of<SplashProvider>(context,
                                            listen: false)
                                        .configModel
                                        .emailVerification
                                    ? Text(
                                        getTranslated('email', context),
                                        style: poppinsRegular.copyWith(
                                            color: ColorResources.getHintColor(
                                                context)),
                                      )
                                    : Text(
                                        getTranslated('mobile_number', context),
                                        style: poppinsRegular.copyWith(
                                            color: ColorResources.getHintColor(
                                                context)),
                                      ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                Provider.of<SplashProvider>(context,
                                            listen: false)
                                        .configModel
                                        .emailVerification
                                    ? CustomTextField(
                                        hintText: getTranslated(
                                            'demo_gmail', context),
                                        isShowBorder: true,
                                        focusNode: _emailFocus,
                                        nextFocus: _passwordFocus,
                                        controller: _emailController,
                                        inputType: TextInputType.emailAddress,
                                      )
                                    : Row(children: [
                                        // CodePickerWidget(
                                        //   onChanged: (CountryCode countryCode) {
                                        //     _countryDialCode =
                                        //         countryCode.dialCode;
                                        //   },
                                        //   initialSelection: _countryDialCode,
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
                                            child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffecf0f3),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClayContainer(
                                            emboss: true,
                                            spread: 5,
                                            depth: 100,
                                            borderRadius: 100,
                                            child: CustomTextField(
                                              fillColor: bgColor,
                                              hintText: getTranslated(
                                                  'number_hint', context),
                                              isShowBorder: false,
                                              focusNode: _numberFocus,
                                              nextFocus: _passwordFocus,
                                              controller: _emailController,
                                              inputType: TextInputType.phone,
                                            ),
                                          ),
                                        )),
                                      ]),

                                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                Text(
                                  getTranslated('password', context),
                                  style: poppinsRegular.copyWith(
                                      color:
                                          ColorResources.getHintColor(context)),
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                ClayContainer(
                                  emboss: true,
                                  spread: 5,
                                  depth: 100,
                                  borderRadius: 50,
                                  child: CustomTextField(
                                    fillColor: bgColor,
                                    hintText:
                                        getTranslated('password_hint', context),
                                    isShowBorder: false,
                                    isPassword: true,
                                    isShowSuffixIcon: true,
                                    isElevation: false,
                                    focusNode: _passwordFocus,
                                    controller: _passwordController,
                                    inputAction: TextInputAction.done,
                                  ),
                                ),
                                SizedBox(height: 20),

                                // for remember me section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        authProvider.toggleRememberMe();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: authProvider
                                                        .isActiveRememberMe
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : ColorResources
                                                        .getCardBgColor(
                                                            context),
                                                border: Border.all(
                                                    color: authProvider
                                                            .isActiveRememberMe
                                                        ? Colors.transparent
                                                        : Theme.of(context)
                                                            .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: authProvider
                                                      .isActiveRememberMe
                                                  ? Icon(Icons.done,
                                                      color: Colors.white,
                                                      size: 17)
                                                  : SizedBox.shrink(),
                                            ),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            Text(
                                              getTranslated(
                                                  'remember_me', context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_SMALL,
                                                      color: ColorResources
                                                          .getHintColor(
                                                              context)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteHelper.forgetPassword,
                                            arguments: ForgotPasswordScreen());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getTranslated(
                                              'forgot_password', context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    authProvider.loginErrorMessage.length > 0
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            radius: 5)
                                        : SizedBox.shrink(),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        authProvider.loginErrorMessage ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    )
                                  ],
                                ),

                                // for login button
                                SizedBox(height: 10),
                                !authProvider.isLoading
                                    ? InkWell(
                                        child: Container(
                                          decoration: neuMorphicDeco,
                                          height: 50,
                                          child: Center(
                                            child: Text(getTranslated(
                                                'login', context)),
                                          ),
                                        ),
                                        onTap: () async {
                                          String _email =
                                              _emailController.text.trim();
                                          if (!Provider.of<SplashProvider>(
                                                  context,
                                                  listen: false)
                                              .configModel
                                              .emailVerification) {
                                            _email = _countryDialCode +
                                                _emailController.text.trim();
                                          }
                                          String _password =
                                              _passwordController.text.trim();
                                          if (_email.isEmpty) {
                                            if (Provider.of<SplashProvider>(
                                                    context,
                                                    listen: false)
                                                .configModel
                                                .emailVerification) {
                                              showCustomSnackBar(
                                                  getTranslated(
                                                      'enter_email_address',
                                                      context),
                                                  context);
                                            } else {
                                              showCustomSnackBar(
                                                  getTranslated(
                                                      'enter_phone_number',
                                                      context),
                                                  context);
                                            }
                                          } else if (Provider.of<
                                                          SplashProvider>(
                                                      context,
                                                      listen: false)
                                                  .configModel
                                                  .emailVerification &&
                                              EmailChecker.isNotValid(_email)) {
                                            showCustomSnackBar(
                                                getTranslated(
                                                    'enter_valid_email',
                                                    context),
                                                context);
                                          } else if (_password.isEmpty) {
                                            showCustomSnackBar(
                                                getTranslated(
                                                    'enter_password', context),
                                                context);
                                          } else if (_password.length < 6) {
                                            showCustomSnackBar(
                                                getTranslated(
                                                    'password_should_be',
                                                    context),
                                                context);
                                          } else {
                                            authProvider
                                                .login(_email, _password)
                                                .then((status) async {
                                              if (status.isSuccess) {
                                                if (authProvider
                                                    .isActiveRememberMe) {
                                                  authProvider
                                                      .saveUserNumberAndPassword(
                                                          _emailController.text,
                                                          _password);
                                                } else {
                                                  authProvider
                                                      .clearUserNumberAndPassword();
                                                }
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        RouteHelper.menu,
                                                        (route) => false,
                                                        arguments:
                                                            MenuScreen());
                                              }
                                            });
                                          }
                                        },
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      )),

                                // for create an account
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteHelper.signUp,
                                        arguments: SignUpScreen());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getTranslated(
                                              'create_an_account', context),
                                          style: poppinsRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color:
                                                  ColorResources.getHintColor(
                                                      context)),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Text(
                                          getTranslated('signup', context),
                                          style: poppinsMedium.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color:
                                                  ColorResources.getTextColor(
                                                      context)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Center(
                                    child: Text(getTranslated('OR', context),
                                        style: poppinsRegular.copyWith(
                                            fontSize: 12))),

                                Center(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(1, 40),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, RouteHelper.menu,
                                          arguments: MenuScreen());
                                    },
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '${getTranslated('login_as_a', context)} ',
                                          style: poppinsRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color:
                                                  ColorResources.getHintColor(
                                                      context))),
                                      TextSpan(
                                          text: getTranslated('guest', context),
                                          style: poppinsRegular.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color)),
                                    ])),
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
          ),
        ),
      ),
    );
  }
}
