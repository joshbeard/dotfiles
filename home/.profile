case "$SHELL" in
  *"bash")
    source ${HOME}/.bashrc
  ;;
  *)
    source ${HOME}/.env
  ;;
esac

