import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับคอมพิวเตอร์"),
      ),
      body: Padding(
        //wrap ด้วย padding เพื่อให้ Container มีระยะห่างจากขอบจอ
        padding: const EdgeInsets.all(20),
        child: FutureBuilder( builder: (context, snapshot) {//EP9
            var data = json.decode(snapshot.data.toString());//[{คอมพิวเตอร์คืออะไร},{},{}]
            return ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return MyBox(data[index]['title'], data[index]['subtitle'], data[index]['image_url'],data[index]['detail']);

              },
              itemCount: data.length,);


        },
        future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
        //ผลลัพธ์ที่ได้จะเอาข้อมูลใน json มาแสดง เหมือน copy มาวางเลย (อย่าลืมไป set asset ใน pubspec ด้วย)

        )
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    //"String title" คือการที่จะทำให้กล่อง MyBox ที่สร้างขึ้นมาแสดงผลต่างกัน
    var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding:
          EdgeInsets.all(20), //กำหนดระยะขอบของกล่องข้อความในกล่อง Container
      // color: Colors.blue[50],
      height: 150,
      decoration: BoxDecoration(
          //การตกแต่งกล่องที่อยู่ Container
          // color: Colors.blue[50],
          borderRadius:
              BorderRadius.circular(20), //ทำให้กล่องที่อยู่ Container มีขอบมน
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover, //ทำให้รูปพื้นหลังของกล่องมีขนาดพอดีกับกล่อง
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.50),
                  BlendMode.darken) //ปรับโทนสีภาพพื้นหลัง
              )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .start, //ตำแหน่งข้อความในกล่องที่อยู่ Container ขอบขน กลาง ล่าง
        crossAxisAlignment: CrossAxisAlignment
            .start, //ตำแหน่งข้อความในกล่องที่อยู่ Container ขอบซ้าย กลาง ขวา
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height:
                  10), //กำหนดระยะห่างของกล่องข้อความในกล่องที่อยู่ใน Container
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 18),
          TextButton(
              onPressed: () {
                //ติดตั้งปุ่มกดในกล่อง เพื่อให้กดแล้ว link ไปอีกหน้า
                print("Next Page>>>");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPage(v1,v2,v3,v4)));//สร้างให้กดปุ่มแล้ว link ไปอีกหน้า
                
              },
              child: Text("Read more...",style: TextStyle(color: Colors.yellow),))
        ],
      ),
    );
  }
}
