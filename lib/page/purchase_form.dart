import './user.dart'

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePage();
}

/*class _PurchasePage extends State<PurchasePage> {
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  int _currentlevel = 0;
  int _currentxp = 0;
  int _currentpoints = 0;
  String? _currentUrl;

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<Userdetails>(
        stream: DatabaseService(uid: user.uid).userInfo,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    Userdetails? userinfo = snapshot.data;
}