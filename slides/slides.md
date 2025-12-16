# LLM APIs for Nocode AI Agents
## n8n + OpenAI Integration
### Swiss Cyber Institute
#### 2025

---

<!-- .slide: data-background="#1d1d1d" -->
# AGENDA

| | |
|---|---|
| **01** Triggers | **04** Providers |
| **02** Chat API | **05** Modalities |
| **03** Data Sources | **06** Tips & Practice |

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 02
## TRIGGERS
### What Starts Your Workflow

---

## Triggers

- Known: Manual, Schedule, Webhook
- Integrations: Gmail, Sheets, Databases
- New: Chat trigger, Sub-Workflow

---

## Triggers
**ALREADY KNOW:**
- Manual – Click to run (testing, one-off tasks)
- Schedule – Cron-based (daily at 7am, every hour)
- Webhook – External HTTP call

---

## Triggers
**INTEGRATION TRIGGERS:**
- Email received (Gmail, Outlook)
- Row added (Sheets, Airtable)
- Database change (Postgres, MongoDB)

---

## Triggers
**NEW FOR AI WORKFLOWS:**
- Execute Workflow – Called from another workflow
- Chat Trigger – Conversational AI interface

---

## Chat Trigger (n8n Langchain)

- Purpose: Conversational AI without frontend
- Modes: Hosted Chat / Embedded Widget
- Features: Sessions, AI Agent, Webhooks

---

## Chat Trigger (n8n Langchain)
**PURPOSE:** Create conversational AI apps without frontend code

**TWO MODES:**
1. **Hosted Chat** – n8n provides the UI, you get a URL
2. **Embedded Widget** – Add to your website/app

---

## Chat Trigger (n8n Langchain)
**FEATURES:**
- Session management (remembers conversation)
- Works with AI Agent node
- Webhook-compatible

`docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-langchain.chattrigger/`

---

## BUILD → Hello World Workflow

- Goal: Data flow, branching, merging
- Trigger → Set → IF → Merge

---

## BUILD → Hello World Workflow
**GOAL:** Understand data flow, branching, merging

**STEPS:**
1. Manual Trigger
2. Set node – create sample data
3. IF node – branch based on condition
4. Two paths → different transformations
5. Merge node – combine results

---

## BUILD → Hello World Workflow
**KEY CONCEPTS:**
- Items flow through nodes
- Each node transforms data
- Branching = parallel paths

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 03
## CHAT API
### How LLMs Process Text

---

## Chat API Structure

- System: Persona, rules, context
- User: The request
- Assistant: Model's response

---

## Chat API Structure
| Role | Purpose |
|------|---------|
| **System** | Sets persona, rules, context. Persists across conversation. |
| **User** | The actual request. Can include data from previous nodes. |
| **Assistant** | Model's response. Becomes input for next nodes. |

---

## Chat API Structure
**EXAMPLE:**
```
System: "You are a helpful email summarizer. Be concise."
User: "Summarize this email: [content]"
Assistant: "Here's your summary: ..."
```

---

## Structured Output (JSON Mode)

- Problem: LLM returns unstructured text
- Solution: Request JSON format
- Guaranteed valid, parseable output

---

## Structured Output (JSON Mode)
**THE PROBLEM:**
> LLM returns: "The priority is high and you should reply soon"
> You need: `{ "priority": "high", "action": "reply" }`

---

## Structured Output (JSON Mode)
**THE SOLUTION:**
- Request JSON format in system prompt
- Or use OpenAI's `response_format` parameter
- Guaranteed valid JSON, predictable parsing

```json
{
  "priority": "urgent | important | fyi",
  "summary": "string",
  "action_required": "boolean"
}
```

---

## BUILD → Parse Emails into Summary

- Get emails → Loop → OpenAI summarize
- System prompt: Priority + Summary + Action
- Aggregate results

---

## BUILD → Parse Emails into Summary
**WORKFLOW:**
1. Manual Trigger (later: Schedule)
2. Gmail node – Get today's emails
3. Loop – Process each email
4. OpenAI node – Summarize with system prompt
5. Aggregate – Combine all summaries

---

## BUILD → Parse Emails into Summary
**SYSTEM PROMPT:**
```
You are an email summarizer.
For each email, return:
- Priority: urgent/important/fyi
- One-line summary
- Action needed (if any)
```

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 04
## DATA SOURCES
### Google Workspace Integration

---

## Google Workspace in n8n

| Service | Read | Write |
|---------|------|-------|
| **Gmail** | Get emails, filter by date/label | Send, mark read, add labels |
| **Calendar** | Get events, find free slots | Create/update events |
| **Sheets** | Read rows | Append, update cells |
| **Docs** | Read content | Create, append |
| **Drive** | List files, search | Upload, download |

---

## BUILD → Parse Calendar into Summary

- Calendar → Format → OpenAI → Summary
- Output: Readable daily schedule

---

## BUILD → Parse Calendar into Summary
**WORKFLOW:**
1. Google Calendar – Get today's events
2. Code node – Format event list
3. OpenAI – Generate readable schedule
4. Set – Structure output

---

## BUILD → Parse Calendar into Summary
**OUTPUT EXAMPLE:**
```
Today: 4 meetings
10am-12pm: Back-to-back
Lunch: 12:30-1:30 (free)
Prep needed for 3pm client call
```

---

## BUILD → Log Summaries to Sheets

- Why: Searchable history, track patterns
- Summaries → Transform → Append to Sheets

---

## BUILD → Log Summaries to Sheets
**WHY LOG TO SHEETS?**
- Searchable history
- Track patterns over time
- Data for future automations

**COLUMNS:**
`Date | Sender | Subject | Summary | Priority | Action`

---

## BUILD → Log Summaries to Sheets
**WORKFLOW:**
1. Previous email summaries
2. Code node – Transform to rows
3. Google Sheets – Append rows

---

## BUILD → Daily Digest Document

- Combine: Emails + Calendar + Actions
- Merge → OpenAI → Google Docs

---

## BUILD → Daily Digest Document
**COMBINE EVERYTHING:**
- Email summary + Calendar overview + Action items

**WORKFLOW:**
1. Merge node – Combine email + calendar data
2. OpenAI – Generate formatted digest
3. Google Docs – Create/append document

---

## BUILD → Daily Digest Document
```markdown
## Today's Schedule
[Calendar summary]

## Email Highlights
[Priority emails]

## Action Items
[Tasks extracted]
```

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 05
## PROVIDERS
### Choosing Your LLM

---

## LLM Providers in n8n

| Provider | Models | Best For |
|----------|--------|----------|
| **OpenAI** | GPT-5.2, o1 | General purpose, vision |
| **Anthropic** | Claude 4.5 | Long context, coding, safety |
| **Google** | Gemini 3 | Multimodal, speed, cost |
| **OpenRouter** | All models | Model switching, fallbacks |
| **n8n Credits** | (OpenAI) | Free tier, getting started |

---

## Structured Output with JSON Schema

- Guaranteed format, no parsing errors
- Type validation across providers
- Tip: Limit to 3 tasks max

---

## Structured Output with JSON Schema
**WHY SCHEMAS?**
- Guaranteed format (no parsing errors)
- Type validation
- Works with all major providers

---

## Structured Output with JSON Schema
```json
{
  "tasks": [
    {
      "title": "Review proposal",
      "priority": 1,
      "duration_mins": 30,
      "source": "email from John"
    }
  ]
}
```

**TIP:** Limit to 3 tasks to avoid calendar overload

---

## BUILD → Email Tasks to Calendar

- Extract tasks from emails
- Find free slots → Schedule events
- Structured output is critical

---

## BUILD → Email Tasks to Calendar
**THE IDEA:** Emails contain hidden tasks. Extract them, find free time, schedule automatically.

**WORKFLOW:**
1. Gmail – Get important unread emails
2. OpenAI – Extract tasks (structured output!)
3. Filter – Keep top 3 by priority
4. Google Calendar – Find free slots
5. Google Calendar – Create events

---

## BUILD → Email Tasks to Calendar
 **Structured output is key** – without it, you can't reliably parse task properties

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 06
## MODALITIES
### Beyond Text: Image, Video, Audio

---

## LLM Modalities

| Direction | Examples |
|-----------|----------|
| **Text → Text** | Chat completions (GPT-5.2, Claude, Gemini) |
| **Image → Text** | Vision, OCR, describe images |
| **Text → Image** | Nano Banana |
| **Text → Video** | Sora, Veo (limited API access) |
| **Text ↔ Audio** | Whisper, TTS, voice mode |

---

## Current SOTA Models (2025)

- Text: GPT-5.2, Claude 4.5, Gemini 3
- Images: Nano Banana
- Video: Sora, Veo
- Audio: Whisper, GPT-4o voice

---

## Current SOTA Models (2025)
**TEXT:** GPT-5.2, Claude 4.5, Gemini 3

---

## Current SOTA Models (2025)
**IMAGE GENERATION:** Nano Banana (old: Midjourney)

---

## Current SOTA Models (2025)
**VIDEO:** Sora (OpenAI), Veo (Google)

---

## Current SOTA Models (2025)
**AUDIO:** Whisper (transcription), GPT-4o voice mode

 *This changes fast. Check provider docs.*

---

## BUILD → Image of the Day

- Generate image based on day's theme
- Digest → Prompt → Nano Banana → Drive

---

## BUILD → Image of the Day
**THE IDEA:** Based on your day's theme, generate an inspiring image.

**WORKFLOW:**
1. Previous workflow – Get digest summary
2. OpenAI – Generate image prompt from summary
3. Nano Banana – Generate image
4. Google Drive – Save to folder
5. Return URL – For embedding in digest

---

## BUILD → Image of the Day
**PROMPT:**
> "Based on today's schedule about [topic], create an image prompt. Style: minimal, professional, inspiring."

---

<!-- .slide: data-background="#1d1d1d" class="section-header" -->
# 07
## TIPS & PRACTICE
### Building Better Workflows

---

## Handling Errors

**ERROR OUTPUT (the red dot)**
- Every node has an error output
- Route failures to: logging, alerts, fallback

**COMMON PATTERN:**
```
[Node] → success → continue
      → error   → Slack alert + log to Sheets
```

**RULE:** Don't let workflows fail silently

---

## Running Workflows

- Test Mode: Run each node separately
- Production Mode: Run all together
- Partial Execution: Pin data to test downstream

---

## Running Workflows
**TEST MODE (Run Each Separately)**
- Click each node to test
- See data at each step
- Great for debugging

---

## Running Workflows
**PRODUCTION MODE (Run All Together)**
- Execute from trigger
- Full end-to-end
- Test before activating!

---

## Running Workflows
**PARTIAL EXECUTION**
- Pin data at any node
- Test downstream without re-fetching
- Saves API calls during development

---

## BUILD → Pick Random File from Drive

- Use: Random videos, quotes, rotating content
- List files → Pick random → Download

---

## BUILD → Pick Random File from Drive
**USE CASES:** Random video, quote image, rotating content

**WORKFLOW:**
1. Google Drive – List files in folder
2. Code node – Pick random item
3. Google Drive – Download file
4. Output – Use in next step

---

## BUILD → Pick Random File from Drive
```javascript
const items = $input.all();
const random = items[Math.floor(Math.random() * items.length)];
return [random];
```

---

## What Else Could We Build?

- Slack standup bot, Auto-reply emails
- Meeting notes → tasks
- Voice → text → email
- Screenshot → ticket

---

## What Else Could We Build?
**WITH WHAT WE LEARNED:**
- Slack daily standup bot
- Auto-reply to specific emails
- Meeting notes → action items → tasks
- Weekly report generator

---

## What Else Could We Build?
**COMBINING MODALITIES:**
- Voice memo → transcribe → summarize → email
- Screenshot → extract text → create ticket

 **Your turn: What would YOU automate?**

---

<!-- .slide: data-background="#1d1d1d" -->
# Questions?

 **Resources:**
- n8n Docs: `docs.n8n.io`
- OpenAI API: `platform.openai.com`
- Chat Trigger: `docs.n8n.io/.../chattrigger`

**Swiss Cyber Institute • 2025**