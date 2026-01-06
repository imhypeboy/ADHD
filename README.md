# Project Focus

Material Design 3 기반의 생산성 앱으로, 커스텀 타이머와 Magazine Style 타이포그래피로 브랜드 정체성을 확립합니다.

## 기술 스택

- **Flutter**: 최신 버전 (SDK >=3.0.0)
- **Material Design 3**: `useMaterial3: true` 활성화
- **Riverpod**: 상태 관리 (v2.5.1)
- **Pretendard 폰트**: 로컬 에셋 (Layout Shift 방지)

## 프로젝트 구조

```
lib/
├── core/
│   ├── constants/           # 앱 전역 상수 (API 키, 에셋 경로 등)
│   │   └── app_constants.dart
│   ├── utils/               # 날짜 포맷팅, 진동(Haptic) 유틸
│   │   ├── date_formatter.dart
│   │   └── haptic_feedback.dart
│   ├── theme/               # *** [핵심] 우리만의 디자인 시스템 ***
│   │   ├── app_theme.dart       # ThemeData 조립 (Light/Dark)
│   │   ├── color_schemes.dart   # Seed Color 기반 팔레트 정의
│   │   ├── type_scheme.dart     # Pretendard + 매거진 스타일 정의
│   │   └── custom_shapes.dart   # 버튼, 카드 등의 커스텀 Shape
│   └── router/
│       └── app_router.dart
├── features/
│   └── timer/               # [핵심 기능] 타이머
│       ├── presentation/
│       │   ├── pages/           # 타이머 메인 화면
│       │   │   └── timer_page.dart
│       │   ├── widgets/         # 타이머 관련 위젯 (버튼 등)
│       │   │   ├── pie_timer_painter.dart # *** [핵심] CustomPainter 구현체 ***
│       │   │   └── custom_timer_widget.dart
│       │   └── providers/       # 타이머 상태 관리 (Riverpod)
│       │       └── timer_provider.dart
│       ├── domain/              # 타이머 비즈니스 로직 (순수 Dart)
│       │   └── models/
│       │       └── timer_state.dart
│       └── data/                # 로컬 저장소 (SharedPreferences/Isar)
│           └── timer_repository.dart
├── shared/                  # 공용 위젯 (MD3 커스텀 버튼, 다이얼로그 등)
│   └── widgets/
├── main.dart                # 앱 진입점
└── app.dart                 # MaterialApp 설정, Theme 주입
```

## 핵심 기능

### 1. 디자인 시스템 (MD3 + Edge)

- **Theme Architecture**: MD3 기본 동작 상속 + ThemeData extensions로 커스텀 속성 관리
- **Typography**: Pretendard 폰트 기반 "Magazine Style" (Editorial Look)
- **Color**: Deep Orange 시드 컬러, Pure White/Black 배경

### 2. 커스텀 타이머

- **CustomPainter 기반**: CircularProgressIndicator 금지
- **그라데이션 효과**: SweepGradient 적용
- **Glow 효과**: 끝부분 빛 번짐 효과
- **60 FPS 보장**: TickerProvider + RepaintBoundary 최적화

### 3. 상태 관리

- **Riverpod StateNotifier**: UI와 완전히 분리된 타이머 로직
- **반응형 UI**: 상태 변화만 구독하여 렌더링

## 설정 방법

### 1. Pretendard 폰트 추가

`assets/fonts/` 폴더에 다음 파일들을 추가하세요:

- `Pretendard-Regular.otf`
- `Pretendard-Medium.otf`
- `Pretendard-SemiBold.otf`
- `Pretendard-Bold.otf`

폰트는 [Pretendard 공식 사이트](https://github.com/orioncactus/pretendard)에서 다운로드할 수 있습니다.

### 2. 의존성 설치

```bash
flutter pub get
```

### 3. 실행

```bash
flutter run
```

## 주요 특징

- ✅ Material Design 3 완전 지원
- ✅ 커스텀 타이포그래피 (Pretendard)
- ✅ 고성능 커스텀 타이머 (60 FPS)
- ✅ Riverpod 상태 관리
- ✅ 기능 중심 폴더 구조
- ✅ 디자인 시스템 분리

## 라이선스

이 프로젝트는 개인 사용 목적으로 제작되었습니다.
