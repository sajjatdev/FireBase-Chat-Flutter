// ignore_for_file: sort_child_properties_last, prefer_function_declarations_over_variables

import 'dart:io';
import 'dart:math';
import 'package:FireChat/Widget/Qcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class Profile_Setup extends StatefulWidget {
  const Profile_Setup({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/profile_setup';

  static Route route() {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Profile_Setup());
    } else {
      return MaterialPageRoute(
          settings: const RouteSettings(name: routeName),
          builder: (_) => Profile_Setup());
    }
  }

  @override
  State<Profile_Setup> createState() => _Profile_SetupState();
}

class _Profile_SetupState extends State<Profile_Setup>
    with TickerProviderStateMixin {
  late AnimationController profile_animation;
  late Animation animation;
  TextEditingController name = TextEditingController();
  TextEditingController cat_user = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController Businessname = TextEditingController();
  TextEditingController Category = TextEditingController();
  TextEditingController addressbusiness = TextEditingController();
  TextEditingController descriptionbusines = TextEditingController();
  bool nameclear = false;
  bool userclear = false;
  bool addressclear = false;
  @override
  void initState() {
    profile_animation =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    profile_animation.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return FadeTransition(
      opacity: profile_animation.drive(CurveTween(curve: Curves.easeIn)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          body: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: SizedBox(
                    height: 35.sp,
                    child: AppBar(
                      backgroundColor: Qcolors(context),
                      bottom: TabBar(
                        labelColor: isDarkMode ? Colors.black : Colors.white,
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor:
                            isDarkMode ? Colors.white : Colors.black,
                        indicator: BoxDecoration(
                            color: QTextColor(context),
                            borderRadius: BorderRadius.circular(10.sp)),
                        tabs: const [
                          Tab(
                            text: "Profile",
                          ),
                          Tab(
                            text: "Business",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              Expanded(
                  child: TabBarView(children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35.sp,
                      backgroundColor: Qcolors(context),
                      child: Icon(
                        CupertinoIcons.photo,
                        color: QTextColor(context),
                      ),
                    ),
                    PlatformTextButton(
                      onPressed: () {},
                      child: Text(
                        "Set profile photo",
                        style: TextStyle(
                            color: QTextColor(context), fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: name,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    nameclear = true;
                                  });
                                } else {
                                  setState(() {
                                    nameclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: nameclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              nameclear = false;
                                              name.clear();
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Full name",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: name,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  nameclear = true;
                                });
                              } else {
                                setState(() {
                                  nameclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: nameclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            name.clear();
                                            nameclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Full name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),
                    // username

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: cat_user,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    userclear = true;
                                  });
                                } else {
                                  setState(() {
                                    userclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: userclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              cat_user.clear();
                                              userclear = false;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Username",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: cat_user,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  userclear = true;
                                });
                              } else {
                                setState(() {
                                  userclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: userclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cat_user.clear();
                                            userclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),
                    // addresss

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: address,
                              keyboardType: TextInputType.streetAddress,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    addressclear = true;
                                  });
                                } else {
                                  setState(() {
                                    addressclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: addressclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              address.clear();
                                              addressclear = false;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Address",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: address,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.streetAddress,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  addressclear = true;
                                });
                              } else {
                                setState(() {
                                  addressclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: addressclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            address.clear();
                                            addressclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Address",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        child: TextField(
                          controller: description,
                          cursorColor: QTextColor(context),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontSize: 15.sp, color: QTextColor(context)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Qcolors(context),
                              hintText: "Write about yoursself (optional)",
                              hintStyle: TextStyle(
                                  color: QTextColor(context).withOpacity(.5),
                                  fontSize: 10.sp),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.sp))),
                        ),
                      ),
                    ),
                    PlatformWidget(
                      material: (context, platform) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 12.w,
                            width: 50.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Qcolors(context),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Text(
                              "SAVE PROFILE INFO",
                              style: TextStyle(
                                  color: QTextColor(context), fontSize: 15.sp),
                            ),
                          ),
                        );
                      },
                      cupertino: (context, platform) {
                        return CupertinoButton(
                            color: Qcolors(context),
                            onPressed: () {},
                            child: Text(
                              "SAVE PROFILE INFO",
                              style: TextStyle(color: QTextColor(context)),
                            ));
                      },
                    )
                  ],
                ),

                // Tab View 2
                ///
                ///
                ///
                ///
                ///
                ///Start
                ///
                ///
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35.sp,
                      backgroundColor: Qcolors(context),
                      child: Icon(
                        CupertinoIcons.photo,
                        color: QTextColor(context),
                      ),
                    ),
                    PlatformTextButton(
                      onPressed: () {},
                      child: Text(
                        "Set Business Logo",
                        style: TextStyle(
                            color: QTextColor(context), fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: Businessname,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    nameclear = true;
                                  });
                                } else {
                                  setState(() {
                                    nameclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: nameclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              Businessname.clear();
                                              nameclear = false;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Business name",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: Businessname,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  nameclear = true;
                                });
                              } else {
                                setState(() {
                                  nameclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: nameclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Businessname.clear();
                                            nameclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Business name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),
                    // username

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: Category,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    userclear = true;
                                  });
                                } else {
                                  setState(() {
                                    userclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: userclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              Category.clear();
                                              userclear = false;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Category",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: Category,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  userclear = true;
                                });
                              } else {
                                setState(() {
                                  userclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: userclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Category.clear();
                                            userclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Category",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),
                    // addresss

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      child: PlatformWidget(
                        cupertino: (context, platform) {
                          return PlatformTextField(
                              controller: addressbusiness,
                              keyboardType: TextInputType.streetAddress,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    addressclear = true;
                                  });
                                } else {
                                  setState(() {
                                    addressclear = false;
                                  });
                                }
                              },
                              cupertino: (_, __) => CupertinoTextFieldData(
                                  suffix: addressclear
                                      ? PlatformIconButton(
                                          onPressed: () {
                                            setState(() {
                                              addressbusiness.clear();
                                              addressclear = false;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            size: 15.sp,
                                            color: QTextColor(context),
                                          ))
                                      : null,
                                  cursorColor: QTextColor(context),
                                  decoration: BoxDecoration(
                                      color: Qcolors(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  placeholder: "Address",
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 12.sp)));
                        },
                        material: (context, platform) {
                          return TextField(
                            controller: addressbusiness,
                            cursorColor: QTextColor(context),
                            keyboardType: TextInputType.streetAddress,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  addressclear = true;
                                });
                              } else {
                                setState(() {
                                  addressclear = false;
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 15.sp, color: QTextColor(context)),
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: addressclear
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            addressbusiness.clear();
                                            addressclear = false;
                                          });
                                        },
                                        color: QTextColor(context),
                                        icon: const Icon(
                                          Icons.close,
                                        ))
                                    : null,
                                fillColor: Qcolors(context),
                                hintText: "Address",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10.sp))),
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        child: TextField(
                          cursorColor: QTextColor(context),
                          maxLines: 5,
                          controller: descriptionbusines,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontSize: 15.sp, color: QTextColor(context)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Qcolors(context),
                              hintText: "Write about your business (optional)",
                              hintStyle: TextStyle(
                                  color: QTextColor(context).withOpacity(.5),
                                  fontSize: 10.sp),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.sp))),
                        ),
                      ),
                    ),
                    PlatformWidget(
                      material: (context, platform) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 12.w,
                            width: 50.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Qcolors(context),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Text(
                              "SAVE BUSINESS INFO",
                              style: TextStyle(
                                  color: QTextColor(context), fontSize: 15.sp),
                            ),
                          ),
                        );
                      },
                      cupertino: (context, platform) {
                        return CupertinoButton(
                            color: Qcolors(context),
                            onPressed: () {},
                            child: Text(
                              "SAVE BUSINESS INFO",
                              style: TextStyle(color: QTextColor(context)),
                            ));
                      },
                    )
                  ],
                ),
              ]))
            ],
          )),
        ),
      ),
    );
  }
}
