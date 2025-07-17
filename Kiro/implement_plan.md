---
description: 基於架構設計產生詳細的實作計畫
allowed-tools: [Read, Write, MultiEdit, TodoWrite, Bash, LS, Grep]
---

# Spec Driven Development - 實作計畫階段

您已經啟動了 Spec Driven Development 的實作計畫流程。

## 前置檢查與文件驗證

### 1. 依賴文件檢查
- 確認 `.claude/sdd/requirements.md` 存在且完整
- 確認 `.claude/sdd/design.md` 存在且完整
- 驗證設計文件與需求文件的一致性
- 檢查專案現有結構和技術環境

### 2. 架構設計解析
- 深度分析設計文件中的架構規劃
- 識別所有系統組件和模組
- 理解組件間的依賴關係和介面
- 提取技術選型和實作約束

## 精細化任務規劃流程

### 階段 1：系統分解與功能劃分
- **核心功能模組識別**：
  - 基於架構設計識別主要功能域
  - 分析每個功能域的核心職責
  - 確定模組間的介面和契約
- **共用元件規劃**：
  - 識別可複用的基礎組件
  - 設計通用工具和公用程式庫
  - 規劃配置和常數管理
- **基礎設施組件**：
  - 錯誤處理和日誌系統
  - 配置管理和環境設定
  - 測試基礎設施和工具

### 階段 2：任務分解策略
- **最小可測試單位**：
  - 每個任務必須是可獨立測試的最小功能
  - 確保任務的輸入輸出清晰定義
  - 任務完成標準明確且可驗證
- **垂直切片原則**：
  - 優先完成端到端的功能切片
  - 每個切片包含完整的用戶價值
  - 避免僅做水平分層的技術任務
- **漸進式複雜度**：
  - 從簡單到複雜的任務排序
  - 先建立核心功能再擴展邊緣案例
  - 考慮學習曲線和技術風險

### 階段 3：BDD+TDD 五階段流程設計
每個任務都包含完整的 BDD+TDD 週期：

#### 3.1 Gherkin 場景設計階段（BDD）
- **場景分析**：
  - 基於需求的 Gherkin Feature 分析具體場景
  - 識別主要流程、異常情況、邊界條件
  - 定義 Background 共用前置條件
- **場景撰寫**：
  - 使用 Given-When-Then 格式撰寫場景
  - 設計 Scenario Outline 處理參數化測試
  - 建立 Examples 資料表格

#### 3.2 Step Definition 實作階段（BDD）
- **步驟定義**：
  - 將 Gherkin 步驟轉換為可執行代碼
  - 建立測試環境和資料設定
  - 設計外部依賴的 Mock 策略
- **場景驗證**：
  - 確保 BDD 場景能正確執行（但功能尚未實作，應該失敗）
  - 驗證測試基礎設施的完整性

#### 3.3 單元測試設計階段（TDD 紅燈）
- **測試案例設計**：
  - 基於 BDD 場景設計對應的單元測試
  - 包含正向流程和異常情況的詳細測試
  - 邊界條件和錯誤處理測試
- **測試環境準備**：
  - 建立測試夾具和模擬數據
  - 配置測試工具和框架
  - 確保所有測試都失敗（紅燈狀態）

#### 3.4 最小實作階段（TDD 綠燈）
- **功能實作**：
  - 編寫通過測試的最小代碼
  - 遵循 YAGNI (You Ain't Gonna Need It) 原則
  - 保持代碼簡潔和可讀性
- **介面定義**：
  - 明確模組對外的API契約
  - 定義資料結構和型別
  - 確保介面的一致性
- **BDD 場景通過**：
  - 確保實作能通過所有 BDD 場景
  - 驗證業務行為的正確性

#### 3.5 重構最佳化階段（TDD 重構）
- **代碼品質提升**：
  - 消除重複代碼 (DRY 原則)
  - 改善命名和代碼結構
  - 最佳化演算法和性能
- **設計模式應用**：
  - 應用適當的設計模式
  - 提高代碼的可維護性
  - 確保擴展性和靈活性
- **全面驗證**：
  - 確保重構後所有 BDD 場景仍然通過
  - 所有單元測試保持綠燈狀態
  - 驗證系統整體行為一致性

### 階段 4：依賴關係與排程規劃
- **依賴分析**：
  - 技術依賴：框架、程式庫、工具
  - 功能依賴：模組間的調用關係
  - 資料依賴：資料結構和資料流
- **關鍵路徑識別**：
  - 找出影響專案進度的關鍵任務
  - 優先處理高風險和高依賴任務
  - 規劃並行開發的可能性
- **里程碑設定**：
  - 定義可驗證的交付里程碑
  - 每個里程碑包含完整的功能驗證
  - 設定風險檢查點和決策點

### 階段 5：風險評估與應變計劃
- **技術風險**：
  - 新技術學習成本
  - 第三方依賴的可用性
  - 效能和擴展性挑戰
- **進度風險**：
  - 任務預估的準確性
  - 意外阻塞的應對方案
  - 資源調配的靈活性

## 任務文件結構規範

### 任務組織格式
```markdown
## [功能域] - [主要任務名稱]

### 任務 ID: [編號]
- **任務名稱**: [具體任務描述]
- **任務描述**: [詳細的功能說明]
- **驗收標準**: [明確的完成標準]
- **TDD 步驟**:
  1. 測試案例: [具體測試內容]
  2. 最小實作: [實作重點]
  3. 重構目標: [最佳化方向]
- **依賴關係**: [前置任務清單]
- **預估時間**: [開發時間評估]
- **風險評估**: [潛在風險和應對]
- **狀態**: ⏳ 待執行
```

### 狀態管理系統
- ⏳ **待執行** (pending) - 任務已規劃但尚未開始
- 🔄 **執行中** (in_progress) - 任務正在進行中
- ✅ **已完成** (completed) - 任務完成並通過驗收
- ❌ **阻塞中** (blocked) - 任務遇到阻礙暫停
- 🔁 **需重做** (rework) - 任務需要返工修正
- ⚠️ **有風險** (at_risk) - 任務進度或品質有風險

## 輸出檔案規格

將產生結構化的 `.claude/sdd/tasks.md` 文件，包含：

### 1. 專案概覽
- 總任務數量和預估時間
- 主要里程碑和交付計劃
- 關鍵依賴和風險摘要

### 2. 任務清單
- 按優先順序排列的詳細任務
- 完整的 TDD 執行步驟
- 明確的依賴關係和時程安排

### 3. 執行追蹤
- 即時的進度狀態更新
- 阻塞問題和解決方案
- 品質檢查點和驗收記錄

## 計劃參數

$ARGUMENTS

---

## 實作計劃執行

我將基於需求和設計文件進行詳細的任務分解，確保每個任務都符合 TDD 原則，具有明確的驗收標準和合理的依賴關係。

開始分析架構設計，準備任務規劃...

---

## Tasks Document 格式模板

### 文件標題格式
```markdown
# 實作計劃
# Implementation Plan
```

### 文件結構模板

```markdown
# 實作計劃

- [x] 1. 建立專案基礎架構與核心介面
  - 建立 [技術棧] 專案結構與配置
  - 定義核心介面與類型定義
  - 設置測試環境與 TDD 工具鏈
  - _需求: 1.1, 2.1, 3.1, 4.1, 5.1_

- [ ] 2. 實作 [功能域名稱]
- [x] 2.1 建立 [子功能] 核心功能
  - 撰寫 [組件] 介面與基本實作
  - 實作 [具體功能] 的識別邏輯
  - 建立 [驗證機制] 機制
  - 撰寫 [組件] 的單元測試
  - _需求: 1.1, 2.1, 3.1, 4.1_

- [x] 2.2 實作 [子功能] 處理與驗證
  - 建立 [處理邏輯] 與驗證邏輯
  - 實作錯誤處理與使用者回饋機制
  - 撰寫 [功能] 處理的單元測試
  - _需求: 1.1, 5.5_

- [ ] 3. 建立 [另一個功能域]
- [ ] 3.1 實作 [子功能] 讀寫功能
  - 建立 [管理器] 介面與基本實作
  - 實作 [具體功能] 的讀取與寫入功能
  - 建立 [結構驗證] 機制
  - 撰寫 [管理器] 的單元測試
  - _需求: 1.6, 2.8, 3.7, 4.5_

- [-] 4. 建立系統文件與部署配置
- [ ] 4.1 撰寫使用者文件與 API 文件
  - 建立使用者操作手冊
  - 撰寫 API 參考文件
  - 建立故障排除指南
  - 建立最佳實踐指引

- [ ] 4.2 建立部署與配置管理
  - 建立專案打包與部署腳本
  - 實作配置管理與環境設定
  - 建立監控與日誌配置
  - 撰寫部署文件與操作指南
```

### 英文格式模板

```markdown
# Implementation Plan

- [x] 1. Establish project foundation and core interfaces
  - Set up [technology stack] project structure and configuration
  - Define core interfaces and type definitions
  - Set up testing environment and TDD toolchain
  - _Requirements: 1.1, 2.1, 3.1, 4.1, 5.1_

- [ ] 2. Implement [functional domain]
- [x] 2.1 Build [sub-feature] core functionality
  - Write [component] interface and basic implementation
  - Implement [specific function] identification logic
  - Establish [validation mechanism]
  - Write unit tests for [component]
  - _Requirements: 1.1, 2.1, 3.1, 4.1_

- [x] 2.2 Implement [sub-feature] processing and validation
  - Build [processing logic] and validation logic
  - Implement error handling and user feedback mechanism
  - Write unit tests for [feature] processing
  - _Requirements: 1.1, 5.5_

- [ ] 3. Build [another functional domain]
- [ ] 3.1 Implement [sub-feature] read/write functionality
  - Build [manager] interface and basic implementation
  - Implement [specific function] read and write functionality
  - Establish [structure validation] mechanism
  - Write unit tests for [manager]
  - _Requirements: 1.6, 2.8, 3.7, 4.5_

- [-] 4. Build system documentation and deployment configuration
- [ ] 4.1 Write user documentation and API documentation
  - Build user operation manual
  - Write API reference documentation
  - Build troubleshooting guide
  - Build best practices guide

- [ ] 4.2 Build deployment and configuration management
  - Build project packaging and deployment scripts
  - Implement configuration management and environment setup
  - Build monitoring and logging configuration
  - Write deployment documentation and operation guide
```

### 任務狀態符號

#### 基本狀態
- `[x]` **已完成** (completed) - 任務完成並通過驗收
- `[ ]` **待執行** (pending) - 任務已規劃但尚未開始
- `[-]` **部分完成** (partially completed) - 任務進行中但未完全完成

#### 擴展狀態（可選）
- `[🔄]` **執行中** (in_progress) - 任務正在進行中
- `[❌]` **阻塞中** (blocked) - 任務遇到障礙暫停
- `[🔁]` **需重做** (rework) - 任務需要返工修正
- `[⚠️]` **有風險** (at_risk) - 任務進度或品質有風險
- `[⏸️]` **暫停** (paused) - 任務暫時停止
- `[🚫]` **已取消** (cancelled) - 任務不再需要執行

### 詳細任務格式模板

```markdown
## [功能域] - [主要任務名稱]

### 任務 ID: [編號]
- **任務名稱**: [具體任務描述]
- **任務描述**: [詳細的功能說明和背景]
- **驗收標準**:
  1. [明確的完成標準1]
  2. [明確的完成標準2]
  3. [明確的完成標準3]
- **BDD+TDD 步驟**:
  1. **Gherkin 場景**: [相關的 Feature 和 Scenario 名稱]
  2. **Step Definitions**: [步驟定義和測試環境設定]
  3. **單元測試**: [具體測試案例和驗證邏輯]
  4. **最小實作**: [實作重點和核心邏輯]
  5. **重構目標**: [最佳化方向和品質目標]
- **依賴關係**: [前置任務清單，格式：任務ID - 任務名稱]
- **預估時間**: [開發時間評估，如：2-3天]
- **風險評估**: [潛在風險和應對措施]
- **技術需求**: [所需技術、工具、框架]
- **狀態**: [x] 已完成
- **完成日期**: [YYYY-MM-DD]
- **備註**: [額外說明或注意事項]
```

### 格式規範

#### 1. 標題層級
- 文件標題：`# 實作計劃` 或 `# Implementation Plan`
- 主任務：無特定標題，直接使用清單格式
- 子任務：使用縮排表示層級關係
- 詳細任務（可選）：`## [功能域] - [主要任務名稱]`

#### 2. 任務狀態格式
- 狀態符號：放在任務編號前，如 `- [x] 1.`
- 狀態一致性：同一專案中使用統一的狀態符號系統
- 狀態更新：及時更新任務狀態反映實際進度

#### 3. 任務編號系統
- 主任務：使用數字編號（1, 2, 3, ...）
- 子任務：使用小數點編號（1.1, 1.2, 2.1, ...）
- 層級縮排：子任務使用適當縮排（2個空格）

#### 4. 任務描述格式
- 簡潔明確：任務名稱應該清晰表達要做什麼
- 動作導向：使用動詞開頭（建立、實作、撰寫、設置等）
- 具體可測：避免模糊的描述，使用可驗證的語言

#### 5. 需求引用格式
- 中文：`_需求: 1.1, 2.1, 3.1_`
- 英文：`_Requirements: 1.1, 2.1, 3.1_`
- 格式：斜體、冒號後空格、逗號分隔、底線結尾

#### 6. BDD+TDD 整合要求
- 每個開發任務都應包含 BDD+TDD 五階段
- 場景先行：基於 Gherkin 場景定義行為需求
- 步驟定義：建立可執行的測試基礎設施
- 測試驅動：撰寫失敗的單元測試
- 最小實作：專注核心功能，避免過度設計
- 重構最佳化：在測試保護下改善代碼品質
- 全程驗證：確保 BDD 場景始終通過

#### 7. 依賴關係表示
- 明確標示：列出所有前置任務
- 順序重要：按依賴順序排列任務
- 並行標示：可並行執行的任務應明確標註

#### 8. 進度追蹤
- 及時更新：任務狀態變更時立即更新文件
- 完成記錄：記錄任務完成日期和關鍵成果
- 阻塞處理：遇到阻塞時詳細記錄原因和解決方案
