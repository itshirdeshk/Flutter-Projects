import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset('assets/RiveAssets/icons.riv',
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  RiveAsset('assets/RiveAssets/icons.riv',
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAsset('assets/RiveAssets/icons.riv',
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Chat"),
  RiveAsset('assets/RiveAssets/icons.riv',
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notification"),
  RiveAsset('assets/RiveAssets/icons.riv',
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];

List<RiveAsset> sideMenus = [
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "Home", artboard: "HOME", stateMachineName: "HOME_interactivity"),
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "Search",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity"),
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "Favorites",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity"),
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "Help", artboard: "CHAT", stateMachineName: "CHAT_Interactivity"),
];

List<RiveAsset> sideMenus2 = [
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "History",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity"),
  RiveAsset("assets/RiveAssets/icons.riv",
      title: "Notifications",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity"),
];
