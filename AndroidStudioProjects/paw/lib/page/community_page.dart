import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/communitywrapper.dart';
import 'package:timer/page/services/auth.dart';
import 'package:timer/page/wrapper.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: const CommunityWrapper(),
      ),
    );
  }
}
