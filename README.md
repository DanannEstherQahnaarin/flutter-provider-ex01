# Flutter Provider Todo 앱

Flutter의 Provider 패턴을 활용한 할 일 관리 애플리케이션입니다.

## 프로젝트 소개

이 프로젝트는 Flutter의 상태 관리 패턴 중 하나인 Provider를 학습하고 실습하기 위해 개발된 Todo 애플리케이션입니다. ChangeNotifier를 활용한 상태 관리와 Material Design 컴포넌트를 사용하여 사용자 친화적인 UI를 제공합니다.

## 주요 기능

### 1. Todo 목록 관리
- Todo 항목 추가, 수정, 삭제 기능
- Todo 목록을 리스트 형태로 표시
- 완료 상태에 따른 아이콘 표시

### 2. Todo 상세 정보
- BottomSheet를 통한 Todo 상세 정보 표시
- 제목과 내용 편집 기능
- 완료 상태 체크박스

### 3. 날짜 및 시간 관리
- 작성일 자동 기록 및 표시
- 완료일 선택 기능 (DatePicker + TimePicker)
- 완료 상태에 따른 완료일 표시/숨김 처리
- 한국어 로케일 지원

### 4. 상태 관리
- Provider 패턴을 통한 전역 상태 관리
- ChangeNotifier를 활용한 상태 변경 알림
- 실시간 UI 업데이트

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점, Provider 설정
├── models/
│   └── todo.dart            # Todo 데이터 모델
├── provider/
│   └── todo_provider.dart   # Todo 상태 관리 (ChangeNotifier)
└── view/
    ├── home.dart            # 메인 화면 (Todo 목록)
    └── detail.dart          # Todo 상세 화면 (BottomSheet)
```

### 주요 파일 설명

- **main.dart**: ChangeNotifierProvider를 사용하여 TodoProvider를 전역으로 제공
- **models/todo.dart**: Todo 엔티티 클래스 (id, 제목, 내용, 완료 상태, 작성일, 완료일)
- **provider/todo_provider.dart**: Todo 목록 관리 및 CRUD 작업 처리
- **view/home.dart**: Todo 목록을 표시하는 메인 화면
- **view/detail.dart**: Todo 상세 정보를 표시하고 편집하는 BottomSheet

## 프로젝트 진행하며 습득한 주요 기술

### 1. Provider 패턴
- **ChangeNotifier**: 상태 변경을 알리는 클래스 구현
- **ChangeNotifierProvider**: 위젯 트리에 상태 제공
- **context.watch()**: 상태 변경 시 자동으로 위젯 재빌드
- **notifyListeners()**: 상태 변경 시 리스너에게 알림

### 2. 상태 관리
- 전역 상태와 로컬 상태의 구분
- StatefulBuilder를 활용한 BottomSheet 내부 상태 관리
- 상태 변경에 따른 조건부 UI 렌더링

### 3. Flutter UI 컴포넌트
- **BottomSheet**: 하단에서 올라오는 모달 형태의 UI
- **DatePicker & TimePicker**: 날짜/시간 선택 다이얼로그
- **Form & TextFormField**: 폼 입력 처리
- **ListView.builder**: 동적 리스트 렌더링
- **StatefulBuilder**: 위젯 내부에서 상태 업데이트

### 4. Dart 언어 기능
- **Null Safety**: nullable 타입(`DateTime?`) 처리
- **삼항 연산자**: 조건부 표현식
- **스프레드 연산자**: 리스트 조건부 추가 (`if (condition) ...[widgets]`)
- **Named Parameters**: 함수 호출 시 명명된 매개변수 사용

### 5. 날짜/시간 처리
- **DateTime**: 날짜와 시간을 함께 관리
- **TimeOfDay**: 시간만 관리하는 클래스
- **DateTime.now()**: 현재 시간 가져오기
- 날짜/시간 포맷팅 (YYYY-MM-DD HH:mm 형식)

### 6. 비동기 처리
- **async/await**: 비동기 작업 처리
- **Future**: DatePicker, TimePicker의 비동기 결과 처리

### 7. UI/UX 패턴
- 조건부 렌더링을 통한 동적 UI
- 로케일 설정 (한국어)
- 사용자 입력 검증 및 피드백

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
```

## 사용된 패키지

- `provider: ^6.1.5+1` - 상태 관리
- `intl: ^0.20.2` - 국제화 지원
- `logger: ^2.6.2` - 로깅

## 개발 환경

- Flutter SDK: ^3.10.1
- Dart SDK: ^3.10.1

