import 'package:flutter/material.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 게시글 관리'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.image),
              title: const Text('게시글 제목 1'),
              subtitle: const Text('이것은 게시글의 내용입니다.'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // 게시글 삭제 로직
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
