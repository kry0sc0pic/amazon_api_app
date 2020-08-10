import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'API.dart';
import 'dart:convert';


//amazon product: https://www.amazon.com/Apple-MacBook-13-inch-256GB-Storage/dp/B0863D4XJW

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String product_url;
  String name;
  String img_url;
  String price;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Amazon API App"),),
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value){
                      product_url = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Amazon Product URL..."
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Query API"),
                  onPressed: () async{
                    //TODO Get data from amazon api
                    print("http://192.168.0.131:9200/api/amazon?url=$product_url");
                    var data = await getData("http://192.168.0.131:9200/api/amazon?url=$product_url");
                    var decoded_data = jsonDecode(data);
                    setState(() {
                      name = decoded_data["name"];
                      price = decoded_data["price"].toString();
                      img_url = decoded_data["image_link"];
                    });
                    print(name);
                    print(price);
                    print(img_url);
                    },
                ),
                Text(name == null?"No name..":name),
                Text(price == null?"No price..":price),
                Image.network(img_url == null?"https://image.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-260nw-1037719192.jpg":img_url)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
