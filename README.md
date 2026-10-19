# 미꾸러미 (MIKKUREOMI) Backend

> 결식 아동에게 밥으로 아름다움을 전하는 꾸러미  
> AI와 공공데이터를 활용한 결식 우려 아동 맞춤형 영양 지원 서비스

**팀 네숟갈** · 2025 SW개발보안 경진대회 (공공활용성)

이 저장소는 미꾸러미 Android 앱을 위한 **Spring Boot 백엔드**입니다.

---

## 서비스 소개

미꾸러미는 결식 우려 아동이 가까운 식사 가능 가맹점을 쉽게 찾고, 식사 사진을 바탕으로 영양 상태를 이해하며, 꾸준하고 균형 잡힌 식습관을 형성하도록 돕는 통합 영양 지원 서비스입니다.

식사를 **찾는 단계 → 기록하는 단계 → 이해하는 단계 → 꾸준히 실천하는 단계**로 연결합니다.

### 해결하려는 문제

| 영역 | 현황 |
|------|------|
| 식사 접근성 | 아동급식카드 가맹점·착한가격업소 정보가 분산되어 있고, 이용 가능한 매장을 찾기 어려움 |
| 영양 관리 | 가맹점·결제 지원에 그쳐 식사 품질·영양 균형·장기 식습관을 관리하기 어려움 |
| 지속성 | 주말·방학 등 결식 위험 시기와 기록 누락을 사전에 돕기 어려움 |
| 정책 근거 | 지자체가 이용 패턴·영양 상태를 정량적으로 파악하기 어려움 |

---

## 핵심 기능

### 1. 위치 기반 가맹점 검색

- 사용자 GPS 기준 주변 아동급식카드 가맹점·착한가격업소 통합 검색
- 서울시 공공데이터 기반 DB 구축 및 주기적 갱신
- 카카오맵 연동을 위한 매장 상세·좌표 제공

### 2. AI 이미지 인식 및 메뉴 분석

- 식사 사진 업로드 → 생성형 AI로 메뉴명 추출
- 식품의약품안전처 영양 데이터와 메뉴 매칭
- 식사량을 반영한 열량·탄수화물·단백질·지방·나트륨·당류·식이섬유 산출

### 3. AI 기반 개인 영양보고서

- 연령·성별 기반 일일 권장 섭취 기준 설정
- 일별·월별 누적 영양 분석 및 점수·시각화
- LLM 피드백과 **판단 근거(XAI)** 를 함께 제공

### 4. 사용자 맞춤 알림

- 결식 위험 시기(주말·방학·공휴일) 사전 알림
- 식사 기록 48시간 이상 누락 시 기록 독려
- 일간 영양 점수 70점 이상 시 긍정 강화 알림

---

## 기술 스택

| 구분 | 기술 |
|------|------|
| Language | Java 21 |
| Framework | Spring Boot 3.5, Spring Security, Spring Data JPA |
| Auth | JWT |
| Database | MySQL |
| Storage | AWS S3 |
| AI | ChatGPT (이미지 인식·영양 피드백) |
| Deploy | AWS, CodeDeploy (`appspec.yml`) |
| Build | Gradle |

---

## 주요 API

| 도메인 | Base Path | 설명 |
|--------|-----------|------|
| 회원 | `/api/users` | 회원가입, 로그인 |
| 프로필 | `/api/profile` | 사용자 프로필 조회 |
| 가맹점 | `/api/restaurants` | 주변·특정 조건 가맹점 검색 |
| 식사 | `/api/meals` | 식사 상세·일자별 조회 |
| 식사 사진 | `/api/meal-pictures` | AI 인식, 저장, 조회 |
| 식사-음식 | `/api/meal-foods` | 식사 메뉴 등록 |
| 식품 | `/api/food` | 영양 DB 동기화·검색 |
| 권장 영양소 | `/api/v1/recommendation` | 개인별 권장 영양소 |
| 일별 보고서 | `/api/daily-reports` | 일별 영양 보고서 |
| 월별 보고서 | `/api/monthly-reports` | 월별 영양 보고서 |
| 알림 | `/api/notifications` | 알림 목록·미읽음 수 |

---

## 프로젝트 구조

```text
src/main/java/com/fourspoons/mikkureomi/
├── user/                  # 회원가입·로그인
├── profile/               # 프로필
├── rastaurant/            # 가맹점 검색
├── meal/                  # 식사 기록
├── mealPicture/           # 식사 사진·AI 인식
├── mealFood/              # 식사-음식 매핑
├── food/                  # 식품 영양 데이터
├── recommendedNutrients/  # 권장 영양소
├── dailyReport/           # 일별 보고서
├── monthlyReport/         # 월별 보고서
├── notification/          # 알림
├── chatgptAnalysis/       # AI 분석 연동
├── jwt/                   # JWT 인증
├── aws/                   # S3 연동
├── scheduler/             # 스케줄 작업
└── config/                # 보안·공통 설정
```

---

## 활용 데이터

- **서울시 공공데이터:** 아동급식카드 가맹점, 착한가격업소, 가격안정 모범업소
- **식품의약품안전처:** 전국통합식품영양성분정보(음식)
- **카카오맵 API:** 지도·길찾기 (클라이언트 연동)
- **생성형 AI:** 메뉴 추출 및 설명 가능한 영양 피드백

---

## 보안·개인정보 보호

아동의 위치·식사 정보를 다루므로 최소 수집과 안전한 처리를 우선합니다.

- 비밀번호 해시 저장, JWT 인증, 로그인 실패 횟수 제한
- 위치 정보는 기능 제공에 필요한 범위에서만 사용
- 업로드 이미지의 EXIF 등 불필요 메타데이터 제거
- AI 추출 결과는 사용자가 확인·보정 가능
- 피드백에 수치 근거를 함께 제공하여 블랙박스 완화

상세 기획은 [`docs/기획.md`](docs/기획.md)를 참고하세요. 보안 점검·수정 계획은 [`SecurityRefactoring/SecurityRefactoring.md`](SecurityRefactoring/SecurityRefactoring.md)를 참고하세요.

---

## 실행 방법

### 요구 사항

- JDK 21+
- MySQL
- (선택) AWS S3, OpenAI API 키

### 빌드·실행

```bash
./gradlew bootRun
# 또는
./gradlew build
java -jar build/libs/mikkureomi-*.jar
```

환경 변수·DB 접속 정보는 로컬 설정 파일에 맞게 구성하세요.

---

## 기대 효과

- **사회적:** 결식 우려 아동의 식사 접근성 개선과 장기적 식습관 형성 지원
- **경제적:** 착한가격업소 연계로 급식 예산 효율화 및 지역 상권 기여
- **기술적:** 공공데이터 + AI + 설명 가능한 피드백을 결합한 공공 서비스 사례

---

## 관련 문서

- [통합 기획서](docs/기획.md)
- [Security Refactoring](SecurityRefactoring/SecurityRefactoring.md)
- [docs/](docs/) — 개발기획서·발표자료·서비스개요서
