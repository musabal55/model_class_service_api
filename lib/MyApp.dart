import 'package:flutter/material.dart';
import 'UsersClass.dart';
import 'UsersServices.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DetailPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late List<User>? _users;
  late bool? _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    _users = []; // LateInitializationError hatası vermemesi için
    UsersService().getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Model Class Veri Çekme Demo"),
      ),
      body: Container(
        color: Colors.white,
        child: _users!.isNotEmpty
            ? ListView.builder(
                itemCount: null == _users ? 0 : _users!.length,
                itemBuilder: (context, index) {
                  User user = _users![index];
                  return ListTile(
                    title: Text(user.name.toString()),
                    subtitle: Text(user.email.toString()),
                    trailing: Text(user.username.toString()),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        UsersService().getUsers().then((users) {
          setState(() {
            _users = users;
            _loading = false;
          });
        });
      },
      backgroundColor: Colors.orange,
      child: Icon(Icons.refresh_outlined,size: 36,),
      ),
    );
  }
}
