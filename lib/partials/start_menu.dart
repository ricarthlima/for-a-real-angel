import 'package:flutter/material.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import '../helper/laucher_url.dart';

showStartMenu(BuildContext context) {
  List<StartMenuItemLink> listLinks = getStartMenuItemLinks(context);
  showDialog(
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return Dialog(
        shape: Border.all(color: MyColors.topBlue, width: 10),
        elevation: 0,
        backgroundColor: MyColors.windowsGrey,
        child: Container(
          height: size.height / 2,
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              for (StartMenuItemLink item in listLinks)
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          launchURL(context, item.link);
                        },
                        leading: Image.asset(
                          item.icon,
                          width: 40,
                          height: 40,
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
    },
  );
}

List<StartMenuItemLink> getStartMenuItemLinks(BuildContext context) {
  return [
    StartMenuItemLink(
        icon: IconsValues.reddit,
        title: "${AppLocalizations.of(context)!.visitOur} Reddit",
        link: "https://www.reddit.com/r/FaraRiddles/"),
    StartMenuItemLink(
        icon: IconsValues.twitter,
        title: "${AppLocalizations.of(context)!.visitOur} Twitter",
        link: "https://twitter.com/ricarthlima"),
    StartMenuItemLink(
        icon: IconsValues.instagram,
        title: "${AppLocalizations.of(context)!.visitOur} Instagram",
        link: "https://www.instagram.com/ricarthlima"),
    StartMenuItemLink(
        icon: IconsValues.code,
        title: AppLocalizations.of(context)!.madeWith,
        link: "http://www.ricarth.me/"),
  ];
}

class StartMenuItemLink {
  String icon;
  String title;
  String link;

  StartMenuItemLink(
      {required this.icon, required this.title, required this.link});
}
