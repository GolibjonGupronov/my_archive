import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  static const String tag = '/security_page';

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> with RouteAware {
  bool _hasPin = false;

  @override
  void initState() {
    super.initState();
    _checkPinStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _checkPinStatus();
  }

  Future<void> _checkPinStatus() async {
    final hasPin = await sl.get<SecureStorage>().hasPin;
    if (mounted) setState(() => _hasPin = hasPin);
  }

  @override
  Widget build(BuildContext context) {
    logger("GGQ => SecurityPage");
    return CustomScaffold(
      appBar: CustomAppBar("Xavfsizlik"),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ComingSoonWidget(
                child: ProfileItem(
                  title: "Parolni tahrirlash",
                  prefixIconData: Icons.key_rounded,
                  onTap: () => context.push(OldPasswordPage.tag),
                ),
              ),
              ProfileItem(
                title: "Ilova qulfi",
                prefixIconData: CupertinoIcons.lock_fill,
                suffixWidget: Icon(
                  _hasPin ? CupertinoIcons.lock_fill : CupertinoIcons.lock_open_fill,
                  color: AppColors.gray,
                ),
                onTap: () {
                  router.push(_hasPin ? CurrentPinPage.tag : NewPinPage.tag);
                },
              ),
              ProfileItem(
                title: "Qurilma sessiyasi",
                prefixIconData: Icons.phone_android_rounded,
                onTap: () => context.push(DeviceSessionPage.tag),
              ),
            ],
          )
        ],
      ),
    );
  }
}
