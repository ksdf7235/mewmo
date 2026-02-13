# PetMemo - 랜덤 페르소나 기반 AI 메모 앱

반려동물 페르소나가 당신의 메모에 반응하는 감성 메모 앱입니다.
가챠로 만난 펫에게 이름을 지어주고, 일상을 기록하면 펫이 귀엽게 반응합니다.

---

## 프로젝트 구조

```
Begin-Now/
├── flutter_app/          # Flutter 앱 (Android/Windows/Web)
├── docs/                 # 기획 문서 및 보고서
└── README.md
```

---

## 핵심 기능

- **가챠 시스템** — 앱 최초 실행 시 확률 기반 펫 배정 (시바견 40%, 치즈냥이 40%, 토끼 8%, 햄스터 7%, 아기용 5%)
- **작명 온보딩** — "내 이름을 지어줄래?" → 이름 입력 → "마음에 들어! 잘 부탁해 주인님!"
- **메모 + 펫 반응** — 메모 작성 시 AI가 펫 역할로 한국어 반응 생성
- **오프라인 지원** — 서버 없이도 로컬 DB 저장 + 템플릿 기반 대체 응답
- **로컬 DB** — Drift(SQLite)로 모든 데이터 기기 내 저장
- **멀티 플랫폼** — Android, Windows, Web 하나의 코드베이스로 지원

---

## 기술 스택

| 레이어 | 기술 |
|--------|------|
| UI | Flutter 3.38 + flutter_animate |
| 상태 관리 | Riverpod |
| 로컬 DB | Drift (SQLite / Web: IndexedDB) |
| 네트워킹 | Dio |
| 라우팅 | GoRouter |
| 폰트 | Google Fonts (Noto Sans KR) |

---

## 실행 방법

```bash
cd flutter_app
flutter pub get
dart run build_runner build
```

### Android
```bash
flutter run                # 연결된 기기/에뮬레이터
flutter build apk          # APK 빌드
```

### Windows
```bash
flutter run -d windows
```

### Web
```bash
flutter run -d chrome
flutter build web           # 배포용 빌드 (build/web/)
```

---

## 디렉토리 구조

```
flutter_app/lib/
├── main.dart                    # 앱 진입점
├── app.dart                     # MaterialApp + GoRouter
├── config/                      # 설정 (API, 펫 상수, 테마)
├── data/
│   ├── database/                # Drift 테이블 + DB 클래스
│   └── services/                # API 클라이언트
├── providers/                   # Riverpod 상태 관리
├── ui/
│   ├── screens/                 # 화면 (가챠, 작명, 대시보드, 설정 등)
│   └── widgets/                 # 위젯 (펫 아바타, 메모 카드, 말풍선 등)
└── utils/                       # 유틸리티 (프롬프트, 오프라인 응답, 날짜)
```

---

## 환경 요구사항

- Flutter SDK 3.38+
- Dart SDK 3.10+
- Android SDK 36 (Android 빌드 시)
- JDK 17 (Android 빌드 시)

---

## 문서

| 문서 | 설명 |
|------|------|
| [`docs/기획서_대비_코드_검수_보고서.md`](docs/기획서_대비_코드_검수_보고서.md) | 기획서와 기존 코드 간 갭 분석 |
| [`docs/Flutter_전환_작업_보고서.md`](docs/Flutter_전환_작업_보고서.md) | Flutter 전환 작업 상세 보고서 |
