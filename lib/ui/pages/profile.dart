import 'package:flutter/material.dart';
import 'profile_edit.dart'; // ProfileEdit import
import 'package:flutter_application_2/ui/pages/login.dart';
import 'package:flutter_application_2/ui/pages/post.dart';


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
            Navigator.pop(context);// 페이지 이동 로직 제거, 일단 뒤로 가기 넣어 놓을게 재권, 근데 뒤로가기 버튼을 누르면 페이지 없음이라 뜨는 거 수정을 해야 할 듯. 
                                  //밑에 하단바도 MY를 가리키고 있고 홈을 가리키지를 않고 있네..
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false, // 이전 라우트를 모두 제거, 여긴 로그아웃 해놓을게
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
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/profile_image.png'), // 프로필 이미지 경로
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
                        // "MY 계정관리"를 눌렀을 때 ProfileEdit 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEdit()),
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
            const Text(
              'WE PET',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
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
                    backgroundImage:
                        AssetImage('assets/images/logo.png'), // 펫 이미지 경로
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
                              // PostEditPage로 프로필 정보 전달
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Post(
                                    profileImagePath: 'assets/images/logo.png',  // 이미지 경로
                                    name: '레오',  // 이름
                                    gender: '여아',  // 성별
                                    age: 4,  // 나이
                                    personality: '온순한데 물 수도 있어요 아응',  // 성격
                                    vaccinated: false,  // 예방접종 여부
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("게시글 수정으로 이동")),
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
