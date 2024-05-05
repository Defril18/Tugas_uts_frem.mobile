import 'package:flutter/material.dart';

import 'model/model_data.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Switch List to Grid",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

//MaterialApp: Widget utama untuk aplikasi Flutter. Ini mengonfigurasi aplikasi 
//dengan beberapa opsi dan menyediakan navigasi untuk halaman-halaman.
class _MyAppState extends State<MyApp> {
  var status = 0;

  @override
  Widget build(BuildContext context) {
    //Scaffold: Mendefinisikan struktur dasar halaman aplikasi.
    return Scaffold(
      //AppBar: Menampilkan bar navigasi di bagian atas aplikasi
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Switch List to Grid"),
        actions: [
          //IconButton: Tombol ikon yang merespons ketika diklik.
          IconButton(
            icon: status == 0
                ? const Icon(
                    Icons.list,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.grid_view,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                status = status == 0 ? 1 : 0;
              });
            },
          ),
        ],
      ),
      body: status == 0
      //ListView.builder: Menampilkan daftar item dengan panjang yang dinamis.
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                //GestureDetector: Mendeteksi berbagai jenis interaksi 
                //pengguna, seperti ketukan, gesekan, atau tarikan.
                return GestureDetector(
                  onTap: () {
                    // Navigate to Deskripsi screen with the corresponding data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Deskripsi(data: data[index]),
                      ),
                    );
                  },
                  //Card: Mengatur tata letak dan penampilan bingkai konten. 
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.network(data[index]['image']),
                      title: Text(data[index]['title']),
                      subtitle: Text(data[index]['desc']),
                      trailing: const Icon(Icons.bookmark_border, color: Colors.red),
                    ),
                  ),
                );
              },
            )
            //GridView.builder: Menampilkan daftar item dalam tata letak grid. 
            //Ini membangun item secara dinamis berdasarkan indeksnya.
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(data[index]['image'], height: 160, fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      ListTile(
                        title: Text(data[index]['title']),
                        subtitle: Text(data[index]['desc']),
                        trailing: const Icon(Icons.bookmark_border, color: Colors.red),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class Deskripsi extends StatelessWidget {
  final Map<String, dynamic> data;

  const Deskripsi({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Image.network(
              data['image'],
              height: 200, // Adjust height as needed
              width: 200, // Adjust width as needed
              fit: BoxFit.cover, // Adjust image fit
            ),
            SizedBox(width: 20), // Add horizontal spacing between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display name
                  Text(
                    data['title'],
                    style: TextStyle(
                      fontSize: 24, // Adjust font size
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                  SizedBox(height: 10), // Add vertical spacing between name and description
                  // Display description
                  Text(
                    data['deskripsi'],
                    style: TextStyle(
                      fontSize: 16, // Adjust font size
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
