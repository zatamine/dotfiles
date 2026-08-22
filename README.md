# Amine's Dotfiles

A version-controlled repository containing personal configuration and environment settings for macOS and Linux, managed seamlessly using [chezmoi](https://www.chezmoi.io/).

---

## ⚡ Features & Configs

- **Shell environment**: Optimized Zsh (`.zshrc`) configured with [Oh My Zsh](https://ohmyz.sh/).
- **Git identity profiles**:
  - Conditional directory-based routing (`includeIf`).
  - Automatic selection of professional email (`a.haddad@zatamine.com`) inside `~/code/pro/`.
  - Default fallback to personal GitHub noreply email (`264999+zatamine@users.noreply.github.com`) elsewhere.
- **Vim Editor**: Lightweight `.vimrc` equipped with spellchecking (EN/FR) and line numbers.
- **Fallback configurations**: Custom `.bashrc` and `.profile` for compatibility.

---

## 📋 Prerequisites

Before bootstrapping, ensure the following are installed:
- **Git**: `>= 2.36.0` (required for modern `includeIf` patterns).
- **curl**: For downloading installer scripts.
- **Homebrew** (macOS only): For package management.

---

## 🚀 Installation & Bootstrapping

You can initialize and apply this configuration to a clean system in a single command.

### One-liner Installation

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply git@github.com:zatamine/dotfiles.git
```

### Manual Step-by-Step Installation

If you prefer to review changes before applying:

1. **Install chezmoi**:
   - **macOS**: `brew install chezmoi`
   - **Linux**: `sh -c "$(curl -fsLS chezmoi.io/get)"`

2. **Initialize chezmoi** (clones the repository to `~/.local/share/chezmoi`):
   ```bash
   chezmoi init git@github.com:zatamine/dotfiles.git
   ```

3. **Verify changes** (prints a diff of files that will be added/modified):
   ```bash
   chezmoi diff
   ```

4. **Apply configuration**:
   ```bash
   chezmoi apply
   ```

---

## 📂 Repository Structure

Below is the logical mapping of files in the repository to their destination paths in your home directory:

| Source File | Destination Path | Description |
| :--- | :--- | :--- |
| `executable_dot_gitconfig` | `~/.gitconfig` | Main global Git configuration |
| `dot_gitconfig-perso` | `~/.gitconfig-perso` | Personal profile credentials |
| `dot_gitconfig-pro` | `~/.gitconfig-pro` | Professional profile credentials |
| `executable_dot_gitignore` | `~/.gitignore` | Global Git ignore rules |
| `dot_zshrc` | `~/.zshrc` | Zsh shell configuration |
| `dot_bashrc` | `~/.bashrc` | Bash shell configuration |
| `dot_profile` | `~/.profile` | Login shell profile |
| `dot_vimrc` | `~/.vimrc` | Vim editor config |
| `dot_vim/` | `~/.vim/` | Vim spell check dictionaries and assets |

---

## ⚙️ How Directory-Based Git Profiles Work

Your global Git configuration (`~/.gitconfig`) leverages conditional includes based on the active repository's file path.

```ini
# 1. Fallback default (Personal noreply email)
[includeIf "gitdir:~/"]
    path = ~/.gitconfig-perso

# 2. Overrides inside the professional code directory
[includeIf "gitdir:~/code/pro/"]
    path = ~/.gitconfig-pro
```

When running Git commands inside a repository:
* If the repository path is under `~/code/pro/`, your professional email (`a.haddad@zatamine.com`) is selected.
* For any other path under `~/` (including `~/code/perso/`), your personal GitHub privacy email (`264999+zatamine@users.noreply.github.com`) is used.

---

## 🛠️ Daily Workflow

### 1. Modify Configuration Files
Always edit your dotfiles via `chezmoi` to ensure changes are tracked in your source repository:
```bash
chezmoi edit ~/.zshrc
```
*This will open the source file in your system's default `$EDITOR`.*

### 2. Track a New File
To start tracking a new file from your home directory:
```bash
chezmoi add ~/.newconfig
```

### 3. Deploy Local Changes
To push changes made in the chezmoi source directory to your system:
```bash
chezmoi apply
```

### 4. Sync with Remote Repository
To commit and push updates back to GitHub:
```bash
chezmoi cd
git add .
git commit -m "Update configuration"
git push origin master
```

---

## 🔒 Managing Machine-Specific Overrides (Local Files)

For sensitive API keys or machine-specific configurations that should **not** be pushed to GitHub, use untracked local files.

* **Git**: The main configuration includes `~/.gitconfig.local` if it exists. Place system-specific git credentials there.
* **Shell**: The `.zshrc` incorporates local variables or environment configs. Put machine-specific exports in `~/.zshrc.local` (not tracked).
