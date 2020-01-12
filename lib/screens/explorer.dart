import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/file_opener.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/explorer_list_file.dart';
import 'package:for_a_real_angel/visual_objects/explorer_list_folder.dart';
import 'package:for_a_real_angel/visual_objects/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Explorer extends StatefulWidget {
  MFolder folder;
  List<MFolder> roots = [];
  Explorer({@required this.folder});

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  int idChapter;
  @override
  void initState() {
    _readChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: getMenuBar(
        context: context,
        title: widget.folder.title,
        icon: IconsValues.directory,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(5),
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
              ((widget.roots != null) && (widget.roots.length > 0))
                  ? GestureDetector(
                      onTap: () {
                        MFolder pai = widget.roots.removeLast();
                        setState(() {
                          widget.folder = pai;
                        });
                      },
                      child: ExplorerListFolder(
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
                          routerFileType(arquivo, context);
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
    final key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        this.idChapter = value;
      });
    } else {
      setState(() {
        this.idChapter = 1;
      });
    }
  }
}
