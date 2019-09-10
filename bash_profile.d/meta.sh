function meta() {
  curl --silent http://metaphorpsum.com/paragraphs/$@ | xsel --clipboard ;
}

function metas() {
  curl --silent http://metaphorpsum.com/sentences/$@ | xsel --clipboard ;
}

declare -fx meta
declare -fx metas
