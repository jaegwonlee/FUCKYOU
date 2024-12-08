import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '앱 제목',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 커뮤니티 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommunityPage()),
            );
          },
          child: const Text('커뮤니티'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF7DD4A6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  // 게시글 리스트
  List<Map<String, String>> posts = [
    {
      'title': '우리 강아지 귀여운거 봐봐',
      'content': '나 처음으로 강아지 키우는데 세상 너무 이쁜거 같아 진짜 너무 귀엽지 않아 ㅠㅠ??',
      'imageUrl': 'https://via.placeholder.com/50',
    },
    {
      'title': '**서울 잠실 산책로 추천**',
      'content': '1. 잠실 석촌호수\n2. 송파 둘레길\n3. 잠실 한강공원 ...',
    },
    {
      'title': '우리 동네 동물병원 생겼는데',
      'content': '엄청 크고 되게 깔끔한 것 같아. 여기 병원 위치는 대전광역시 서구에 있어!',
    },
    {
      'title': '우리 강아지 눈이 충혈됐어',
      'content': '울 강아지 눈이 충혈 됐는데 어떻게 해야 해 ㅠㅠ?\n우리 집 근처에는 24시 동물병원이 없어서 ...',
    },
    {
      'title': '오늘은 강아지의 날',
      'content': '오늘은 강아지의 날입니다! 다들 오늘 본인들 강아지에게 더 많이 사랑해주세요 ❤❤❤',
    },
    {
      'title': '우리 강아지 생일인데 축하해줘',
      'content': '울 강아지 오늘 생일이야! 축하해줘 ❤❤❤',
    },
    {
      'title': '강아지 산책 예절',
      'content': '산책할 때 리드줄 길이 조절 중요해요. 다른 강아지와 만날 때도 주의해야 한답니다!',
    },
  ];

  // 새 게시글 추가하는 함수
  void addPost(Map<String, String> newPost) {
    setState(() {
      posts.add(newPost); // 게시글 추가 후 화면 갱신
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니티'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // 새 게시글 작성 페이지로 이동하고, 새 게시글 데이터를 받아옴
              final newPost = await Navigator.push<Map<String, String>>(
                context,
                MaterialPageRoute(builder: (context) => const WritePostPage()),
              );
              if (newPost != null) {
                addPost(newPost); // 새로운 게시글이 있으면 추가
              }
            },
            child: const Text('작성하기', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color(0xFF7DD4A6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(
                          title: posts[index]['title']!,
                          content: posts[index]['content']!,
                          post: posts[index],
                        ),
                      ),
                    );
                  },
                  child: CommunityPost(
                    title: posts[index]['title']!,
                    content: posts[index]['content']!,
                    imageUrl: posts[index]['imageUrl'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityPost extends StatelessWidget {
  final String title;
  final String content;
  final String? imageUrl;

  const CommunityPost({
    Key? key,
    required this.title,
    required this.content,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: imageUrl != null
            ? Image.network(imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
            : null,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final Map<String, dynamic> post;

  const PostDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text("작성자: ${post['author'] ?? '익명'}",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class WritePostPage extends StatefulWidget {
  const WritePostPage({Key? key}) : super(key: key);

  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // 새 게시글 작성 함수
  void _submitPost() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final newPost = {
        'title': title,
        'content': content,
        'imageUrl': 'https://via.placeholder.com/50',
      };
      Navigator.pop(context, newPost); // 작성된 게시글을 CommunityPage로 전달
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시글 작성'),
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
              child: const Text('게시글 작성'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF7DD4A6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
