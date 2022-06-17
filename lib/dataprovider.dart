import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/main.dart';
import './model.dart';
import 'package:hive/hive.dart';
class DataProvider extends  ChangeNotifier{
List<data?> list=[];
bool disable=false;


void ad(data value) async{
  LazyBox<data> todobox=await Hive.openLazyBox(boxname);

todobox.add(value);

list.add(value);
notifyListeners();

}
void display()async{
  disable=false;
  
   LazyBox<data> todobox=await Hive.openLazyBox(boxname);
Iterable<int> b=todobox.keys.cast<int>(); 
  //List<int>
  if(list.isNotEmpty){
    list.clear();
  }
  
  b.forEach((element)  async{
    data? a=await todobox.get(element);
    list.add(a);
    notifyListeners();
  },);


}
void delete(int key)async{
  LazyBox<data> todobox=await Hive.openLazyBox(boxname);
  
  todobox.deleteAt(key);
  list.removeAt(key);
  notifyListeners();
}
void ed(int key,data d)async{
 
  delete(key);
  ad(d);
  notifyListeners();
}
void markComplete(int key)async{
  LazyBox<data> todobox=await Hive.openLazyBox(boxname);
 final String? timest=(DateFormat("yyyy-MM-dd").format(DateTime.now())+" "+DateFormat("hh:mm:ss a").format(DateTime.now())).toString();
 
  data? a= list.elementAt(key);
  data? b=data(detail: a!.detail.toString(),title: a.title.toString(),iscompleted: true,timestamp: timest);
  todobox.putAt(key, b);
  list.removeAt(key);
  list.add(b);
  notifyListeners();

}

void completed()async{

  disable=true;
   LazyBox<data> todobox=await Hive.openLazyBox(boxname);
Iterable<int> b=todobox.keys.cast<int>();
if(list.length==1 && list.first!.iscompleted==false  ){
  list.clear();
  notifyListeners();
}

else{
if(list.isNotEmpty){
  list.clear();
}
  
  

     
  b.forEach((element)  async{
    if(element==list.length){
      list.clear();
    }
    data? a=await todobox.get(element);
 
    if(a!.iscompleted==true){
      
      list.add(a); notifyListeners();}
      
    });
  // List<data?> c=list.where((element) => element!.iscompleted==true).toList();


} 

  
 // list.addAll(c);

 
  
  
  

}
void notcompleted()async{
  
  disable=true;

if(list.length==1  && list.first!.iscompleted==false  ){
  list.clear();
  notifyListeners();
}


 else{
      if(list.isNotEmpty){
    list.clear();
  }
    

     LazyBox<data> todobox=await Hive.openLazyBox(boxname);
Iterable<int> b=todobox.keys.cast<int>(); 
  b.forEach((element)  async{
    
    data? a=await todobox.get(element);
    if(a!.iscompleted==false){list.add(a); notifyListeners();
    }
    
   
      
    
    });

 }
    
    
  
    



}
}