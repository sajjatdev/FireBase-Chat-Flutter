import 'package:FireChat/Logic/AuthStatus/auth_status_cubit.dart';
import 'package:FireChat/Router/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Logic/Phone_Auth/phone_auth_cubit.dart';
import 'Services/Auth/authservices.dart';

late SharedPreferences shareP;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    shareP = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    print(e.toString());
  }

  runApp(QueryPeople());
}

class QueryPeople extends StatelessWidget {
  QueryPeople({Key? key}) : super(key: key);

  Brightness brightness = Brightness.light;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          // Firebase Phone Number Auth BlocProvider Start
          BlocProvider(
              create: (context) =>
                  PhoneAuthCubit(AuthServices(FirebaseAuth.instance))),
          // Firebase Phone Number Auth BlocProvider End

          // Firebase  Auth Status BlocProvider Start
          BlocProvider(
              create: (context) =>
                  AuthStatusCubit(AuthServices(FirebaseAuth.instance))),
          // Firebase  Auth Status BlocProvider End
        ],
        child: PlatformProvider(
            settings: PlatformSettingsData(iosUsesMaterialWidgets: false),
            builder: (context) {
              return PlatformApp(
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  debugShowCheckedModeBanner: false,
                  initialRoute: "/",
                  onGenerateRoute: Routers.onGenerateRoute,
                  cupertino: (context, __) =>
                      CupertinoAppData(theme: CupertinoThemeData()));
            }),
      );
    });
  }
}
