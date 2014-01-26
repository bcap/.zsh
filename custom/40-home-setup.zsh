# Dropbox linking
if [[ -d Dropbox ]]; then

    test ! -e .gnupg && ln -s Dropbox/nix/.gnupg
    test ! -e .pip && ln -s Dropbox/nix/.pip
    test ! -e .ssh && ln -s Dropbox/nix/.ssh
    test ! -e bin && ln -s Dropbox/nix/bin

    test ! -e .gitconfig && echo "warning: .gitconfig should be linked to a subitem in Dropbox/nix/git"

    test ! -e "Library/Application Support/Sublime Text 2/Packages/User" &&
        ln -s "../../../../Dropbox/softs/Sublime Text 2/User" "Library/Application Support/Sublime Text 2/Packages"

fi