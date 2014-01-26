# Dropbox linking
if [[ -d Dropbox ]]; then

    # create links in the $HOME pointing to everything at Dropbox/nix/home
    for i in Dropbox/nix/home/{.,}*; do
        test ! -e ${i##*/} && ln -vs $i
    done

    # special Sublime 2 link
    test ! -e "Library/Application Support/Sublime Text 2/Packages/User" &&
        ln -vs "../../../../Dropbox/softs/Sublime Text 2/User" "Library/Application Support/Sublime Text 2/Packages"

    # choosing which .gitconfig to use is a manual operation
    test ! -e .gitconfig && echo "warning: .gitconfig should be linked to a subitem in Dropbox/nix/git"

fi