// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/file_opener.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/explorer_list_file.dart';
import 'package:for_a_real_angel/partials/explorer_list_folder.dart';
import 'package:for_a_real_angel/partials/get_app_bar.dart';
import 'package:for_a_real_angel/values/sounds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Explorer extends StatefulWidget {
  MFolder folder;
  List<MFolder> roots = [];
  Explorer({Key? key, required this.folder}) : super(key: key);

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  int idChapter = 1;

  @override
  void initState() {
    _readChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: widget.folder.title,
        icon: IconsValues.directory,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(5),
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: MyColors.topBlue,
            width: 7,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ((widget.roots.isNotEmpty))
                  ? GestureDetector(
                      onTap: () {
                        MFolder pai = widget.roots.removeLast();
                        setState(() {
                          widget.folder = pai;
                        });
                        context.read<SoundPlayer>().playSFX(Sounds.idFolder);
                      },
                      child: const ExplorerListFolder(
                        folder: MFolder(
                            chapter: 0,
                            title: "...",
                            listFiles: [],
                            listFolders: []),
                      ),
                    )
                  : Container(),
              for (var pasta in widget.folder.listFolders)
                (pasta.chapter <= idChapter)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.roots.add(widget.folder);
                            widget.folder = pasta;
                          });
                          context.read<SoundPlayer>().playSFX(Sounds.idFolder);
                        },
                        child: ExplorerListFolder(
                          folder: pasta,
                        ),
                      )
                    : Container(),
              for (var arquivo in widget.folder.listFiles)
                (arquivo.chapter <= idChapter)
                    ? GestureDetector(
                        onTap: () {
                          openFile(
                            file: arquivo,
                            context: context,
                          );
                          context.read<SoundPlayer>().playSFX(Sounds.idClick);
                        },
                        child: ExplorerListFile(
                          file: arquivo,
                        ),
                      )
                    : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future _readChapter() async {
    final prefs = await SharedPreferences.getInstance();
    const key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        idChapter = value;
      });
    } else {
      setState(() {
        idChapter = 1;
      });
    }
  }
}
