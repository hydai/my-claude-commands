---
description: 分析需求並產生詳細的需求規格文件
allowed-tools: [Read, Write, MultiEdit, Task, Bash, LS]
---

# Spec Driven Development - 需求分析階段

您已經啟動了 Spec Driven Development 的需求分析流程。

## 前置檢查與初始化

首先，我會檢查並建立必要的目錄結構：
- 確認專案根目錄
- 建立 `.claude/sdd/` 目錄（如果不存在）
- 檢查是否存在既有的需求文件

## 深度需求分析流程

### 階段 1：需求理解與去模糊化
- **初步分析**：理解使用者提供的原始需求或想法
- **模糊點識別**：識別需求中的不明確、矛盾或遺漏部分
- **澄清問題**：針對模糊點提出具體的澄清問題
- **背景分析**：了解需求的業務背景和技術環境

### 階段 2：需求拆解與分類
- **功能域劃分**：將需求按功能領域進行分類
- **優先級評估**：根據業務價值和技術複雜度評估優先級
- **依賴關係**：識別需求間的依賴和約束關係
- **範圍邊界**：明確定義專案範圍和邊界條件

### 階段 3：User Story 精準化
每個 User Story 將包含：
- **角色定義**：明確的使用者角色和權限
- **功能描述**：具體的功能需求和期望行為
- **價值說明**：該功能帶來的業務價值
- **驗收條件**：可驗證的完成標準

### 階段 4：驗收標準制定
為每個 User Story 制定詳細的驗收標準：
- **功能性標準**：核心功能的具體驗證方法
- **非功能性標準**：效能、安全性、可用性等要求
- **邊界條件**：異常情況和錯誤處理
- **驗收角色**：明確誰來驗收以及如何驗收
- **驗收方法**：具體的驗證步驟和工具

### 階段 5：文件生成與結構化
最終產生的 `requirements.md` 將包含：
- **專案介紹**：背景、目標和範圍
- **詳細需求清單**：結構化的 User Stories
- **驗收標準**：每個需求的具體驗收條件
- **約束條件**：技術、時間、資源限制
- **風險評估**：潛在風險和緩解措施

## 輸入需求

$ARGUMENTS

---

## 執行確認

我將開始分析您提供的需求，並逐步進行去模糊化處理。在過程中，我可能會向您提出澄清問題以確保需求的準確性。

準備開始需求分析...

---

## Requirements Document 格式模板

### 文件標題格式
```markdown
# 需求文件
# Requirements Document
```

### 文件結構模板

```markdown
# 需求文件

## 介紹

[專案背景、目標和範圍的描述，說明系統的核心價值和業務目標]

## 需求

### 需求 1

**使用者故事：** 作為[角色]，我希望能夠[功能需求]，以便[業務價值]。

#### 驗收標準

1. 當[觸發條件]時，系統應該[預期行為]
2. 當[觸發條件]時，系統應該[預期行為]
3. 當[觸發條件]時，系統應該[預期行為]
4. 當[觸發條件]時，系統應該[預期行為]
5. 當[觸發條件]時，系統應該[預期行為]
6. 當[觸發條件]時，系統應該[預期行為]

### 需求 2

**使用者故事：** 作為[角色]，我希望能夠[功能需求]，以便[業務價值]。

#### 驗收標準

1. 當[觸發條件]時，系統應該[預期行為]
2. 當[觸發條件]時，系統應該[預期行為]
[...]
```

### 英文格式模板

```markdown
# Requirements Document

## Introduction

[Project background, objectives and scope description, explaining the core value and business goals of the system]

## Requirements

### Requirement 1

**User Story:** As a [role], I want [functionality], so that [business value].

#### Acceptance Criteria

1. WHEN [trigger condition] THEN the system SHALL [expected behavior]
2. WHEN [trigger condition] THEN the system SHALL [expected behavior]
3. WHEN [trigger condition] THEN the system SHALL [expected behavior]
4. WHEN [trigger condition] THEN the system SHALL [expected behavior]
5. WHEN [trigger condition] THEN the system SHALL [expected behavior]

### Requirement 2

**User Story:** As a [role], I want [functionality], so that [business value].

#### Acceptance Criteria

1. WHEN [trigger condition] THEN the system SHALL [expected behavior]
2. WHEN [trigger condition] THEN the system SHALL [expected behavior]
[...]
```

### 格式規範

#### 1. 標題層級
- 文件標題：`# 需求文件` 或 `# Requirements Document`
- 主要章節：`## 介紹`、`## 需求`
- 需求項目：`### 需求 1`、`### Requirement 1`
- 驗收標準：`#### 驗收標準`、`#### Acceptance Criteria`

#### 2. 使用者故事格式
- 中文：`**使用者故事：** 作為[角色]，我希望[功能]，以便[價值]。`
- 英文：`**User Story:** As a [role], I want [functionality], so that [value].`

#### 3. 驗收標準格式
- 中文：`當[條件]時，系統應該[行為]`
- 英文：`WHEN [condition] THEN the system SHALL [behavior]`
- 每個需求至少包含 5-6 個驗收標準
- 使用編號清單（1. 2. 3. ...）

#### 4. BDD/Gherkin 格式整合
- 支援傳統驗收標準與 Gherkin 場景並存
- 推薦使用 Gherkin 格式提供更精確的行為定義
- 每個需求可包含多個 Scenario
- 使用 Given-When-Then 結構描述行為

#### 5. 文字風格
- 使用明確、可測試的語言
- 避免模糊詞彙如「適當」、「合理」
- 每個驗收標準都應該是可驗證的
- 包含正常流程和異常情況的驗收標準

### BDD/Gherkin 格式模板

#### Gherkin 語法要素
```gherkin
Feature: [功能名稱]
  [功能描述和業務價值說明]
  [可選的業務規則說明]

  Background:
    Given [共用的前置條件]
    And [其他共用前置條件]

  Scenario: [場景名稱]
    Given [前置條件]
    And [其他前置條件]
    When [觸發動作]
    And [其他相關動作]
    Then [預期結果]
    And [其他預期結果]
    But [不應該發生的結果]

  Scenario Outline: [參數化場景名稱]
    Given [前置條件] with "<parameter>"
    When [動作] "<value>"
    Then [結果] should be "<expected>"

    Examples:
      | parameter | value | expected |
      | 測試值1   | 輸入1 | 結果1    |
      | 測試值2   | 輸入2 | 結果2    |
```

#### BDD 整合的需求格式模板

```markdown
### 需求 1

**使用者故事：** 作為[角色]，我希望能夠[功能需求]，以便[業務價值]。

#### BDD Feature 定義

```gherkin
Feature: [功能名稱]
  作為 [角色]
  我希望 [功能描述]
  以便 [業務價值]

  Background:
    Given 系統已經初始化
    And 使用者已經登入

  Scenario: [主要場景名稱]
    Given [前置條件]
    When [使用者執行動作]
    Then [系統應該回應]
    And [額外的預期結果]

  Scenario: [異常場景名稱]
    Given [異常前置條件]
    When [使用者執行動作]
    Then [系統應該處理錯誤]
    And [提供適當的錯誤訊息]

  Scenario Outline: [邊界條件測試]
    Given 使用者輸入 "<input_type>" 為 "<input_value>"
    When 系統處理輸入
    Then 結果應該是 "<expected_result>"

    Examples:
      | input_type | input_value | expected_result |
      | 有效輸入   | 正常值      | 成功            |
      | 無效輸入   | 空值        | 錯誤訊息        |
      | 邊界值     | 最大值      | 成功            |
```

#### 傳統驗收標準（可選，與 BDD 並存）

1. 當[觸發條件]時，系統應該[預期行為]
2. 當[觸發條件]時，系統應該[預期行為]
3. [其他驗收標準...]
```

#### 英文 BDD 格式模板

```markdown
### Requirement 1

**User Story:** As a [role], I want [functionality], so that [business value].

#### BDD Feature Definition

```gherkin
Feature: [Feature Name]
  As a [role]
  I want [functionality description]
  So that [business value]

  Background:
    Given the system is initialized
    And the user is logged in

  Scenario: [Main scenario name]
    Given [precondition]
    When [user performs action]
    Then [system should respond]
    And [additional expected outcome]

  Scenario: [Error scenario name]
    Given [error precondition]
    When [user performs action]
    Then [system should handle error]
    And [provide appropriate error message]

  Scenario Outline: [Boundary condition testing]
    Given user inputs "<input_type>" as "<input_value>"
    When system processes input
    Then result should be "<expected_result>"

    Examples:
      | input_type | input_value | expected_result |
      | valid      | normal      | success         |
      | invalid    | empty       | error_message   |
      | boundary   | max_value   | success         |
```

#### Traditional Acceptance Criteria (Optional, coexists with BDD)

1. WHEN [trigger condition] THEN the system SHALL [expected behavior]
2. WHEN [trigger condition] THEN the system SHALL [expected behavior]
3. [Other acceptance criteria...]
```

### BDD 最佳實踐

#### 1. Scenario 設計原則
- **簡潔性**：每個 Scenario 專注於一個行為
- **可讀性**：使用業務語言，非技術人員也能理解
- **完整性**：涵蓋主要流程、異常情況、邊界條件
- **獨立性**：每個 Scenario 應該能獨立執行

#### 2. Given-When-Then 指導原則
- **Given**：描述系統的初始狀態和前置條件
- **When**：描述觸發行為的動作或事件
- **Then**：描述預期的結果或系統狀態變化
- **And/But**：用於連接多個相同類型的步驟

#### 3. 參數化和資料驅動
- 使用 **Scenario Outline** 處理多種輸入組合
- 使用 **Examples** 表格提供測試資料
- 使用 **Data Tables** 處理複雜的結構化資料

#### 4. Background 使用時機
- 多個 Scenario 有相同的前置條件
- 避免在每個 Scenario 中重複相同的 Given 步驟
- 保持 Background 簡潔，只包含必要的共用設定

#### 5. 語言和本地化
- Gherkin 支援多種語言關鍵字
- 中文範例：功能、場景、假如、當、那麼
- 英文範例：Feature、Scenario、Given、When、Then
- 選擇團隊熟悉的語言並保持一致
