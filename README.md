# Flutter Provider Todo 앱

Flutter의 Provider 패턴을 활용한 할 일 관리 애플리케이션입니다.

## 프로젝트 소개

이 프로젝트는 Flutter의 상태 관리 패턴 중 하나인 Provider를 학습하고 실습하기 위해 개발된 Todo 애플리케이션입니다. ChangeNotifier를 활용한 상태 관리와 Material Design 컴포넌트를 사용하여 사용자 친화적인 UI를 제공합니다.

## 주요 기능

### 1. Todo 목록 관리
- Todo 항목 추가, 수정, 삭제 기능 (CRUD)
- Todo 목록을 리스트 형태로 표시
- 완료 상태에 따른 아이콘 표시 (체크박스 아이콘)
- FloatingActionButton을 통한 빠른 추가 기능

### 2. Todo 추가 기능
- BottomSheet를 통한 Todo 추가 폼
- 제목과 내용 입력 필드
- 입력 유효성 검사 (Form validation)
- 자동 ID 생성 및 작성일 기록

### 3. Todo 수정 기능
- BottomSheet를 통한 Todo 상세 정보 표시 및 편집
- 제목과 내용 편집 기능
- 완료 상태 체크박스
- 완료 상태에 따른 완료일 표시/숨김 처리

### 4. Todo 삭제 기능
- AlertDialog를 통한 삭제 확인
- 안전한 삭제 프로세스

### 5. 날짜 및 시간 관리
- 작성일 자동 기록 및 표시
- 완료일 선택 기능 (DatePicker + TimePicker)
- 완료 상태가 true일 때만 완료일 선택 UI 표시
- 한국어 로케일 지원

### 6. 상태 관리
- Provider 패턴을 통한 전역 상태 관리
- ChangeNotifier를 활용한 상태 변경 알림
- 실시간 UI 업데이트 (context.watch 사용)

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점, Provider 설정, MaterialApp 구성
├── models/
│   └── todo.dart            # Todo 데이터 모델
├── provider/
│   └── todo_provider.dart   # Todo 상태 관리 (ChangeNotifier)
└── view/
    ├── todo_list.dart       # 메인 화면 (Todo 목록)
    ├── todo_add.dart        # Todo 추가 BottomSheet
    ├── todo_detail.dart     # Todo 상세/수정 BottomSheet
    └── todo_delete.dart     # Todo 삭제 Dialog
```

### 주요 파일 설명

- **main.dart**: ChangeNotifierProvider를 사용하여 TodoProvider를 전역으로 제공, MaterialApp 설정 및 한국어 로케일 지원
- **models/todo.dart**: Todo 엔티티 클래스 (id, 제목, 내용, 완료 상태, 작성일, 완료일)
- **provider/todo_provider.dart**: Todo 목록 관리 및 CRUD 작업 처리 (addToTodoList, modifyToTodoList, deleteToTodoList)
- **view/todo_list.dart**: Todo 목록을 표시하는 메인 화면, FloatingActionButton으로 추가 기능 제공
- **view/todo_add.dart**: Todo 추가를 위한 BottomSheet 폼
- **view/todo_detail.dart**: Todo 상세 정보 표시 및 수정을 위한 BottomSheet
- **view/todo_delete.dart**: Todo 삭제 확인을 위한 AlertDialog

## 프로젝트 진행하며 습득한 주요 기술

### 1. Provider 패턴
- **ChangeNotifier**: 상태 변경을 알리는 클래스 구현
- **ChangeNotifierProvider**: 위젯 트리에 상태 제공
- **context.watch()**: 상태 변경 시 자동으로 위젯 재빌드 (build 메서드 내에서 사용)
- **context.read()**: 이벤트 핸들러에서 상태 읽기 (한 번만 읽기)
- **notifyListeners()**: 상태 변경 시 리스너에게 알림

### 2. 상태 관리
- 전역 상태와 로컬 상태의 구분
- StatefulBuilder를 활용한 BottomSheet 내부 상태 관리
- 상태 변수를 StatefulBuilder 외부에 선언하여 상태 유지
- 상태 변경에 따른 조건부 UI 렌더링

### 3. Flutter UI 컴포넌트
- **showModalBottomSheet**: 하단에서 올라오는 모달 형태의 UI
- **AlertDialog**: 확인 다이얼로그
- **DatePicker & TimePicker**: 날짜/시간 선택 다이얼로그
- **Form & TextFormField**: 폼 입력 처리 및 유효성 검사
- **ListView.builder**: 동적 리스트 렌더링
- **StatefulBuilder**: 위젯 내부에서 상태 업데이트
- **FloatingActionButton**: 빠른 액션 버튼

### 4. Dart 언어 기능
- **Null Safety**: nullable 타입(`DateTime?`) 처리
- **삼항 연산자**: 조건부 표현식
- **스프레드 연산자**: 리스트 조건부 추가 (`if (condition) ...[widgets]`)
- **Named Parameters**: 함수 호출 시 명명된 매개변수 사용
- **Extension Methods**: context.read, context.watch 확장 메서드

### 5. 날짜/시간 처리
- **DateTime**: 날짜와 시간을 함께 관리
- **TimeOfDay**: 시간만 관리하는 클래스
- **DateTime.now()**: 현재 시간 가져오기
- 날짜/시간 포맷팅 (YYYY-MM-DD HH:mm 형식)
- DatePicker와 TimePicker를 연속으로 사용하여 날짜와 시간 선택

### 6. 비동기 처리
- **async/await**: 비동기 작업 처리
- **Future**: DatePicker, TimePicker의 비동기 결과 처리
- **showDatePicker/showTimePicker**: 비동기 다이얼로그 표시

### 7. UI/UX 패턴
- 조건부 렌더링을 통한 동적 UI
- 로케일 설정 (한국어)
- 사용자 입력 검증 및 피드백 (SnackBar)
- Context 관리 (bottomSheetContext, builderContext 구분)

### 8. 국제화 (i18n)
- **flutter_localizations**: Material 위젯의 현지화 지원
- **GlobalMaterialLocalizations**: Material 위젯의 한국어 지원
- **Locale 설정**: 한국어(ko_KR) 기본 로케일 설정

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
```

## 사용된 패키지

- `provider: ^6.1.5+1` - 상태 관리
- `flutter_localizations` - Material 위젯 현지화 지원
- `intl: ^0.20.2` - 국제화 지원
- `logger: ^2.6.2` - 로깅

## 개발 환경

- Flutter SDK: ^3.10.1
- Dart SDK: ^3.10.1

## 주요 구현 포인트

### 1. Provider 사용 시 주의사항
- `context.watch()`는 위젯의 `build` 메서드 내에서만 사용
- `context.read()`는 이벤트 핸들러(버튼 클릭 등)에서 사용
- 함수 내부에서 `context.watch()` 사용 시 에러 발생

### 2. StatefulBuilder 상태 관리
- 상태 변수는 StatefulBuilder 외부에 선언하여 상태 유지
- builder 내부에서 매번 초기화하면 상태가 유지되지 않음

### 3. Context 관리
- `showModalBottomSheet`의 builder context와 StatefulBuilder의 builder context 구분
- DatePicker/TimePicker 호출 시 올바른 context 사용 필요

### 4. MaterialLocalizations 설정
- DatePicker 사용 시 `flutter_localizations` 패키지 필요
- `MaterialApp`에 `localizationsDelegates` 설정 필수
