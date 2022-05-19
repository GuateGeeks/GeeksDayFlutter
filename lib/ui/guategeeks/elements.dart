import 'package:flutter/material.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/bottom_navigation.dart';
import 'package:geeksday/ui/helpers/return_button.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:rive/rive.dart' as rive;

class GuateGeeksScaffold extends StatelessWidget {
  final Widget body;
  Widget? floatingActionButton;
  Widget? bottomNavigationBar;
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
    if (idEvent != null && bottomNavigationBar == null) {
      setupBottonNavigationLocator(idEvent);
      bottomNavigationBar = BottomNavigation(idEvent: idEvent!);
      bottomNavigationBar ??= guateGeeksBottomNavigatonBar<BottomNavigation>();
    }

    if (bottomNavigationBar == null &&
        guateGeeksBottomNavigatonBar.isRegistered<BottomNavigation>()) {
      bottomNavigationBar = guateGeeksBottomNavigatonBar<BottomNavigation>();
    }

    return Scaffold(
      appBar: AppBar(
        leading: const ReturnButton(),
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
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
