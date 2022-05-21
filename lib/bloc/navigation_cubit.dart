import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/locator.dart';

class NavigationStates {
  static final List<Type> menu = [
    NavigationHome,
    NavigationSearch,
    NavigationPost,
    NavigationEvent,
    NavigationProfile
  ];

  static NavigationState getState(Type type) {
    switch (type) {
      case NavigationHome:
        return NavigationHome();
      case NavigationSearch:
        return NavigationSearch();
      case NavigationPost:
        return NavigationPost();
      case NavigationEvent:
        return NavigationEvent();
      case NavigationProfile:
        return NavigationProfile();
      default:
        return NavigationHome();
    }
  }
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationHome());

  void setMaxWidth(double maxWidth) {
    state.maxWidth = maxWidth;
    emit(state);
  }

  bool isDesktop() {
    return state.maxWidth > 1200;
  }

  bool isTablet() {
    return state.maxWidth > 730;
  }

  bool isMobile() {
    return !isDesktop() && !isTablet();
  }

  void setidEvent(idEvent) {
    state.event = idEvent;
  }

  void navigateTo(NavigationState newState) {
    newState.event = state.event;
    newState.maxWidth = state.maxWidth;
    switch (newState.runtimeType) {
      case NavigationHome:
        if (newState.event != null) {
          locator<NavigationService>().navigateTo("/evento/" + newState.event!);
        } else {
          locator<NavigationService>().navigateTo("/eventos");
        }
        break;
      case NavigationSearch:
        break;
      case NavigationPost:
        if (newState.event != null) {
          locator<NavigationService>().navigateTo("/eventos");
          locator<NavigationService>()
              .navigateTo("/evento/" + newState.event! + "/publicacion");
        } else {
          locator<NavigationService>().navigateTo("/eventos");
        }
        break;
      case NavigationEvent:
        locator<NavigationService>().navigateTo("/eventos");
        break;
      case NavigationProfile:
        locator<NavigationService>().navigateTo('/perfil');
        break;
      default:
        break;
    }
    emit(newState);
  }
}

abstract class NavigationState {
  final int index;
  final String title;
  final String icon;
  final String? userId;
  String? event;
  double maxWidth = 400;
  NavigationState(
      {required this.index,
      required this.title,
      required this.icon,
      this.event,
      this.userId});
}

class NavigationHome extends NavigationState {
  NavigationHome({String? event})
      : super(
            index: 0,
            title: "Home",
            icon: "assets/icons/home.svg",
            event: event);
}

class NavigationSearch extends NavigationState {
  NavigationSearch({String? event})
      : super(
            index: 1,
            title: "Search",
            icon: "assets/icons/search.svg",
            event: event);
}

class NavigationPost extends NavigationState {
  NavigationPost({String? event})
      : super(
            index: 2,
            title: "Post",
            icon: "assets/icons/plus.svg",
            event: event);
}

class NavigationEvent extends NavigationState {
  NavigationEvent({String? event})
      : super(
            index: 3,
            title: "Event",
            icon: "assets/icons/events.svg",
            event: event);
}

class NavigationProfile extends NavigationState {
  NavigationProfile()
      : super(index: 4, title: "Profile", icon: "assets/icons/user.svg");
}
