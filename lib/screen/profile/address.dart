import 'package:flutter/material.dart';


class DeliveryAddressScreen extends StatefulWidget {
  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  String _selectedAddress = "office";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                           decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 20, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Delivery address',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
            _buildAddressCard(
              icon: Icons.apartment,
              title: "My Office",
              address: "SBI Building, street 3, Software Park",
              value: "office",
            ),
            SizedBox(height: 16),
            _buildAddressCard(
              icon: Icons.home,
              title: "My Home",
              address: "SBI Building, street 3, Software Park",
              value: "home",
            ),
           SizedBox(height: 170,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: Text("Add new address", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required IconData icon,
    required String title,
    required String address,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddress = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedAddress == value ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Column(
         
          children: [
            
            Row(
              children: [
                Radio(
                  value: value,
                  groupValue: _selectedAddress,
                  onChanged: (val) {
                    setState(() {
                      _selectedAddress = val!;
                    });
                  },
                ),
                Icon(icon, size: 30),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SEND TO", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(height: 4),
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                     
                    ],
                  ),
                ),
               
                TextButton(
                  onPressed: () {},
                  child: Text("Edit", style: TextStyle(color: Colors.red)),
                ),
                 
              ],
            ),
             Text(address, style: TextStyle(fontSize: 17, color: Colors.grey)),
          ],
        ),

      ),
    );
  }
}
