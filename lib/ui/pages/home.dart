import 'package:flutter/material.dart';
import 'profile.dart'; // Profile 페이지 import
import 'community_page.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // BottomNavigationBar의 현재 인덱스
  final TextEditingController _searchController = TextEditingController();

  // BEST 게시글 데이터에 이미지 경로 추가
  final List<Map<String, dynamic>> bestPosts = [
    {
      "title": "그림 그리는 냥이",
      "content": "ㅋㅋ 핸드폰 켜줬더니 그림 그리는 것처럼 놀고 있네요.",
      "author": "이이레",
      "likes": 150,
      "createdAt": DateTime.now().subtract(const Duration(hours: 1)),
      "imagePath": 'assets/images/A.png.png', // 수정된 이미지 경로
    },
  ];

  // 일반 게시글 데이터
  final List<Map<String, dynamic>> normalPosts = [
    {
      "title": "게시글 제목 2",
      "content": "게시글 내용 2입니다.",
      "author": "익명",
      "likes": 120,
      "createdAt": DateTime.now().subtract(const Duration(hours: 3)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('WePets'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 알림 버튼 로직
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommunityPage(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Profile(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '내주변'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      default:
        return const Center(child: Text('페이지 없음'));
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'BEST 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: bestPosts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostDetailPage(post: bestPosts[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image:
                            AssetImage(bestPosts[index]['imagePath']), // 이미지 추가
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          bestPosts[index]['title'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '일반 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: normalPosts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PostDetailPage(post: normalPosts[index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(normalPosts[index]['title']),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post['imagePath'] != null) // 이미지가 있을 경우 표시
              Image.asset(post['imagePath']),
            const SizedBox(height: 16),
            Text(
              post['content'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text('작성자: ${post['author']}'),
            Text('좋아요: ${post['likes']}개'),
            Text('작성 시간: ${post['createdAt']}'),
          ],
        ),
      ),
    );
  }
}
