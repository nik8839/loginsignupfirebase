import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/component/chatbubble.dart';
import 'package:login_signup_firebase/service/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmailId;
  final String receiveruid;


  const ChatPage({super.key ,required this.receiverEmailId,required this.receiveruid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController=TextEditingController();
  final ChatService _chatService=ChatService();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(
      widget.receiveruid,_messageController.text);
      _messageController.clear();


  }

}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(title: Text(widget.receiverEmailId),),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()
          ,),
          _buildMessageInput(),],
      ),
    );
  }
  Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getmessage(widget.receiveruid, _firebaseAuth.currentUser!.uid), builder:
    (context,snapshot){
      if(snapshot.hasError)
        {
          return Text('Error${snapshot.error}');
        }
      if(snapshot.connectionState==ConnectionState.waiting)
        {
          return const Text('Loading....');
        }
      return ListView(
        children:snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList() ,

      );
    });
  }
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic>data=document.data()as Map<String,dynamic>;
    var alignment=(data['senderId']==_firebaseAuth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          SizedBox(height: 5,),
          ChatBubble(message: data['message']),
        ],
      ),
    );

  }
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(

        children: [
          Expanded(child: TextField(
            // decoration: ,
              controller:_messageController,

               //decoration: InputDecoration(fillColor: Colors.blue),
             //  style: TextStyle(color: Colors.black),
              //hintext:'Enter Message',

              obscureText:false,


            )),
        //  ),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward,size: 40,),),
        ],
      ),
    );

  }
}
