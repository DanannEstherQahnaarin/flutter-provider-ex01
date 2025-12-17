import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:flutter_provider_ex01/view/todo_list.dart';
import 'package:provider/provider.dart';

/// [main.dart] 기능 상세
/// 
/// 1. 앱의 진입점(main) 및 전역 Provider(TodoProvider) 설정
/// 2. Flutter MaterialApp 구조 및 한글/영문 로케일 지원 셋업
/// 3. 전역 테마(SeedColor)와 기본 home 위젯(TodoList) 지정
/// 4. 내부 위젯에서 TodoProvider를 손쉽게 접근할 수 있도록 ChangeNotifierProvider 사용
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

/// 앱 전체 Material 구조 및 로케일, 테마, 라우트 등 환경 설정
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TODO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        /// Flutter 한글 및 영문 다국어 지원을 위한 delegates 적용
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale('en', 'US'),
        ],
        /// 기본 언어/지역설정(한국어)
        locale: const Locale('ko', 'KR'),
        /// 메인 Todo 리스트 화면 지정
        home: const TodoList(),
      );
}
