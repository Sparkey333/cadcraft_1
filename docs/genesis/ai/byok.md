# BYOK: bring your own key, any model

> **Last reviewed:** 2026-10-21 · **Last updated:** 2026-10-21 · **Change:** major (first version) · **Scope:** CADCraft (#1) today and Genesis (#4) by design

Both apps should let the user plug in their own AI account rather than ship one: the user picks a
provider, pastes a key once, chooses a model per task, and can switch or run several side by side.
This page lists the providers, where to get a key, the wire protocol each speaks, a proposed
configuration file, the privacy rules, and how the choice feeds the iteration log in
`training/iterations/`. It is documentation and data; it changes nothing in CADCraft's code.

## How it applies to each product

| | CADCraft (#1, original) | Genesis (#4, new) |
|---|---|---|
| Where the AI lives today | Outside the app: any MCP client (Claude Desktop, Claude Code, LM Studio, Cursor and others) connects to `cadcraft-cli mcp` with the client's own provider account. BYOK is therefore the client's setting | Planned in-app assistant that reads `providers.toml` (below) and the knowledge pack, and drives the same commands over the internal command registry |
| What to add now (no code change) | This guide, the `providers.toml` proposal, the knowledge cards as system-prompt material for whichever client is used | The same, as the specification the assistant is built to |
| Later, owner's decision | A `providers.toml` reader and an `assistant` command that routes to the configured provider; an MCP resource exposing the knowledge pack | Built in from the first release |

## Providers, keys and endpoints

URLs and endpoints are the editor's reading on 2026-10-21; providers move console pages, so if a link
404s, start from the provider's docs link in the last column. Model names are deliberately not
listed for non-Anthropic providers: ask each provider's models endpoint (for OpenAI-compatible
APIs, `GET /v1/models`) because they change monthly.

| Provider | Wire kind | Get a key | Endpoint | Auth | Env var | Notes |
|---|---|---|---|---|---|---|
| Anthropic (Claude) | anthropic-messages | https://console.anthropic.com/settings/keys | https://api.anthropic.com/v1/messages | header `x-api-key: <key>` plus `anthropic-version: 2023-06-01`; or an OAuth profile from `ant auth login` | ANTHROPIC_API_KEY | Current model IDs: `claude-opus-5-5` (default for most work), `claude-sonnet-5-5`, `claude-haiku-5-5` (cheap worker), `claude-fable-5-1` (most capable). Claude Desktop and Claude Code already drive CADCraft over MCP with the user's own account. Docs: https://platform.claude.com/docs |
| OpenAI | openai-chat | https://platform.openai.com/api-keys | https://api.openai.com/v1/chat/completions (also /v1/responses) | header `Authorization: Bearer <key>` | OPENAI_API_KEY | List models with `GET /v1/models`. Docs: https://platform.openai.com/docs |
| Google Gemini (AI Studio) | gemini (or openai-chat via the compatibility endpoint) | https://aistudio.google.com/apikey | https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent; OpenAI-compatible: https://generativelanguage.googleapis.com/v1beta/openai/ | header `x-goog-api-key: <key>` (Bearer on the compatibility endpoint) | GEMINI_API_KEY | Free tier exists with usage limits. Docs: https://ai.google.dev/gemini-api/docs |
| Mistral | openai-chat | https://console.mistral.ai/api-keys | https://api.mistral.ai/v1/chat/completions | Bearer | MISTRAL_API_KEY | EU-hosted option. Docs: https://docs.mistral.ai |
| xAI (Grok) | openai-chat | https://console.x.ai/ | https://api.x.ai/v1/chat/completions | Bearer | XAI_API_KEY | Docs: https://docs.x.ai |
| DeepSeek | openai-chat | https://platform.deepseek.com/api_keys | https://api.deepseek.com/chat/completions | Bearer | DEEPSEEK_API_KEY | Low cost; data residency in China: do not send client drawings without a policy decision. Docs: https://api-docs.deepseek.com |
| Groq | openai-chat | https://console.groq.com/keys | https://api.groq.com/openai/v1/chat/completions | Bearer | GROQ_API_KEY | Very fast open-weight models; good for the cheap worker role. Docs: https://console.groq.com/docs |
| OpenRouter | openai-chat | https://openrouter.ai/settings/keys | https://openrouter.ai/api/v1/chat/completions | Bearer | OPENROUTER_API_KEY | One key, many vendors' models; useful for cross-model comparisons. Docs: https://openrouter.ai/docs |
| Together AI | openai-chat | https://api.together.ai/settings/api-keys | https://api.together.xyz/v1/chat/completions | Bearer | TOGETHER_API_KEY | Open-weight models. Docs: https://docs.together.ai |
| Fireworks AI | openai-chat | https://fireworks.ai/account/api-keys | https://api.fireworks.ai/inference/v1/chat/completions | Bearer | FIREWORKS_API_KEY | Open-weight models. Docs: https://docs.fireworks.ai |
| Cohere | cohere | https://dashboard.cohere.com/api-keys | https://api.cohere.com/v2/chat | Bearer | CO_API_KEY | Strong retrieval/rerank endpoints for the knowledge pack. Docs: https://docs.cohere.com |
| Hugging Face Inference | openai-chat | https://huggingface.co/settings/tokens | https://router.huggingface.co/v1/chat/completions | Bearer | HF_TOKEN | Thousands of open models; token scopes matter. Docs: https://huggingface.co/docs/inference-providers |
| Microsoft Foundry (Azure) | azure (OpenAI-style) / anthropic-messages for Claude on Foundry | https://ai.azure.com (keys live on the deployed resource; portal https://portal.azure.com) | https://<resource>.openai.azure.com/... or the Foundry endpoint of the deployment | header `api-key: <key>` or Entra ID | AZURE_OPENAI_API_KEY / AZURE_API_KEY | Enterprise contracts and data residency; Claude is available on Foundry at standard rates. Docs: https://learn.microsoft.com/azure/ai-foundry/ |
| Amazon Bedrock | bedrock (SigV4) | https://console.aws.amazon.com/iam/ (access keys) and https://console.aws.amazon.com/bedrock/ (model access) | Bedrock runtime endpoints per region; Claude through the Bedrock Mantle client | AWS SigV4 with `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` or an IAM role | AWS_ACCESS_KEY_ID | Partner-operated pricing. Docs: https://docs.aws.amazon.com/bedrock/ |
| Google Cloud Vertex AI | vertex (ADC) | https://console.cloud.google.com/vertex-ai (enable the API; `gcloud auth application-default login`) | regional Vertex endpoints; Claude and Gemini models | Google Application Default Credentials, no API key | GOOGLE_APPLICATION_CREDENTIALS | Partner-operated pricing. Docs: https://cloud.google.com/vertex-ai/generative-ai/docs |
| Ollama (local) | openai-chat | no key: install from https://ollama.com/download | http://localhost:11434/v1/chat/completions | none |  | Runs open-weight models on the user's machine; the clean-room-safe default for firms that cannot send drawings to a cloud. Docs: https://docs.ollama.com |
| LM Studio (local) | openai-chat | no key: install from https://lmstudio.ai/ | http://localhost:1234/v1/chat/completions | none |  | Desktop app with an OpenAI-compatible server and an MCP client; can drive CADCraft's MCP server directly. Docs: https://lmstudio.ai/docs |
| llama.cpp / vLLM (self-hosted) | openai-chat | no key by default: https://github.com/ggml-org/llama.cpp and https://docs.vllm.ai/ | http://<host>:8080/v1/chat/completions (llama.cpp) or http://<host>:8000/v1/... (vLLM) | optional Bearer set by the operator |  | For an office server shared by several seats |

Wire kinds (what the client code must speak): `anthropic-messages` (Claude), `openai-chat`
(OpenAI and everything that copies its chat-completions shape, including most local servers),
`gemini`, `cohere`, `bedrock` (SigV4), `vertex` (Google ADC), `azure`. An implementation needs
only `anthropic-messages` and `openai-chat` to cover the table above, plus the Gemini
compatibility endpoint.

Minimal request shapes, for checking a key from a terminal (replace the model with one the
provider lists):

```sh
# Anthropic
curl https://api.anthropic.com/v1/messages \
  -H "Content-Type: application/json" -H "x-api-key: $ANTHROPIC_API_KEY" -H "anthropic-version: 2023-06-01" \
  -d '{"model":"claude-opus-5-5","max_tokens":16000,"messages":[{"role":"user","content":"Say hello."}]}'

# Any OpenAI-compatible provider (OpenAI, Groq, Mistral, xAI, DeepSeek, OpenRouter, Together, Ollama, LM Studio)
curl "$BASE_URL/chat/completions" \
  -H "Content-Type: application/json" -H "Authorization: Bearer $API_KEY" \
  -d '{"model":"<model-id>","messages":[{"role":"user","content":"Say hello."}]}'
```

## Proposed configuration file

```toml
# ~/.config/cadcraft/ai/providers.toml  (Windows: %APPDATA%\CADCraft\ai\providers.toml)
# Proposed format for the onboard assistant of CADCraft (later) and Genesis (from the start).
# Keys are never written here in plain text when a keychain is available; `api_key_env` names an
# environment variable, `keychain` names an OS credential entry. Nothing in this file is sent to a
# provider except the request itself.

[default]
provider = "anthropic"
model = "claude-opus-5-5"
effort = "medium"           # low | medium | high for providers that support it
max_output_tokens = 16000
timeout_seconds = 600
redact_logs = true          # keys and drawing paths are masked in every log line

[providers.anthropic]
kind = "anthropic-messages"
base_url = "https://api.anthropic.com"
api_key_env = "ANTHROPIC_API_KEY"      # or: keychain = "cadcraft/anthropic"
models = ["claude-opus-5-5", "claude-sonnet-5-5", "claude-haiku-5-5", "claude-fable-5-1"]

[providers.openai]
kind = "openai-chat"
base_url = "https://api.openai.com/v1"
api_key_env = "OPENAI_API_KEY"

[providers.gemini]
kind = "openai-chat"
base_url = "https://generativelanguage.googleapis.com/v1beta/openai"
api_key_env = "GEMINI_API_KEY"

[providers.openrouter]
kind = "openai-chat"
base_url = "https://openrouter.ai/api/v1"
api_key_env = "OPENROUTER_API_KEY"

[providers.ollama]
kind = "openai-chat"
base_url = "http://localhost:11434/v1"
api_key_env = ""                       # local, no key
offline = true

# Which model answers which kind of request. A role names "provider/model".
[routing]
command_help   = "anthropic/claude-haiku-5-5"     # "how do I offset a polyline?"
drawing_review = "anthropic/claude-opus-5-5"      # "check this site plan against the rule sheet"
long_plan      = "anthropic/claude-fable-5-1"     # multi-step agent runs over MCP
offline        = "ollama/<local-model>"           # when the network policy forbids cloud calls
compare_with   = ["openai/<model>", "gemini/<model>", "openrouter/<vendor/model>"]   # cross-model runs for the iteration log

[privacy]
send_drawing_geometry = "ask"     # never | ask | always: whether entity data may leave the machine
send_file_paths = false
allowed_providers_for_client_work = ["anthropic", "ollama"]   # per-firm policy

```

Rules the implementation must keep:

- **Keys live in the OS keychain** (Windows Credential Manager, macOS Keychain, Linux Secret
  Service) or in environment variables; never in a drawing, a project container, a template, or a
  file that could be committed. `providers.toml` holds names, not secrets.
- **Nothing leaves the machine without a policy.** `send_drawing_geometry` defaults to `ask`;
  firms doing client work set `allowed_providers_for_client_work`. Local providers (Ollama, LM
  Studio, llama.cpp, vLLM) satisfy the strictest policy.
- **Every call is logged with the key redacted**: provider, model, purpose (role), token counts,
  latency, cost estimate, and the commands the assistant ran. That log is the raw material for the
  iteration records below.
- **The assistant uses the same commands as the user** (the command registry over MCP or the
  internal API), never a private path, so anything it does is reproducible and undoable.
- **Clean-room still applies**: no provider is asked to reproduce Autodesk or Bricsys material,
  and nothing it returns is pasted into the repository without a human reading it.

## Using the knowledge pack with each provider

1. System prompt: the relevant knowledge cards (`knowledge/cadcraft-facts.md`,
   `knowledge/cadcraft-referencing.md`, and for site work `knowledge/landdev-domain.md`), plus the
   command catalogue from `cadcraft-cli commands` or the MCP `list_commands` tool.
2. Retrieval: `training/facts.jsonl` indexed by any embedding provider in the table (Cohere and
   OpenAI have embedding endpoints; Ollama serves local embedding models).
3. Evaluation: run `training/qa.jsonl` against each configured model and record the scores in
   `training/iterations/`; the comparison table there shows which model earns which role in
   `[routing]`.

## Recording and training on iterations, per AI and between AIs

Every assistant run, from any provider, appends one record to `training/iterations/<date>-<topic>.jsonl`
(schema in `training/iterations/schema.json`). Records are per model, so each AI's history can be
reviewed on its own; `training/iterations/comparisons.md` sets the same tasks side by side so the
models can be compared on citations, status agreement with the facts file, hallucinations, time
and cost. The loop is: record, review, distil the corrections into the knowledge cards and
`qa.jsonl`, re-run the evaluation, update the routing table. The first records, from the session
that built this pack, are in `training/iterations/2026-10-21-genesis-comparison.jsonl`.
