if [[ -d $1 ]] ; then
  echo "$(eza --tree --color=always $1 | head -200)"
  exit
fi

filename=$(basename -- "$1")
extension="${filename##*.}"

case "$extension" in
  png|jpg|webp) echo "$(timg -p quarter -g50x50 $1)" ;;
  7z|zip|gz) echo "$(7z l $1)" ;;
  *) echo "$(bat -n --color=always --line-range :500 $1)" ;;
esac

