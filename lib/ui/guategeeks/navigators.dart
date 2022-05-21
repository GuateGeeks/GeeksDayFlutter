import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/navigation_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt guateGeeksNavigatonBars = GetIt.instance;
void setupBottonNavigationLocator(idEvent) {
  if (!guateGeeksNavigatonBars.isRegistered<BottomNavigation>()) {
    guateGeeksNavigatonBars.registerLazySingleton<BottomNavigation>(
        () => BottomNavigation(idEvent: idEvent));
  }
}

void setupSideNavigationLocator(idEvent) {
  if (!guateGeeksNavigatonBars.isRegistered<SideNavigation>()) {
    guateGeeksNavigatonBars.registerLazySingleton<SideNavigation>(
        () => SideNavigation(idEvent: idEvent));
  }
}

class BottomNavigation extends StatelessWidget {
  final String? idEvent;
  const BottomNavigation({Key? key, this.idEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).backgroundColor,
      elevation: 30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: NavigationStates.menu.map((item) {
            Type _type = item.runtimeType;
            return _BottomNavigationItem(
              item: NavigationStates.getState(item),
              idEvent: idEvent,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    Key? key,
    required this.item,
    this.idEvent,
  }) : super(key: key);

  final String? idEvent;
  final NavigationState item;

  @override
  Widget build(BuildContext context) {
    double iconHeight = 26;
    double iconWidth = 26;
    if (item is NavigationPost) {
      iconHeight = 32;
      iconWidth = 32;
    } else if (item is NavigationSearch) {
      iconHeight = 24;
      iconWidth = 28;
    }
    return GestureDetector(
      onTap: () {
        item.event = idEvent;
        BlocProvider.of<NavigationCubit>(context).navigateTo(item);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 1),
            child: SvgPicture.asset(
              item.icon,
              height: iconHeight,
              width: iconWidth,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class SideNavigation extends StatelessWidget {
  SideNavigation({
    Key? key,
    this.idEvent,
  }) : super(key: key);

  final String? idEvent;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return NavigationRail(
          labelType: NavigationRailLabelType.selected,
          destinations: NavigationStates.menu.map((item) {
            double iconHeight = 26;
            double iconWidth = 26;
            if (item is NavigationPost) {
              iconHeight = 32;
              iconWidth = 32;
            } else if (item is NavigationSearch) {
              iconHeight = 24;
              iconWidth = 28;
            }
            return NavigationRailDestination(
              icon: Container(
                margin: const EdgeInsets.only(top: 1),
                child: SvgPicture.asset(
                  NavigationStates.getState(item).icon,
                  height: iconHeight,
                  width: iconWidth,
                ),
              ),
              // selectedIcon: SvgPicture.asset(e.icon),
              label: Text(NavigationStates.getState(item).title),
            );
          }).toList(),
          selectedIndex: state.index,
          onDestinationSelected: (index) {
            BlocProvider.of<NavigationCubit>(context).navigateTo(
                NavigationStates.getState(NavigationStates.menu[index]));
          });
    });
  }
}
