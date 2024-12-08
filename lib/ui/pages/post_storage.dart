import 'package:flutter/material.dart';

class PostStoragePage extends StatefulWidget {
  const PostStoragePage({Key? key}) : super(key: key);

  @override
  _PostStoragePageState createState() => _PostStoragePageState();
}

class _PostStoragePageState extends State<PostStoragePage> {
  final List<String> _storedPosts = ['게시글 예시 1', '게시글 예시 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 보관함'),
      ),
      body: ListView.builder(
        itemCount: _storedPosts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_storedPosts[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _storedPosts.removeAt(index); // 보관함에서 삭제
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
