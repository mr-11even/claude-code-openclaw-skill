# Claude Code Agent Skill

通过 OpenClaw 调用 Claude Code 执行编程任务。支持单次执行、子代理（Sub-agents）和 Agent Teams 模式。

## 激活条件

当用户提到以下内容时使用：
- "调用 claude code"、"用 claude code"、"run claude code"
- "claude -p"、"headless mode"
- "subagent"、"子代理"
- "agent team"、"多代理"

## 前置要求

1. Claude Code CLI 已安装：`curl -fsSL https://claude.ai/install.sh | bash`
2. 已登录：`claude auth login`
3. 环境变量已配置（ANTHROPIC_API_KEY 等）

## 使用方法

### 1. 单次执行 (Headless Mode)

\`\`\`bash
claude -p "你的任务描述" [选项]
\`\`\`

常用选项：
- \`--allowedTools "Read,Edit,Bash"\` - 自动批准的工具
- \`--output-format json\` - JSON 格式输出
- \`--model sonnet|opus|haiku\` - 指定模型

### 2. Sub-agents 模式

创建专用子代理处理特定任务。子代理定义在 \`~/.claude/agents/\` 目录。

### 3. Agent Teams 模式

启用方式：在 \`~/.claude/settings.json\` 中添加：
\`\`\`json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
\`\`\`

使用方式：描述任务和团队结构，Claude Code 自动创建和管理团队。

## OpenClaw 集成

此 skill 提供以下功能：
1. 检查 Claude Code 安装状态
2. 执行单次任务
3. 创建/管理子代理
4. 启用 Agent Teams

## 示例

### 单次任务执行
\`\`\`bash
# 简单任务
claude -p "解释这段代码做什么" --allowedTools "Read"

# 复杂任务
claude -p "修复 auth.py 中的登录 bug" --allowedTools "Read,Edit,Bash" --output-format json

# 指定模型
claude -p "代码审查" --model sonnet
\`\`\`

### Sub-agent 创建
\`\`\`bash
# 交互式创建
claude --agents

# 或手动创建 ~/.claude/agents/code-reviewer.md
\`\`\`

### Agent Teams
\`\`\`bash
# 启用后，描述任务
claude -p "创建一个团队：UX 设计师、技术架构师、代码审查员，共同设计新功能"
\`\`\`

## 注意事项

- Headless 模式不支持交互式技能（如 /commit）
- Sub-agents 和 Agent Teams 需要 Claude Code v2.1.32+
- Agent Teams 目前是实验性功能
- 令牌消耗：Sub-agents < Agent Teams < 单独会话

## 相关文档

- [Claude Code 官方文档](https://code.claude.com/docs/)
- [Headless 模式](https://code.claude.com/docs/en/headless.md)
- [Sub-agents](https://code.claude.com/docs/en/sub-agents.md)
- [Agent Teams](https://code.claude.com/docs/en/agent-teams.md)
