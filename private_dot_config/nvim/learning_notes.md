# Learning notes

<!--toc:start-->
- [Learning notes](#learning-notes)
  - [Useful Lazyvim command that I learnt](#useful-lazyvim-command-that-i-learnt)
  - [Useful gesture for a standard text editor](#useful-gesture-for-a-standard-text-editor)
    - [DB](#db)
    - [Tmux window switch](#tmux-window-switch)
    - [Open telescope select in a split](#open-telescope-select-in-a-split)
    - [Hurl](#hurl)
    - [How to navigate with Harpoon](#how-to-navigate-with-harpoon)
    - [How to replace with grug-far](#how-to-replace-with-grug-far)
    - [Git](#git)
      - [Keymaps](#keymaps)
      - [LazyGit](#lazygit)
    - [Obsidian](#obsidian)
      - [Things to do](#things-to-do)
  - [Lazy set up sequence](#lazy-set-up-sequence)
  - [Lazy `config` vs `opts`](#lazy-config-vs-opts)
  - [Window split Lazyvim](#window-split-lazyvim)
<!--toc:end-->

## Useful Lazyvim command that I learnt

- ciw : replace word under the cursor
- leader + , : change file in the buffer
- leader + | : right split
- leader + - : down split
- ctrl + h/j/k/l : to moved between split view
- ctrl + arrows : to resize split view
- leader + cm : open mason manager LSP
- leader + sC : fzf search command history
- ff + `select-file` + Ctrl + v : to open a file in vertical split
- :q : to close a split tab
- ctrl-r + {register} : to paste in vim
- s + {search-term} : use leap.nvim to jump to any location
- :LazyExtras : to install more nvim plugins such as LSP
- leader + xx : view diagnostics panel
- leader + ca : to trigger code action
- leader + uC : change color scheme
- \[ / \] + b : to go left/right opened tab
- Shift + h/l has the same effect and i like it better
- leader + fb : fzf file in buffer
- leader + sh : open command help
- leader + sk : search key maps
- leader + sr : search and replace
- leader + fT : open a quick terminal
- gc : to comment multiple line
- gc + o/O : add comment below above
- leader gB : git browse to remote repo
- gc : comment multiple line
- leader + p : open yank history
- leader + ghb : git blame line
- v : to quit and enter visual mode
- leader + wm : to maximize (temporally full screen a window)
- :TSInstallInfo : to list all supported language by TreeSitter
- In a markdown file, you can use leader + ca to generate table of content
- yi + observe which key suggestions : for advanced yanking
- ci + observe which key suggestions : for advanced changing
- di + observe which key suggestions : for advanced deleting
- leader + qq : quit all
- leader + qS : Switch to another session
- Ctrl + r : redo
- R : to enter replace mode
- T/t + "char" : move the cursor to right before the prev/next "char"
- F/f + "char" : move the cursor to be on top of the prev/next "char"
- X/x : delete backward/forward
- g + h/j/k/l : to move by visual line instead of logical line
- double esc to go from terminal mode to normal mode
- `K` : to open docs (then `K` again to hover docs)
- gsa + nav_motion: to add surrounding (if surround not a single character press `?` to type custom character)
  - for block surround operation **create surround first then select -> Alt -> Shift** is better.
  - even though `gsa` seems like a lit it is only one key away from the default `sa`
- vi? : select inner of custom block (for example that surrounded by `<text></text>`)
  - Normally you can do `vii` since they normally have the same indentation
- _ : to go the beginning of the line ignore leading white space

## Useful gesture for a standard text editor

- double click : select word
- triple click : select the whole line
- ctrl + arrows : navigate by word
- shift + navigate : highlight when navigate

### DB

- toggle DBUI : leader + D

### Tmux window switch

- Ctrl + h/j/k/l : to switch between tmux window

### Open telescope select in a split

- C-x : horizontal split
- C-v : vertical split

### Hurl

- go to ~/.local/share/nvim/lazy/hurl.nvim
- install code coloring for .hurl file with `:TSInstall hurl`
- if .hurl fails it will be logged to a split window

### How to navigate with Harpoon

- **Buffer:** A file or text loaded in memory.
- **Window:** A viewport displaying a buffer. Each window has its own jump list.
- **Tab:** A collection of windows
- **Jump List:** Tracks cursor movements to significant locations in a window.
- **Harpoon:** Bookmark manager for buffers/files. Quickly switch to frequently
  used files in the current window.

### How to replace with grug-far

`:s/old_text/new_text/g` : replace current line
`:%s/old_text/new_text/g` : replace current file
`:s/old_text/new_text/gc` : replace current file with confirmation
you can also highlight block and type the command above to replace a block

leader + sr : for advanced operation then :

- \r : simply replace all
- delete unnecessary replacement then \s : to sync all change with grug-far editor
- \l : to sync only a particular line

### Git

#### Keymaps

Leader + ghd : to view git diff with most recent commit
Leader + gB : to go to ref on remote
Leader + gY : to copy remote ref to clipboard

#### LazyGit

a : to stage lazy git all at once
visually select + space : partial stage
cursor to branch + o : open a PR

Cherry pick workflow

- go to commits tabs
- C to cherry pick
- switch to the target branch
- V to paste the commits

Interactive rebase workflow

- go to commits tabs
- e to rebase

Worktree
Benefits of worktree:

- You can have multiple branches checked out at the same time.
- Don't have to stash changes or commit to switch branches.

How to (while waiting for this issue to be resloved <https://github.com/kdheepak/lazygit.nvim/issues/137>):

- create a folder name `<project_name> + worktree`
- clone the project on that folder
- create different git worktree on that folder
- when you compare branches, open a split view with tmux
  (or nv -d <branch+file path 1> <branch+file path 2>)

### Obsidian

Don't integrate notes into repo, If notes needs ref to repo just use a github link
Each note would then correspond to one repo

Advantage of using obsidian solely:

- Avoid switching app
- Better integration with plugins (Kaban, Table, Dataview, Math expression)
- Graph view
- Image view

What obsidian.nvim bring to the table:

- leap.nvim (can somewhat be patched with ctrl f)
- telescope (can be patched with ctrl shift f)
- vim motions (can be patched with vimrc)
- `gf` to jump between files and use jump list (can also be patched with vimrc)
- smooth experience (I suck at vim).
<https://search.brave.com/search?q=clu&source=desktop>

What I want to have in a obsidian.vimrc:

- g: Select the whole file.
  - vig selects the whole file in visual mode.
  - yig yanks the whole file.
  - dig deletes the whole file.
  - Similarly, cig, vag, yag, etc., act on the entire file.
- i: Select the current indent block (lines with the same indentation level).
  - vii selects the indent block in visual mode.
  - yii yanks the indent block.
  - dii deletes the indent block.
- p: Select the inner paragraph (content without surrounding blank lines).
  - vip selects the inner paragraph.
  - yip yanks it.
  - dip deletes it.
- s: Select the current sentence.
  - vis selects the sentence.
  - yis yanks the sentence.
  - dis deletes it.
- jj to escape
- send to clipboard
- In normal mode
  - Actions c/d/r shouldn't send to register
- In visual mode
  - Only y/x send to register
- capital Y/C/D perform corresponding action till the end of the line
- Map h/j/k/l to arrow key
- using H and L for beginning/end of line

Optional

- q: Select inside quotes (", ', ```, etc.).
  - viq selects inside quotes.
  - yiq yanks the quoted content.
  - diq deletes inside quotes.

#### Things to do

- [x] vimrc
- [x] relative line
  - Go by relative visual line with j/k and relative line with J/K
  - H/J/K/L : all have unfrequent use
    - H/L : go to top and bottom of the page
    - J : merge the line below
    - K : open help window
- [x] Excalidraw
- [x] Dataview
- [-] Git
  - It is not working with nix installed obsidian and very unstable in mobile [link](https://github.com/Vinzent03/obsidian-git?tab=readme-ov-file#obsidian-on-linux)
  - Instead just write a script that push vault daily
- [x] Advanced table
- [x] set up zettelkasten

Optional:

- [-] AI tag assistant
  - [x] Smart connection
    - [x] browser native version buggy af
    - [x] I only need tags to be pre-embedded, but only pre-embedded note can recommend connection
    - [x] data is save at .smart-env
    - [ ] workaround self host ollama version
- [-] Chat with notes

- [ ] fast sync for cross device note
  - Sync with [self host liveSync](https://github.com/vrtmrz/obsidian-livesync)
- [ ] publish blogs
  - separte private & public in vault
- [x] project
  - Github/Gitlab issue is more than enough

## Lazy set up sequence

options.lua -> lazy.lua
`autocmds.lua` and `keymaps.lua` only apply on **very lazy** event

## Lazy `config` vs `opts`

In LazyVim:

- `opts`: Specifies the configuration options for a plugin. LazyVim automatically passes these options to the plugin's setup function.
- `config`: A function that runs after the plugin is loaded. It allows you to perform custom setup tasks, including calling the plugin's setup function or adding additional configuration, like key mappings or autocommands.
- example : <https://www.lazyvim.org/extras/ai/copilot-chat#copilotchatnvim>

## Window split Lazyvim

- New lazy vim use edgy.nvim which mean pane can't be resized
