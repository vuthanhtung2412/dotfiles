#!/usr/bin/env bash
set -euo pipefail

OWNER_REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"
PR_NUM="${2:-$(gh pr view --json number -q .number)}"
OWNER="${OWNER_REPO%%/*}"
REPO="${OWNER_REPO##*/}"

{
  echo "# PR #${PR_NUM} discussion"
  echo
  echo "- repo: ${OWNER_REPO}"
  echo "- pr: $(gh pr view "$PR_NUM" --json url -q .url)"
  echo

  echo "## Timeline comments"
  echo
  gh api "repos/${OWNER_REPO}/issues/${PR_NUM}/comments" --paginate \
  | jq -r '
    sort_by(.created_at)
    | .[]
    | "### \( .user.login ) — \( .created_at )\n\( .html_url )\n\n\( .body )\n\n---\n"
  '

  echo
  echo "## Unresolved reviews"
  echo
  # Resolution lives on reviewThreads (GraphQL only); REST comments lack isResolved.
  gh api graphql --paginate \
    -f owner="$OWNER" \
    -f repo="$REPO" \
    -F pr="$PR_NUM" \
    -f query='
      query($owner: String!, $repo: String!, $pr: Int!, $endCursor: String) {
        repository(owner: $owner, name: $repo) {
          pullRequest(number: $pr) {
            reviewThreads(first: 100, after: $endCursor) {
              pageInfo { hasNextPage endCursor }
              nodes {
                isResolved
                path
                line
                comments(first: 100) {
                  nodes {
                    author { login }
                    body
                    createdAt
                    url
                    diffHunk
                  }
                }
              }
            }
          }
        }
      }
    ' \
  | jq -sr '
    [
      .[].data.repository.pullRequest.reviewThreads.nodes[]?
      | select(.isResolved == false)
    ]
    | sort_by(.path, (.line // 0))
    | group_by(.path)
    | .[]
    | "### " + .[0].path + "\n\n" +
      (
        map(
          (.line) as $line
          | (.comments.nodes) as $cs
          | ($cs[0].diffHunk // "") as $hunk
          | (
              $cs
              | to_entries
              | map(
                  .key as $i
                  | .value
                  | "- **" + (.author.login // "ghost") + "** — " + .createdAt +
                    (if $line then " (line " + ($line|tostring) + ")" else "" end) +
                    "\n  " + .url +
                    "\n\n  " + (.body|gsub("\r";"")|gsub("\n";"\n  ")) + "\n\n" +
                    (if $i == 0 and $hunk != "" then
                      "  ```diff\n  " + ($hunk|gsub("\r";"")|gsub("\n";"\n  ")) + "\n  ```\n\n"
                    else
                      ""
                    end)
                )
              | join("")
            )
          + "---\n"
        ) | join("\n")
      )
  '
}
