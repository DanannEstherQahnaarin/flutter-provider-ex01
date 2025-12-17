import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

/// 하단에 새로운 Todo 항목 추가를 위한 Modal Bottom Sheet를 표시하는 함수.
/// - 제목과 내용 입력을 위한 폼을 제공
/// - 두 입력값 모두 유효성 검사 수행
/// - '추가' 버튼 클릭 시 Provider의 addToTodoList 호출
/// - 추가 성공 시 바텀시트 닫고 입력폼 초기화, 실패 시 SnackBar로 에러 알림
/// - '취소' 버튼 클릭 시 단순 바텀시트 종료
void showAddTodoBottomSheet(BuildContext context) {
  // 폼 유효성 검증을 위한 GlobalKey
  final formKey = GlobalKey<FormState>();

  // 제목 입력 컨트롤러
  final TextEditingController titleController = TextEditingController();

  // 내용 입력 컨트롤러
  final TextEditingController contentController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // 키보드 표시 시 영역 확보
    builder: (context) {
      // TodoProvider 접근(상태 관리 목적)
      final provider = context.read<TodoProvider>();

      return Padding(
        // 키보드가 올라올 경우 하단 패딩 적용하여 가려지지 않게 조정
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: formKey, // 폼 유효성 검증 키
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 타이틀 텍스트
              const Text(
                '새 Todo 추가',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // 제목 입력 필드
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: '제목',
                  border: OutlineInputBorder(),
                ),
                // 입력값이 없을 경우 에러 메시지 반환(필수 입력)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 내용 입력 필드
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // 여러 줄 입력 허용
                // 입력값이 없을 경우 에러 메시지 반환(필수 입력)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // 버튼 Row: 취소/추가
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 취소 버튼: 바텀시트 종료
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 10),
                  // 추가 버튼: 유효성 검사 & Todo 추가 처리
                  ElevatedButton(
                    onPressed: () {
                      // 폼 유효성 검증 성공 시만 동작
                      if (formKey.currentState!.validate()) {
                        // Provider를 통해 Todo 추가 시도
                        final success = provider.addToTodoList(
                          title: titleController.text,
                          content: contentController.text,
                        );

                        if (success) {
                          // 정상 추가 시 바텀시트 종료 및 입력폼 초기화
                          Navigator.pop(context);
                          titleController.clear();
                          contentController.clear();
                        } else {
                          // 추가 실패 시 SnackBar로 에러 안내
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(const SnackBar(content: Text('Todo 추가에 실패했습니다.')));
                        }
                      }
                    },
                    child: const Text('추가'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
