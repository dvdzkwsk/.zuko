function link {
    local src="${PWD}/dotfiles/$1"
    local dst="$HOME/.$1"
    echo "link $src -> $dst"
    ln -sf "$src" "$dst"
}

link zshrc
link git_aliases
link gitconfig
link ripgreprc
link slate