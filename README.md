# ChatBot for iOS 📱🤖

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS_17.0+-lightgrey.svg?style=flat" alt="Platform iOS">
  <img src="https://img.shields.io/badge/Language-Swift-orange.svg?style=flat" alt="Language Swift">
  <img src="https://img.shields.io/badge/UI-SwiftUI-green.svg?style=flat" alt="UI SwiftUI">
</p>

**ChatBot for iOS** 是一款专为 iOS 原生生态打造的纯粹 LLM 客户端。它不依赖庞杂的第三方框架，通过 100% SwiftUI 实现了极致顺滑的交互体验，是您随身携带的高性能 AI 助理终端。

无论是处理超长文本流、深入的逻辑推理还是多模态交互，它都能在 iPhone 和 iPad 上提供稳定且美观的体验。

---

## 🔥 核心特性

### 1. 极致性能与原生渲染

- **🚀 零卡顿的流式架构 (OOM-Free Streaming)**
  - 针对长时对话和超大文本（10 万字级别）输出重写了底层流式驱动。
  - 通过包裹 `autoreleasepool` 和精准限频，彻底杜绝高频更新导致的内存泄漏（OOM）问题。
- **📝 桌面级 Markdown 与 LaTeX**
  - 内置极速解析引擎，支持复杂的代码块高亮、表格渲染。
  - 原生无缝支持复杂嵌套 LaTeX 数学公式渲染。
- **🧠 优雅的“深度思考”界面**
  - 完美兼容输出心智推理过程的模型。
  - **自动折叠与隔离**：自动捕获底层流中的 `<think>` 或 `<thought>` 思考块，将其收纳在气泡顶部的专属灰色胶囊内，保持主干回复的绝对纯净。

### 2. 多屏且沉浸的原生 UX

- **👆 纯净的交互体验**
  - **动态抽屉侧边栏**：精心调校的手势方向锁（Directional Lock），确保全屏左右滑动唤醒侧边栏时，不会与上下滚动聊天记录发生冲突。
  - **全局 Haptic 反馈**：所有的微交互（复制文本、中断响应、清空聊天）均配有清脆的触觉震动和 `withAnimation` 转场动画。
- **🎨 高度自由的个性化**
  - 支持绑定自定义的用户昵称，并直接通过系统相册挑选照片设置为专属头像（App 内建极速压图降采样技术）。
- **🛠 全面消息控制**
  - **原地编辑并重试**：点击任意历史气泡即可快速修改 Prompt 重新提问，丢弃错误路线。
  - 一键复制格式化文本、随时打断冗长生成。

### 3. 多模态与全面开放的生态

- **📷 原生 Vision 视觉支持**
  - 深度调用系统相册与相机，一键拍图或选图发送。
  - 自动在客户端进行 Base64 高效编码与尺寸裁剪，投喂给具备视觉能力的云端模型。
- **🌍 一站式 API 代理枢纽**
  - **自由配置端点**：内置海量国内外主流模型平台预设，支持一键切换。
  - 无论是 OpenAI 兼容格式、Anthropic 标准还是自定义的反向代理池，只需填入 BaseURL 和 API Key 即可接管全世界。

### 4. ☁️ 云端同步与检索记忆

- **R2/Cloudflare 云端备份**
  - 自由绑定您的私有 JSON 配置服务器端点，实现 API 密钥、会话缓存以及偏好设置的安全云备份与跨设备恢复。
- **RAG 向量数据库语义挂载**
  - 接入 Cloudflare Workers AI 等 Embedding 模型节点。
  - 自动生成所聊内容的动态向量空间（768/1024/1536 维度自适应适配），赋予 AI 过目不忘的语义关联能力。

---

## 🚀 安装与部署

为保障极高的隐私安全与灵活性，本开源项目**移除了 Xcode 工程配置文件（`.xcodeproj`）**。我们推荐直接使用预编译包进行体验。

### 方式一：直接安装 (IPA)

我们提供了预编译的 `.ipa` 文件，这是最简单快捷的安装方式。

1. 前往本仓库的 **[Releases]** 页面下载最新版本的 `ChatBot.ipa` 文件。
2. 使用 **TrollStore** (推荐永久版)、**AltStore**、**Sideloadly** 或 **爱思助手** 等第三方侧载工具，签名并安装至您的 iPhone 或 iPad。

### 方式二：源码编译 (Xcode)

如果您需要亲自审查代码或进行二次开发，可以手动从源码构建：

1. **环境准备**: macOS + Xcode 15+ + iOS 17.0+ 设备。
2. **克隆代码**: 
   ```bash
   git clone https://github.com/Yamada-Ryo4/ChatBot-iOS.git
   ```
3. **新建工程**: 
   - 打开 Xcode，新建一个干净的 **iOS App** 项目（界面选 SwiftUI）。
   - 删除新建项目自动生成的 `ContentView.swift` 与 `App.swift`。
4. **导入源码**:
   - 将克隆下来的 `ChatBot/` 源码目录（包含 Models、ViewModels、Views 等全部核心逻辑）直接拖入您的新工程中。
5. **签名与编译**:
   - 在 **Signing & Capabilities** 页面登录您的个人 Apple Developer 账户并签名。
   - 按下 `⌘R` 在真机或模拟器上运行即可。

---

## ⚙️ 初始使用配置指南

1. **启动与唤醒**: 首次打开 App，向右轻扫屏幕左边缘唤醒隐藏的全局侧边栏。
2. **配置服务商**: 点击左下角的 **⚙️ 设置 (Settings)** 进入配置页。
3. **激活 API**: 
   - 找到您感兴趣的模型服务商模块。
   - 填入该服务商对应的 `Base URL`（如果有代理）以及您的私人 `API Key`。
4. **开始对话**: 回到首页，点击聊天框开始探索。

---

## ⚠️ 免责声明 (Disclaimer)

- 本项目仅作为移动端图形界面调用工具，不提供任何内建的 AI 离线模型实体或默认免费 API 密钥。
- 请妥善保管您在应用内填写的私有 API Key，项目代码承诺不在任何隐藏处窃取或上传您的配置至第三方服务器。

## 📄 License

MIT License
