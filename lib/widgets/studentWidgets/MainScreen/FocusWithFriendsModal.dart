import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:study_buddy/providers/studentProviders/FocusProvider.dart';
import 'package:study_buddy/widgets/designs/Button.dart';

import '../../../app_localizations.dart';

class FocusWithFriendsModal extends StatefulWidget {
  const FocusWithFriendsModal({
    Key key,
  }) : super(key: key);

  @override
  _FocusWithFriendsModalState createState() => _FocusWithFriendsModalState();
}

class _FocusWithFriendsModalState extends State<FocusWithFriendsModal> {
  ModelModes mode;
  final joinIdController = TextEditingController();

  @override
  void initState() {
    FocusProvider focusProvider =
        Provider.of<FocusProvider>(context, listen: false);
    if (focusProvider.sessionId != null) {
      mode = focusProvider.isAdmin ? ModelModes.create : ModelModes.join;
    } else {
      mode = ModelModes.choose;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    return SafeArea(
      child: LayoutBuilder(builder: (ctx, constraints) {
        if (mode == ModelModes.choose) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t("Focus With Friends"),
                  style: Theme.of(context).textTheme.headline4,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button(
                        onPressed: () {
                          setState(() {
                            mode = ModelModes.create;
                            focusProvider.createSession(context);
                          });
                        },
                        child: Text("Create a session")),
                    Button(
                        onPressed: () {
                          setState(() {
                            mode = ModelModes.join;
                          });
                        },
                        child: Text(t("Join a session")))
                  ],
                ),
              ],
            ),
          );
        }
        if (mode == ModelModes.create) {
          return focusProvider.sessionId == null
              ? Center(child: Container( height:constraints.maxHeight *0.5, width:constraints.maxHeight *0.5,child: CircularProgressIndicator(strokeWidth: 7,)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Text(
                          t("Your session id:"),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(focusProvider.sessionId),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Button(
                          onPressed: () {
                            Share.share(
                                focusProvider.sessionId);
                          },
                          icon: Icon(Icons.share),
                          child: Text(
                            t("Share"),
                          ),
                        ),
                        Button(
                          onPressed: () {
                            focusProvider.leaveSession();
                            setState(() {
                              mode = ModelModes.choose;
                            });
                          },
                          child: Text(t("Cancel session")),
                          black: true,
                        )
                      ],
                    ),
                  ],
                );
        }
        // join mode:
        return 
          Column(
            mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(t("Enter session id:")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.5,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: TextField(
                          key: ValueKey('sessionId'),
                          controller: joinIdController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: t('Session ID'),
                          ),
                        ),
                      ),
                    ),
                    focusProvider.sessionId!=null ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.check_circle, color: Colors.green,),
                    ) : Container(),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Button(onPressed: (){
                  print(joinIdController.text);
                  focusProvider.joinSession(joinIdController.text, context);
                }, child: Text(t("Join session"))),
                Button(onPressed: (){
                  focusProvider.leaveSession();
                  setState(() {
                    mode = ModelModes.choose;
                  });
                }, child: Text(t("Back")), black: true,)
              ],
            )
          ],
        );
      }),
    );
  }
  @override
  void dispose() {
    joinIdController.dispose();
    super.dispose();
  }
}

enum ModelModes { choose, create, join }
