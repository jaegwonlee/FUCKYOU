import 'package:flutter/material.dart';
import 'profile.dart'; // Profile 페이지 import

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // BottomNavigationBar의 현재 인덱스
  final TextEditingController _searchController = TextEditingController();

  // 샘플 BEST 게시글 데이터, 나중에 필요하면 수정.
  final List<Map<String, dynamic>> bestPosts = [
    {
      "title": "BEST 게시글 1",
      "content": "BEST 게시글 내용입니다.",
      "author": "작성자1",
      "likes": 200,
      "createdAt": DateTime.now().subtract(const Duration(hours: 1)),
    },
  ];

  // 샘플 일반 게시글 데이터
  final List<Map<String, dynamic>> normalPosts = [
    {
      "title": "게시글 제목 2",
      "content": "게시글 내용 2입니다.",
      "author": "익명",
      "likes": 120,
      "createdAt": DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      "title": "게시글 제목 3",
      "content": "게시글 내용 3입니다.",
      "author": "작성자2",
      "likes": 95,
      "createdAt": DateTime.now().subtract(const Duration(days: 1)),
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

          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(token: widget.token),
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
      case 1:
        return _buildSearchPage();
      case 2:
        return const Center(child: Text('내 주변 페이지'));
      case 3:
        return const Center(child: Text('커뮤니티 페이지'));
      default:
        return const Center(child: Text('페이지 없음'));
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onSubmitted: (query) {
                print('검색어: $query');
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'BEST 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: bestPosts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: bestPosts[index]), //여기 코드가 게시글 누르면 상세 페이지로 넘어가게 하느 코드
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        bestPosts[index]['title'],
                        style: const TextStyle(fontSize: 16),
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
                      builder: (context) => PostDetailPage(post: normalPosts[index]),  //여기는 일반 게시글 누르면 넘어가게끔 하느 ㄴ코드
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

  Widget _buildSearchPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onSubmitted: (query) {
              print('검색어: $query');
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '검색 결과를 여기에 표시합니다.\n검색어: ${_searchController.text}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class PostDetailPage extends StatelessWidget {    //여기도 페이지 누르면 글 내용이랑 좋아요 나오게 한 코드
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
