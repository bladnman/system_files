#!/bin/bash

# Navigate to the script's directory
cd "$(dirname "$0")"

# Function to create a symbolic link if it doesn't already exist and the target exists
create_symlink() {
    local target=$1
    local link_name=$2

    if [ ! -e "$target" ]; then
        echo "🦘 Target $target does not exist. Skipping $link_name."
    elif [ -L "$link_name" ]; then
        echo "🦘 Symlink $link_name already exists. Skipping."
    else
        ln -s "$target" "$link_name"
        echo "✅ Created symlink: $link_name -> $target"
    fi
}

# Function to create symlinks from a list of files to a specified directory and remove the directory if it's empty
create_from_list() {
    local destination_dir=$1
    shift
    local files=("$@")

    mkdir -p "$destination_dir"

    local created_symlink=false

    for file in "${files[@]}"; do
        local base_name=$(basename "$file")
        create_symlink "$file" "$destination_dir/$base_name" && created_symlink=true
    done

    # Remove the directory if no symlinks were created
    if [ "$(ls -A "$destination_dir")" ]; then
        echo "✅ Directory $destination_dir is not empty."
    else
        rmdir "$destination_dir"
        echo "🧹 Removed empty directory: $destination_dir"
    fi
}

# Lists of files
shell_files=(
    ~/.bashrc
    ~/.zshrc
    ~/.profile
    ~/.bash_profile
)

system_files=(
    /etc/hosts
    /etc/fstab
    /etc/resolv.conf
)

package_manager_files=(
    ~/.npmrc
    ~/.pip/pip.conf
    ~/.gemrc
)

git_files=(
    ~/.gitconfig
    ~/.gitignore_global
)

ssh_files=(
    ~/.ssh/config
    ~/.ssh/known_hosts
    ~/.ssh/authorized_keys
    ~/.ssh/id_rsa
    ~/.ssh/id_rsa.pub
    ~/.ssh/id_dsa
    ~/.ssh/id_dsa.pub
)

editor_files=(
    ~/.vimrc
    ~/.tmux.conf
    ~/.screenrc
    ~/.inputrc
    ~/.config/Code/User/settings.json
    ~/.config/Code/User/keybindings.json
    ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
    ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
)

custom_scripts=(
    ~/scripts/my_custom_script.sh
)

version_manager_files=(
    ~/.nvm
    ~/.pyenv
    ~/.pythonrc
)

additional_directories=(
    ~/shell_extensions
)

# Create symlinks
create_from_list "shell_config" "${shell_files[@]}"
create_from_list "system_config" "${system_files[@]}"
create_from_list "package_manager_config" "${package_manager_files[@]}"
create_from_list "git_config" "${git_files[@]}"
create_from_list "ssh_config" "${ssh_files[@]}"
create_from_list "editor_config" "${editor_files[@]}"
create_from_list "custom_scripts" "${custom_scripts[@]}"
create_from_list "version_manager_config" "${version_manager_files[@]}"
create_from_list "shell_config" "${additional_directories[@]}"

echo "Setup completed successfully."
