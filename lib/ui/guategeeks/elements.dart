import 'package:flutter/material.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/guategeeks/navigators.dart';
import 'package:geeksday/ui/helpers/return_button.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:rive/rive.dart' as rive;

extension BreakpointUtils on BoxConstraints {
  bool get isTablet => maxWidth > 730;
  bool get isDesktop => maxWidth > 1200;
  bool get isMobile => !isTablet && !isDesktop;
}

class GuateGeeksScaffold extends StatelessWidget {
  final Widget body;
  Widget? floatingActionButton;
  Widget? bottomNavigationBar;
  Widget? sidenavigationBar;
  final String? idEvent;
  GuateGeeksScaffold({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.idEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bottomNavigationBar == null) {
      setupBottonNavigationLocator(idEvent);
      bottomNavigationBar = guateGeeksNavigatonBars<BottomNavigation>();
    }
    if (sidenavigationBar == null) {
      setupSideNavigationLocator(idEvent);
      sidenavigationBar = guateGeeksNavigatonBars<SideNavigation>();
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 200) {
        return Container();
      }
      return Scaffold(
        appBar: AppBar(
          leading: constraints.isMobile ? const ReturnButton() : null,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
            child: SizedBox(
              width: 200,
              height: 37,
              child: rive.RiveAnimation.network(
                '/assets/rive/guategeeks_logo.riv',
                artboard: 'full_logo',
                animations: ['single_blink_loop'],
              ),
            ),
          ),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: IconButton(
                padding: const EdgeInsets.only(right: 15, left: 15),
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                  size: 30,
                ),
                onPressed: () {
                  locator<NavigationService>().navigateTo('/configuracion');
                },
              ),
            ),
          ],
        ),
        body: constraints.isMobile
            ? body
            : Row(
                children: [
                  sidenavigationBar ?? Container(),
                  Expanded(child: body),
                ],
              ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: constraints.isMobile ? bottomNavigationBar : null,
      );
    });
  }
}
