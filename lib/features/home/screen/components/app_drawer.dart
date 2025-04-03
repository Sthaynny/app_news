import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/home/screen/home_view_model.dart';
import 'package:ufersa_hub/features/shared/components/app_icon.dart';
import 'package:ufersa_hub/features/shared/utils/extension/soon_popup.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.viewmodel});
  final HomeViewModel viewmodel;

  Widget _addPadding(Widget child) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: DSSpacing.md.value,
      vertical: DSSpacing.xxs.value,
    ),
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: DSColors.secundary),
            child: Row(
              children: [
                AppIcon(),
                DSSpacing.xs.x,
                DSHeadlineLargeText(menuString, color: DSColors.white),
              ],
            ),
          ),
          _addPadding(
            DSGhostButton(
              onPressed: () {
                context.showComingSoonPopup();
              },
              label: eventsString,
            ),
          ),

          ListenableBuilder(
            listenable: viewmodel.logout,
            builder:
                (context, child) =>
                    viewmodel.userAuthenticated
                        ? _addPadding(
                          DSPrimaryButton(
                            onPressed: () {
                              viewmodel.logout.execute();
                            },
                            label: logoutString,
                            backgroundColor: DSColors.error,
                            trailingIcon: Icon(
                              DSIcons.exit_outline.data,
                              color: Colors.white,
                            ),
                          ),
                        )
                        : Container(),
          ),
        ],
      ),
    );
  }
}
