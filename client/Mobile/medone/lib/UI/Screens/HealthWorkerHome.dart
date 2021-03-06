import 'package:flutter/cupertino.dart';
import '../../Utils/Others/customLib.dart';


class HealthWorkerHome extends StatefulWidget {
  static const route = "/HealthWorker-home";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // throw UnimplementedError();
    return HealthWorkerHomeState();
  }
}

class HealthWorkerHomeState extends State {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String url = ApiUrl.url;

  //socket

  // SocketIO socketIO;

  // lOCAL pUSH NOTIFICATION

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  //socket

  List<String> messages;
  TextEditingController textController;
  ScrollController scrollController;

  @override
  void initState() {

    // socketIO = SocketIOManager().createSocketIO(
    //   url,
    //   '/',
    // );

    // socketIO.init();

    // socketIO.subscribe('receive_message', (jsonData) {
    //   //Convert the JSON data received into a Map
    //   Map<String, dynamic> data = json.decode(jsonData);
    //   print("Data From socket");
    //   print(data);
    // });

    // socketIO.subscribe("socket_info", _onSocketInfo);

    // socketIO.connect();

    super.initState();
    // initializing();
  }

  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }


  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    var userInfo = routeArgs['userInfo'];
    String token = routeArgs['token'];

    print('Token in Home');

    print(token);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: Text(
          "MedOne",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // _showNotificationsAfterSecond(DateTime.daysPerWeek);

              Navigator.pushNamed(context, NotificationsToNurse.route);
            },
            child: Stack(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.notifications,
                    color: Theme.of(context).accentColor,
                    size: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue),
                    child: Text("4",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: AlignmentDirectional.center,
        child: GridView.count(
          childAspectRatio: 1.2,
          children: <Widget>[
            featureOptions(context, "Patient List", PatientsList.route,
                "assets/images/hospitalisation.png", token),
            featureOptions(context, "Nurses", NursesList.route,
                "assets/images/nurse.png", token),
            featureOptions(context, "Doctors", DoctorsList.route,
                "assets/images/doctor.png", token),
            featureOptions(context, "Chat", ChatPage.route,
                "assets/images/chat.png", token),
          ],
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: ScrollPhysics(),
        ),
      ),
      drawer: CustomDrawer(userInfo["name"], userInfo["role"], "hash", "http"),
    );
  }
}
