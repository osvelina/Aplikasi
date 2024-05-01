import 'package:flutter/material.dart';

class Area {
  final String name;
  final String imageUrl;
  final String daerah;

  Area({
    required this.name,
    required this.imageUrl,
    required this.daerah,
  });
}

class AreaList extends StatelessWidget {
  final List<Area> areas = [
    Area(name: 'Daeng Barbershop Balige', imageUrl: 'assets/balige.jpeg', daerah:'Balige'),
    Area(name: 'Daeng Barbershop Parapat', imageUrl: 'assets/parapat.jpg', daerah:'Parapat'), 
    Area(name: 'Daeng Barbershop Sidikalang', imageUrl: 'assets/sidikalang.jpg', daerah:'Sidikalang'),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Daerah Barbershop',
        style: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 23,

        ),),
      ),
      
      
      body: ListView.builder(

        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          return InkWell(
            onTap: () {
              // Handle onTap event
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      area.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          area.name,
                          style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              area.daerah,
                              style: TextStyle(
                                fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AreaList(),
  ));
}
