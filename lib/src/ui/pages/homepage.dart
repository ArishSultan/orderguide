import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/backup.dart';
import 'package:orderguide/src/service/backup-service.dart';
import 'package:orderguide/src/ui/pages/distributors/distributors-list_page.dart';
import 'package:orderguide/src/ui/pages/generate_orders/generate-order_distributors.dart';
import 'package:orderguide/src/ui/pages/items/item-selection_page.dart';
import 'package:orderguide/src/ui/widgets/confirmation.dart';
import 'package:orderguide/src/ui/widgets/home-tile.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
import 'package:orderguide/src/utils/auth-utils.dart';
import 'package:orderguide/src/utils/const.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../base/nav.dart';
import 'history/history_listing.dart';
import 'items/items-list_page.dart';
import 'package:provider/provider.dart';

class InventoryHomePage extends StatefulWidget {
  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    manageUserState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top + 50),
        child: Material(
          elevation: 10,
          child: Row(
            children: [
              IconButton(
                tooltip: 'Pull Backup',
                icon: Icon(CupertinoIcons.arrow_down_circle_fill),
                onPressed: () async {
                  return showConfirmation(
                    context,
                    onConfirmed: () async {
                      await performLazyTask(context, () async {
                        await AppDB().pullBackup();
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Backup restored successfully!")));
                      });
                    },
                  );
                },
              ),
              IconButton(
                tooltip: 'Push Backup',
                icon: Icon(CupertinoIcons.cloud_upload_fill),
                onPressed: () {
                  return showConfirmation(context, onConfirmed: () async {
                    await performLazyTask(context, () async {
                      await AppDB().pushBackup();
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Backup pushed successfully!")));
                    });
                  });
                },
              ),
              Spacer(),
              Align(
                alignment: Alignment(0, .6),
                child: Image.asset(
                  "assets/images/inventory.png",
                  scale: 2,
                ),
              ),
              Spacer(),
              IconButton(
                  tooltip: 'Sign out',
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  })
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleFutureBuilder(
              loadingBuilder: (context, _) => SizedBox(
                height: 18,
              ),
              future: BackupService().getLatestBackup(),
              builder: (context, Backup backup) {
                return Row(
                  children: [
                    Text("Latest Backup on Cloud: "),
                    Text(DateFormat('dd MMM y').format(backup.date.toDate())),
                  ],
                );
              },
            ),
            SimpleFutureBuilder(
              loadingBuilder: (context, _) => SizedBox(
                height: 15,
              ),
              future: SharedPreferences.getInstance(),
              builder: (context, SharedPreferences prefs) {
                DateTime date = prefs.getString('backupDate') != null
                    ? DateTime.tryParse(prefs.getString('backupDate'))
                    : null;
                return date == null
                    ? SizedBox()
                    : Row(
                        children: [
                          Text("Latest Backup on Phone: "),
                          Text(DateFormat('dd MMM y').format(date)),
                        ],
                      );
              },
            ),
            SizedBox(
              height: 10,
            ),
            HomeTile(
              image: ItemsIcon,
              title: 'Items',
              onTap: () => AppNavigation.to(context, ItemsList()),
            ),
            HomeTile(
              image: DistributorsIcon,
              title: 'Distributors',
              onTap: () => AppNavigation.to(context, DistributorsListPage()),
            ),
            HomeTile(
              image: OrdersIcon,
              title: 'Generate Order',
              onTap: () =>
                  AppNavigation.to(context, GenerateOrderDistributorsList()),
            ),
            HomeTile(
              image: CheckInIcon,
              title: 'Check In',
              onTap: () => AppNavigation.to(context, HistoryListing(false)),
            ),
            HomeTile(
              image: HistoryIcon,
              title: 'Order History',
              onTap: () => AppNavigation.to(context, HistoryListing(true)),
            ),
            HomeTile(
              image: HistoryIcon,
              title: 'Items History',
              onTap: () => AppNavigation.to(context, ItemSelectionPage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridView({String text, Function onTap, String imgPath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.red.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("assets/images/$imgPath"))),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.centerLeft,
                    tileMode: TileMode.mirror,
                    colors: [
                      Colors.red[900],
                      Colors.blue[900],
                    ]).createShader(bounds),
                child: Text(
                  text,
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
