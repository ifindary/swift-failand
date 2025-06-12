# 📌 Failand

| 🚧 This README is under construction and will be updated soon.

# 📋 Table of Contents

# 🧩 Introduction

실패할수록 성공이 쉬워지는 걸 경험하며, 실패를 두려워하지 않게 해주는 게임

> 어떤 게임은 실패를 의도합니다. 실패해도 도전하게 만드는 구조를 참고하여  
> "실패를 하면 오히려 성공하기 쉬워진다"는 점을 게임을 통해 자연스럽게 알려줍니다.

# ⏳ Development Period

2025.04.09 ~ 2025.04.14 (6 days, 기획)
2025.04.15 ~ 2025.04.24 (10 days, 개발)

# 🧰 Tech Stack

SpriteKit, SwiftUI, CoreMotion, Userdefaults

# 개발 목표

1. 잘 모르는 것 다시 공부하기 (Xcode, SpriteKit, SwiftUI)
2. 아예 모르는 것 배우기 (UserDefaults, Figma, Hifi, Lofi, HIG, 게슈탈트 등)
3. 재미있는 것 시도해보기

# 구현

# 개발 과정

### 🎮 주요 기능 1: 게임답게 만들기

- 직관적이고 단순한 UI
- 실패할수록 난이도가 쉬워지는 역난이도 설계

### 🧾 주요 기능 2: 실패 횟수 CRUD (UserDefaults 활용)

- 실패 기록 저장 및 불러오기
- 기록된 실패 횟수에 따라 캐릭터 능력치 조정

### 🧪 디자인: Lofi → Hifi

- **Lofi:** CRUD 대상 변경 (닉네임 → 실패 횟수)
- **Hifi:** 총 5개의 뷰 구성
  - **MainView**: 타이틀, 게임 진입
  - **LoginView**: 최근 플레이 기록 확인 후 새 게임/이어서 시작
  - **LoadingView**: 로딩 + 응원 문구
  - **GameplayView**: 게임 진행
  - **ResultView**: 결과 화면

### 📚 Learning Backlog

1. SpriteKit 기본 구성 요소
2. CoreMotion으로 캐릭터 이동 구현
3. 실패 횟수 CRUD
4. 게임 로직 연결
5. 디자인 및 화면 구성

---

# ✨ Features

- 기록된 실패 횟수가 있다면 **시점과 횟수** 표시
- 실패 횟수에 따라 **캐릭터 투명도**와 **몬스터 속도** 변화
- 캐릭터는 핸드폰 기울기로 이동 (별도 이동 버튼 없음)

# 🎮 How to play

# 📝 Project Results

---

# ✍️ 후기

SpriteKit의 기본적인 사용법을 익히고 직접 움직임과 상호작용을 구현해보면서  
개발자로서 한 발짝 성장할 수 있었던 프로젝트였습니다.

> 비둘기 생성만 알던 제가 이제는 비둘기를 **움직일 수 있게** 되었습니다.  
> 다음 챌린지를 통해 **비둘기를 날릴 수 있게** 되길 기대합니다! 🕊️

---
