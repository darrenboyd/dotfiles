function meta() {
  p=$1
  s=$2

  if [ -z "$p" ]; then
    p=1
  fi

  if [ -z "$s" ]; then
    s=4
  fi

  curl --silent http://metaphorpsum.com/paragraphs/$p/$s | xsel --clipboard ;
}

declare -fx meta
