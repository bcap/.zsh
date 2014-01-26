# setting path and fpath in an array form (declared as lowercase variables)
fpath=(
    $HOME/.zsh/zsh-completions
    $fpath
)

path=(
    $HOME/bin # personal scripts
    /usr/local/heroku/bin # heroku toolbelt
    /usr/local/opt/coreutils/libexec/gnubin # gnu coreutils on mac installed with brew
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
)

HISTSIZE=1000
SAVEHIST=1000000

# general vars
export SYSTEM="$(uname -s)"
export EDITOR="vim"
export VISUAL="subl --wait"
export PAGER="less"
export LESS="--chop-long-lines --raw-control-chars"
export MAVEN_OPTS="-Xmx256m -XX:MaxPermSize=256m"
export PIP_DOWNLOAD_CACHE=${HOME}/.pip/downloadcache
export WORKON_HOME=${HOME}/.virtualenvs # virtual env wrapper

# Linux specific
if [[ "$SYSTEM" == "Linux" ]]; then
    export LESS="$LESS --shift 0.3"
fi

# MAC specific
if [[ "$SYSTEM" == "Darwin" ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# aws stuff
AWS_CREDENTIALS_DIR=Dropbox/nix/aws/credentials
if [[ -d $AWS_CREDENTIALS_DIR ]]; then
    # personal var do help me out
    export AWS_CREDENTIALS_DIR

    # boto uses this
    export AWS_CREDENTIAL_FILE=$AWS_CREDENTIALS_DIR/aws-credentials-root

    # AWS tools uses this
    export AWS_ACCESS_KEY=$(grep AWSAccessKeyId $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
    export AWS_SECRET_KEY=$(grep AWSSecretKey $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
fi

source-if-exists /usr/local/bin/virtualenvwrapper.sh # ubuntu
source-if-exists /usr/local/share/python/virtualenvwrapper.sh # mac brew
