# Prompt Engineering Best Practices and References

## Summary
Curated references and a consolidated checklist for prompt engineering with
LLMs and agent assistants, plus guidance on role prompting and known
differences across sources.

## Audience and Scope
- Audience: engineers and prompt designers building reliable prompts or agents.
- Scope: best practices, not model-specific API usage.

## Authoritative References (Link + Summary)

### OpenAI
- https://platform.openai.com/docs/guides/prompt-engineering
  - API prompt engineering guide with patterns for clear instructions,
    examples, output schemas, and iteration. (May require access.)
- https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-the-openai-api
  - Help Center checklist of rules of thumb: instructions first, delimiters,
    specificity, output formatting, and iteration. (May require access.)
- https://github.com/openai/openai-cookbook
  - Practical notebooks covering prompting patterns, tool/agent workflows, and
    verification strategies.

### Anthropic (Claude)
- https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/overview
  - When prompt engineering is the right lever vs switching models or approach.
- https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/best-practices
  - Claude best practices for clarity, constraints, and context use.
- https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering
  - Prompt engineering index for Claude docs and related guides.
- https://github.com/anthropics/claude-cookbooks
  - Claude cookbooks with prompt patterns and agent examples.

### Google (Gemini / Cloud)
- https://ai.google.dev/gemini-api/docs/prompting-strategies
  - Prompt design strategies: clear instructions, structure, few-shot, and
    agentic workflows.
- https://cloud.google.com/discover/what-is-prompt-engineering
  - High-level overview and shared terminology for prompting.
- Gemini for Google Workspace prompting guide (PDF)
  - End-user patterns and examples. (Add link when available.)

### Microsoft (Azure OpenAI)
- https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/prompt-engineering
  - Concrete techniques: clarity, structure, few-shot, output control, and
    iteration.
- https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/use-your-data#best-practices
  - Grounding and RAG best practices for enterprise data.

### Community (Reputable)
- https://www.promptingguide.ai/
  - Broad, regularly updated guide to prompting concepts and techniques.
- https://github.com/dair-ai/Prompt-Engineering-Guide
  - Compendium of techniques, papers, and examples.
- Learn Prompting role prompting page
  - Role/persona prompting guidance. (Add link when available.)

## Consolidated Best Practices Checklist

### A) Specify the job
- State the goal, audience, and definition of good (success criteria).
- Add constraints: length, format, must/must-not, assumptions allowed.

### B) Structure the prompt
- Put instructions first, then context or data.
- Use clear delimiters and consistent sections (Context -> Task -> Constraints
  -> Output -> Examples -> Checks).

### C) Control the output
- Require an explicit output schema (JSON keys, bullets, table columns).
- Set verbosity expectations (e.g., 5 bullets, <= 120 words).

### D) Use examples when format matters
- Include 1-3 examples, and an edge case if relevant.

### E) Reduce ambiguity
- Define key terms and parameters ("risk means X").
- Prefer positive, direct instructions over long prohibitions.

### F) Iterate and brace critical constraints
- Restate critical requirements near the end if drift occurs.

### G) Add self-checks for correctness
- Ask for questions if input is missing or ambiguous.
- Require verification steps or uncertainty flags for high-stakes tasks.

### H) Pick the right lever
- If a prompt is fighting the model, switch model, tools, or approach.

### I) For tools and agents
- Describe each tool in 1-2 sentences: what it does and when to use it.
- Require confirmations for impactful actions.

## Persona / Role Prompting

### Helps when
- You need a specific stance and priorities (e.g., "meticulous reviewer").
- You need a consistent communication pattern (teacher, editor, incident lead).

### Misleads when
- The role implies authority the model does not have.
- The persona replaces clear requirements or invites invented details.

### Rule of thumb
- Use roles to shape tone and priorities, but keep requirements explicit and
  testable.

## Differences and Notes
- Some sources emphasize prompt engineering; others advise switching models or
  system design when prompting is insufficient.
- Google and Microsoft emphasize consistent structure and delimiters; OpenAI
  and Anthropic examples are often lighter weight but still recommend clarity.
- Agent guidance is more explicit in cookbooks and tool-focused docs than in
  generic "prompting 101" pages.
