import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel with ChangeNotifier{
  int _count = 0;
  int get value => _count;


  void increment(){
    _count++;
    notifyListeners();
  }
  void zero(){
    _count = 0;
    notifyListeners();
  }
}

class NameModel with ChangeNotifier{
  String _name = 'name1';
  String get value => _name;


  void replacename(String replacetarget){
    _name = replacetarget;
    notifyListeners();
  }
}

void main(){
  final counter = CounterModel();
  final name1 = NameModel();
  final textsize = 48;

  runApp(
    Provider<int>.value(
      value: textsize,
      child:  ChangeNotifierProvider.value(
        value: counter,
        child: ChangeNotifierProvider.value(
            value: name1,
            child: Myapp(),
        ),
      ),
    ),
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Mycpp1(),
    );
  }
}


class Mycpp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final _name = Provider.of<NameModel>(context);
    final textsize = Provider.of<int>(context).toDouble();
    return Scaffold(
      appBar: AppBar(
        title: Text('firstscreen'),
      ),
      body: Column(children: <Widget>[
        Text('Value:${_counter.value}',
          style: TextStyle(fontSize: textsize),
        ),
        Text('NameVal:${_name.value}',
          style: TextStyle(fontSize: 20),
        ),
        Text('aa'),
        IconButton(icon: Icon(Icons.exposure_zero),
        onPressed: (){
          _counter.zero();
        },color: Colors.blue,)
      ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage())),
          child: Icon(Icons.chevron_right),
      ),
    );
  }
}



class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2'),
      ),
      body: Container(child: Column(children: <Widget>[
        Consumer2<CounterModel,int>(
            builder: (context,CounterModel counter ,int textsize, _) =>
              Center(
                child:  Text('Value : ${counter.value}',style: TextStyle(fontSize: textsize.toDouble()),),
              ),),
        Consumer<NameModel>(
          builder: (context,NameModel name,child)=>Text('NameValue : ${name.value}',style: TextStyle(fontSize: 20),),
        ),
        Text('provider'),
        Row(children: <Widget>[
          Consumer<NameModel>(
              builder: (context, NameModel name,child) => RaisedButton(
                onPressed: (){
                  name.replacename('aaa');
                },
                child: child,
              ),child: Text('aaa'),),
          Consumer<NameModel>(
            builder: (context, NameModel name,child) => RaisedButton(
              onPressed: (){
                name.replacename('bbb');
              },
              child: child,
            ),child: Text('bbb'),),
          Consumer<NameModel>(
            builder: (context, NameModel name,child) => RaisedButton(
              onPressed: (){
                name.replacename('ccc');
              },
              child: child,
            ),child: Text('ccc'),),
          Consumer<NameModel>(
            builder: (context, NameModel name,child) => RaisedButton(
              onPressed: (){
                name.replacename('ddd');
              },
              child: child,
            ),child: Text('ddd'),),
        ],),
//        Consumer<CounterModel>(
//          builder: (context, CounterModel counter, child) => FloatingActionButton(
//            onPressed: (){
//              counter._count = counter._count-1;
//            },
//            child: child,
//          ),
//          child: Icon(Icons.add),
//        ),
        Consumer<CounterModel>(
            builder: (context, CounterModel counter, child) => RaisedButton(
              onPressed: counter.zero,
              child: child,
            ),
          child: Icon(Icons.exposure_zero),
          )
      ],),),

      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}


