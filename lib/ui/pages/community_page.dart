import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '커뮤니티',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CommunityPage(),
    );
  }
}

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Map<String, dynamic>> posts = [
    {
      'id': 1,
      'title': '우리 강아지 귀여운거 봐봐',
      'content': '나 처음으로 강아지 키우는데 너무 귀엽지 않아?',
      'author': '나의 반려견',
      'profileUrl': 'https://via.placeholder.com/50',
      'imageUrl': 'https://via.placeholder.com/200',
      'likes': 45,
      'comments': [],
    },
  ];

  void addPost(Map<String, dynamic> newPost) {
    setState(() {
      posts.add(newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니티'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(
                    post: post,
                    onUpdate: (updatedPost) {
                      setState(() {
                        posts[index] = updatedPost;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        posts.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: CommunityPost(post: post),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final newPost = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (context) => const WritePostPage()),
          );
          if (newPost != null) {
            addPost(newPost);
          }
        },
        child: const Text('글쓰기', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7DD4A6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class CommunityPost extends StatelessWidget {
  final Map<String, dynamic> post;

  const CommunityPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(post['profileUrl'], width: 50, height: 50),
        title: Text(post['title'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(post['content']),
      ),
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;
  final void Function(Map<String, dynamic>) onUpdate;
  final VoidCallback onDelete;

  const PostDetailPage({
    Key? key,
    required this.post,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController commentController = TextEditingController();

  void addComment(String comment) {
    setState(() {
      widget.post['comments'].add(comment);
    });
    widget.onUpdate(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['title']),
        backgroundColor: const Color(0xFF009223),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedPost = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (context) => WritePostPage(
                    initialTitle: widget.post['title'],
                    initialContent: widget.post['content'],
                  ),
                ),
              );
              if (updatedPost != null) {
                widget.onUpdate(updatedPost);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(widget.post['profileUrl'], width: 50, height: 50),
                const SizedBox(width: 10),
                Text(widget.post['author'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Text(widget.post['content'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('댓글',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.post['comments'].length,
                itemBuilder: (context, index) {
                  final comment = widget.post['comments'][index];
                  return ListTile(
                    title: Text(comment),
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(labelText: '댓글 작성'),
            ),
            ElevatedButton(
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  addComment(commentController.text);
                  commentController.clear();
                }
              },
              child: const Text('댓글 작성'),
            ),
          ],
        ),
      ),
    );
  }
}

class WritePostPage extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  const WritePostPage({
    Key? key,
    this.initialTitle,
    this.initialContent,
  }) : super(key: key);

  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _contentController.text = widget.initialContent ?? '';
  }

  void _submitPost() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final newPost = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': title,
        'content': content,
        'author': '나의 반려견',
        'profileUrl': 'https://via.placeholder.com/50',
        'imageUrl': null,
        'likes': 0,
        'comments': [],
      };
      Navigator.pop(context, newPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 작성'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPost,
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
