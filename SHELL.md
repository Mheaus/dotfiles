# Dotfiles – Configuration Zsh avec Antidote

Ce dépôt contient mes fichiers de configuration pour macOS, avec une attention particulière portée à la personnalisation du terminal via Zsh, en utilisant le gestionnaire de plugins **Antidote**.

## 🧰 Prérequis

### 1. Outils en ligne de commande

Ouvre le Terminal et exécute :

```bash
xcode-select --install
```

Si les outils sont déjà installés, un message le signalera.

### 2. Homebrew

Installe [Homebrew](https://brew.sh/) :

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Ensuite, mets à jour Homebrew :

```bash
brew update
```

### 3. GitHub

Assure-toi d'avoir un compte GitHub. Si ce n'est pas le cas, [inscris-toi ici](https://github.com/join).

Configure ensuite ton nom et ton email pour Git :

```bash
git config --global user.name "Mathieu Audebert"
git config --global user.email "mathieu@sakuga.dev"
```

### 4. Clé SSH

Génère une clé SSH :

```bash
ssh-keygen -t ed25519 -C "mathieu@sakuga.dev"
```

Ajoute la clé SSH à ton compte GitHub en suivant [ces instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

## 🚀 Installation des dotfiles

Clone ce dépôt :

```bash
git clone git@github.com:Mheaus/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Exécute le script d'installation :

```bash
zsh install.sh
```

Ce script :

- Installe les dépendances nécessaires.
- Configure Zsh avec Antidote.
- Crée les fichiers de configuration personnalisés.

## ⚙️ Configuration de Zsh avec Antidote

### 1. Installation d'Antidote

Installe Antidote via Homebrew :

```bash
brew install antidote
```

### 2. Fichier `.zsh_plugins.txt`

Ce fichier liste les plugins à charger avec Antidote. Exemple :

```txt
# Utilitaires Zsh
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search

# Plugins Oh My Zsh
getantidote/use-omz
ohmyzsh/ohmyzsh path:lib
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/extract
```

> 💡 Le plugin `getantidote/use-omz` facilite l'intégration des plugins Oh My Zsh avec Antidote.

### 3. Fichier `.zshrc`

Voici un exemple de configuration pour `.zshrc` :

```zsh
# Chargement d'Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Chargement des plugins
antidote load

# Initialisation des couleurs
autoload -Uz colors && colors

# Personnalisation du prompt
setopt prompt_subst

git_branch_prompt() {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "%{$fg[magenta]%}($branch)%{$reset_color%}"
}

PROMPT='%{$fg_bold[blue]%}%~%{$reset_color%} $(git_branch_prompt) %# '
```

## 🧪 Vérification de l'installation

Redémarre ton terminal et exécute :

```bash
zsh
```

Tu devrais voir ton nouveau prompt personnalisé, et les plugins devraient être actifs.

## 🧼 Nettoyage

Si tu souhaites réinitialiser Antidote :

```bash
rm -rf $(antidote home)
rm ~/.zsh_plugins.zsh
```

## 📁 Structure du dépôt

- `install.sh` : Script d'installation des dotfiles.
- `.zshrc` : Configuration principale de Zsh.
- `.zsh_plugins.txt` : Liste des plugins à charger avec Antidote.
- `README.md` : Ce fichier.
