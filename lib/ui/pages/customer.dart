import 'package:flutter/material.dart';

class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고객센터'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '고객센터',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('문의 사항이 있으시면 아래 이메일로 연락 주세요.'),
            Text(
              'support@example.com',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('전화 문의: 123-456-7890'),
          ],
        ),
      ),
    );
  }
}
