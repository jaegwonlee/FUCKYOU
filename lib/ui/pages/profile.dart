import 'package:flutter/material.dart';
import 'profile_edit.dart'; // ProfileEdit import
import 'package:flutter_application_2/ui/pages/login.dart';
import 'package:flutter_application_2/ui/pages/customer.dart'; // 고객센터 페이지
import 'package:flutter_application_2/ui/pages/my_post.dart'; // 내 게시글 관리 페이지
import 'package:flutter_application_2/ui/pages/post_storage.dart'; // 게시글 보관함 페이지
import 'package:flutter_application_2/ui/pages/post.dart'; // Post 페이지 추가

class Profile extends StatelessWidget {
  final String? token;

  const Profile({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            child: const Text(
              '로그아웃',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보 섹션
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '나성이 반려인 WELCOME!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileEdit(),
                          ),
                        );
                      },
                      child: Text(
                        '나성이   MY 계정관리',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 버튼 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProfileButton(
                  icon: Icons.edit,
                  label: '내 게시글 관리',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPostPage(),
                      ),
                    );
                  },
                ),
                _ProfileButton(
                  icon: Icons.bookmark,
                  label: '게시글 보관함',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostStoragePage(),
                      ),
                    );
                  },
                ),
                _ProfileButton(
                  icon: Icons.headset_mic,
                  label: '고객센터',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerServicePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 펫 정보 섹션
            const Text(
              'WE PET',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '레오',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Post(
                                    profileImagePath: 'assets/images/logo.png',
                                    name: '레오',
                                    gender: '여아',
                                    age: 4,
                                    personality: '온순한데 물 수도 있어요 아응',
                                    vaccinated: false,
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("게시글 수정으로 이동")),
                              );
                            },
                            icon: const Icon(Icons.edit, size: 16),
                          ),
                        ],
                      ),
                      const Text('성별   여아'),
                      const Text('나이   4'),
                      const Text('성격   온순한데 물 수도 있어요 아응'),
                      const Text('예방접종 여부   X'),
                    ],
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

class _ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child: Icon(icon, size: 30, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
