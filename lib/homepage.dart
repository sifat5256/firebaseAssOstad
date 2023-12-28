import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Student> listofstudent = [];

  Future<void> getstat() async {
    final QuerySnapshot result =
        await firebaseFirestore.collection('football').get();
    print(result.size);
    for (QueryDocumentSnapshot element in result.docs) {
      Student student = Student(
        teamA: element.get('TeamA') ?? 0,
        teamB: element.get('TeamB') ?? 0,
        goala: int.tryParse(element.get('goala').toString()) ?? 0,
        goalb: int.tryParse(element.get('goalb').toString()) ?? 0,
        time: int.tryParse(element.get('time').toString()) ?? 0,
        totaltime: int.tryParse(element.get('totaltime').toString()) ?? 0,
      );

      listofstudent.add(student);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getstat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase"),
      ),
      body: ListView.builder(
          itemCount: listofstudent.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listofstudent[index].teamA +
                  ' vs' +
                  listofstudent[index].teamB),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Nextpage(
                    teama: listofstudent[index].teamA,
                    teamb: listofstudent[index].teamB,
                    goala: listofstudent[index].goala,
                    goalb: listofstudent[index].goalb,
                    time: listofstudent[index].time, 
                    totaltime: listofstudent[index].totaltime,
                  );
                }));
              },
            );
          }),
    );
  }
}

class Student {
  String teamA;
  String teamB;
  int goala;
  int goalb;
  int time;
  int totaltime;

  Student(
      {required this.teamA,
      required this.teamB,
      required this.goala,
      required this.goalb,
      required this.time,
      required this.totaltime});
}

class Nextpage extends StatelessWidget {
  Nextpage(
      {super.key,
      required this.teama,
      required this.teamb,
      required this.goala,
      required this.goalb,
      required this.time,
      required this.totaltime});

  final String teama;
  final String teamb;
  int goala;
  int goalb;
  int time;
  int totaltime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teama + ' vs' + teamb),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
       // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(teama + ' vs' + teamb),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(goala.toString(),),
              Text(":"),
              Text(goalb.toString())
            ],
          ),
          Text('time '+time.toString()),
          Text('fulltime '+totaltime.toString())
        ],
      ),
    );
  }
}
