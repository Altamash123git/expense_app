import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class example extends StatefulWidget {
  const example({super.key});

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  List<expenseModel> mdata=[];
  @override
  Widget build(BuildContext context) {
    context.read<expensebloc>().add(getExpenseEvt());
    return Scaffold(
      body: BlocBuilder<expensebloc,expensestate>(builder: (_,state){
        if(state is loading_state){
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if(state is loaded_state){
          mdata= state.mdata;
          print(mdata);
          return mdata.isNotEmpty? Container(
            //color: Colors.green,
            child: ListView.builder(
                itemCount: state.mdata.length,
                itemBuilder: (c,i){return ListTile(

              title: Text(state.mdata[i].expense_desc),
                  subtitle: Text("HULELELE",style: TextStyle(fontSize: 50,color: Colors.blue),),
                  leading:Text("HULELELE",style: TextStyle(fontSize: 50,color: Colors.blue),),
            );}),

          ):Center(
            child: Container(
              child: Text("I am empty"),
            ),
          );
        }if(state is errorstate){
          return Container(
            child: Text(state.error_msg),
          );
        }
        return Container(
          child: Text("hule lele"),
        );
      }),
    );
  }
}
/*class home extends StatelessWidget {

  List<notesModel> allnotes=[];

  @override
  Widget build(BuildContext context) {

     context.read<blockexecuter>().add(initialnotes());
    return Scaffold(
      appBar: AppBar(title: Text("HOME"),),
      body:
     BlocBuilder<blockexecuter,DBMainState>(builder: (_,state){
       if(state is DBMainLoadingState){
         return  Center(
           child: CircularProgressIndicator(),
         );
       }
       if(state is DBMainErrorState){
         return Center(
           child: Text('Error: ${state.errorMsg}'),
         );
       }
       if (state is DBMainLoadedState) {
         allnotes = state.mData;
         return allnotes.isNotEmpty ? ListView.builder(
             itemCount: allnotes.length,
             itemBuilder: (c,index){

               //final notes= state.mdata[index];
               return ListTile(

                 title: Text(state.mData[index].title),
                 subtitle: Text(allnotes[index].desc),
                 trailing: Container(
                   width: 100,
                   //height: ,
                   child: Row(
                     children: [
                       IconButton(onPressed: (){
                         //context.read<blockexecuter>().add(updatenotes(id: allnotes[index][DBhelper.Column_note_id], title:"hlo ni hota, helo hota h ", desc:  allnotes[index][DBhelper.Column_note_desc]));
                         Navigator.push(context, MaterialPageRoute(builder: (c)=>add_update_bloc(isupdate: true,title:allnotes[index].title, desc: allnotes[index].desc ,id:allnotes[index].id! )));
                       }, icon: Icon(Icons.edit,color: Colors.green,)),
                       SizedBox(
                         width: 3,
                       ),
                       IconButton(onPressed: (){
                         context.read<blockexecuter>().add(deletenotes(id: allnotes[index].id!));

                       }, icon: Icon(Icons.delete,color: Colors.red,))

                     ],
                   ),
                 ),

               );
             }): Container(
             alignment: Alignment.center,
             child:  Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("No notes yet"),
                 Text(allnotes.length.toString()),
                 SizedBox(height: 15,),
                 ElevatedButton(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c)=>add_update_bloc()));
                 }, child: Text("Add Notes"))
               ],
             )

         ) ;};

       return Container();
     }),

     /* floatingActionButton: BlocBuilder<blockexecuter, DBMainState>(
        builder: (_, state) {
          if (state is DBMainLoadedState) {
            if (state.mData.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => add_update_bloc(),
                      ));
                  *//*showModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (_) {
                      return getBottomSheetUI();
                    });*//*
                },
                child: Icon(Icons.add),
              );
            } else {
              return Container();
            }
          }

          return Container();
        },
      ),*/
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.read<blockexecuter>().add(addnotes(

          title: "hlo",
          desc:"ejaz",));
        print("$allnotes is this");
        //print(DBhelper.Column_note_desc.);
        //Navigator.push(context,MaterialPageRoute(builder: (c)=>update_add()));
        //Navigator.push(context, MaterialPageRoute(builder: (c)=>add_update_bloc()));

      },child: Icon(Icons.add),) ,


    );
  }



  }*/