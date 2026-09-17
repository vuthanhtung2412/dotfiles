---
name: knowledge-based
description: Retrieves answers from the user's personal knowledge base at ~/knowledge_based (Atomic Notes). Use when the user asks questions that might be answered by their notes, mentions their knowledge base, Atomic Notes, or wants the agent to "check my notes" before answering.
---

# Knowledge Based (Atomic Notes)

## Scope

- Knowledge base root: `~/knowledge_based`
- Retrieval guide: `~/knowledge_based/3 atomic Notes/AGENTS.md`
- Notes format: plain text / Markdown
- Note update rule: **only create/update notes if the user explicitly asks**

## Default behavior (must-follow)

1. **Search notes first**
   - Use a few keyword queries and synonyms.
   - Prefer matches in filename/title/headings over body text.
   - If the note is very short and the title contains the key idea, do not ignore it.

2. **Rank + select**
   - Select up to **5** most relevant notes.
   - Rank by filename relevance, then heading/title matches, then body matches.

3. **Answer using the notes**
   - Be concise and faithful; **do not invent** explanations beyond what’s written.
   - If notes conflict, describe the conflict rather than choosing a side.
   - If notes are ambiguous, say so explicitly.

4. **Cite sources**
   - Always include: `According to your notes (\`filename.md\`)...`
   - Include short excerpts only when needed to support the claim.

5. **Fallback**
   - If no relevant notes exist, then answer from general knowledge.
   - If the user requests, use web search; otherwise keep it general.

## How to search the knowledge base

- Use `Grep` with:
  - **path**: `~/knowledge_based`
  - **pattern**: keyword (case-insensitive)
  - **glob**: `*.md`
  - Run multiple queries for synonyms/related terms.
- Use `Glob` to locate candidate files when you suspect a filename/topic pattern.
- Use `Read` to open only the most relevant matches (up to 5 files).
- If no response found with cursor tools feel free to use command line tools 

## Response template

Use this structure for most answers:

```markdown
According to your notes (`note-1.md`, `note-2.md`)...

- Key point 1
- Key point 2

If relevant notes conflict:
- `note-a.md`: <summary>
- `note-b.md`: <summary>
```

## Clarification rule

If the user’s question is unclear:
- Still search the notes first.
- Then ask **one** clarifying question and include which notes you checked (if any).

