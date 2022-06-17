import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/dataprovider.dart';
import 'package:todo_app/model.dart';
import 'package:intl/intl.dart';
import 'saveDialog.dart';
const String boxname = "todo";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(dataAdapter());
  runApp(const MyApp());

 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.green),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    @override
  void initState() {
    // TODO: implement initState
    final data = Provider.of<DataProvider>(context, listen: false);
    data.display();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
   final String? timest=(DateFormat("yyyy-MM-dd").format(DateTime.now())+" "+DateFormat("hh:mm:ss a").format(DateTime.now())).toString();
 

    TextEditingController titlecontroller = TextEditingController();
    TextEditingController detailcontroller = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        child: Icon(
          Icons.add,
          size: media.height / 40,
        ),
        backgroundColor: Color.fromARGB(255, 146, 143, 133),
        onPressed: () {
       
          SaveDialog(context, media, titlecontroller, detailcontroller, timest);
        },
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
          begin: Alignment.topLeft,
          stops: [0.1, 0.9],
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 195, 241, 201),
            Color.fromARGB(255, 196, 187, 156)
          ],
        )),
        child: Column(
          children: [
            SizedBox(height: media.height / 34),
            Container(
                color: const Color.fromARGB(255, 161, 203, 161),
                padding: EdgeInsets.only(bottom: media.height / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: media.height/45,top: media.height/60),
                      child: Text(
                        "TASKY",
                        style: TextStyle(
                            fontFamily: 'DancingScript',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: media.height / 20),
                      ),
                    ),
                  
                    Padding(
                      padding:   EdgeInsets.only(left: media.height/45,top: media.height/60),
                      child: Row(
                        children: [
                            IconButton(onPressed: (){
                   SaveDialog(context, media, titlecontroller, detailcontroller, timest);
                      }, icon:const Icon(Icons.add)),
                          Consumer<DataProvider>(builder: (context, func, child) {
                           return  IconButton(
                                onPressed: () {
                                  showMenu<String>(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                        media.height / 20,
                                        media.height / 20,
                                        media.height / 50,
                                        media.height /
                                            50), //position where you want to show the menu on screen
                                    items:  [
                                      PopupMenuItem<String>(
                                          child: Text('All',style: TextStyle(fontWeight:FontWeight.bold,fontSize: media.height/40),), value: '1' ),
                                      PopupMenuItem<String>(
                                          child: Text('Completed',style: TextStyle(fontWeight:FontWeight.bold,fontSize: media.height/40),), value: '2'),
                                      PopupMenuItem<String>(
                                          child: Text('Incompleted',style: TextStyle(fontWeight:FontWeight.bold,fontSize: media.height/40),), value: '3'),
                                    ],
                                    
                                    elevation: 8.0,
                                  ).then((value) {
                                    if (value == '1') {
                                   func.display();
                                    }
                                    if (value == '2') {
                                    
                                      
                                       func.completed();
                                      
                                    }
                                    if (value == '3') {
                                    
                                      func.notcompleted();
                                      
                                    }
                                  });
                                },
                                  icon: Icon(Icons.menu));
        }),
                        ],
                      ),
                    )
                  ],
                )),
          SizedBox(height: media.height/30),
            Container(
            
               
                padding: EdgeInsets.only(bottom: media.height / 50),
                child: Text(
                  "YOUR TASKS",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontFamily: 'DancingScript',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: media.height / 25),
                ),),
          
            Consumer<DataProvider>(builder: (context, value, child) {
              return Flexible(
                child: ListView.builder(
                
                    itemCount: value.list.length,
                    itemBuilder: ((context, index1) {
                      int index=value.list.length-1-index1;
                      return Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
            gradient: const LinearGradient(
          begin: Alignment.topLeft,
          stops: [0.1, 0.9],
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 195, 241, 201),
            Color.fromARGB(255, 196, 187, 156)
          ],
        )),
                          child: ListTile(
                            minVerticalPadding: media.height/17,
                            
                            leading: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                    
                              children: [
                                Text(value.list[index]!.title.toString(),style: 
                                                        TextStyle(fontSize: media.width/20,fontWeight: FontWeight.bold),),
                                                  Text(value.list[index]!.detail,style: 
                                                        TextStyle(fontSize: media.width/24,color: Colors.grey,fontWeight: FontWeight.bold),),
                          
                              
                       
                              
                                Text(value.list.isEmpty==false?value.list[index]!.timestamp.toString():" ",style: 
                                                        TextStyle(fontSize: media.width/40,fontWeight: FontWeight.bold)
                                )
                                                     
                              ]
                              
                            ),
                            
               
                                                    trailing: 
                                                    IconButton(
                              icon: Row(
                                children: [Icon(                   
                    Icons.done,color: value.list[index]!.iscompleted==false? Colors.red:Colors.green,),
                                  Expanded(
                                    child: Icon(
                                      Icons.more_vert,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                if(value.disable==false){
                                showModalBottomSheet(shape: 
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(media.width/40)),
                                    context: context,
                                  
                                    builder: (context) {
                                       return Container(
                                      height: media.height/3,
                                         child:
                                      
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:  EdgeInsets.only(left: media.width/20,top: media.height/45),
                                                          child: Text(value.list[index]!.title,style: 
                                                          TextStyle(fontSize: media.width/18),),
                                                        ),
                                                      Divider(),
                                                      TextButton(onPressed: () {
                                                         value.delete(index);
                                                        Navigator.pop(context);
                                                      },
                                                          child: Row(children: [
                                                                                                        Icon( Icons.delete),
                                                                                                      
                                                                                                       Text("Delete",style: TextStyle(fontSize:  media.width/20),)
                                                                                                      ],)),
                                                        
                                               
                                                   TextButton(onPressed: () {
                                                   
                                                       SaveDialog(context, media, titlecontroller, detailcontroller, timest,a: index);
                                                       
                                                    
                                                   },
                                                       child: Row(children: [
                                                                                                    Icon(Icons.edit),
                                                                                                    Text("Edit",style: TextStyle(fontSize:  media.width/20),)
                                                                                                   ],),
                                                   ),
                                                  
                                                      TextButton(onPressed: () {
                                                  if (value.disable==false){
                                                    value.markComplete(index);
                                                  }
                                                   
                                                       Navigator.pop(context);
                                                      
                                                   },
                                                       child: Row(children: [
                                                                                                    Icon(Icons.done_rounded,color: value.disable==true?Colors.grey:Colors.green),
                                                                                                    Text("Mark as done",style: TextStyle(fontSize:  media.width/20,color: value.disable==true?Colors.grey:Colors.green),)
                                                                                                   ],),
                                                   ),
                                                      
                                                      ],
                                                  ),
                                                
                                                      
                                       );
                                       
                                    });
                            
                                 }if(value.disable==true){
                                   const snackBar = SnackBar(
   content: Text('Go to all options for opertions!'),
 );
 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                                
                                  },
                            ),
                                                    
                          ),
                        ),
                      );
                    })),
              );
            }),
          ],
        ),
      ),
    );
  }

 }
