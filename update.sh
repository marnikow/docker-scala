#!/usr/bin/env bash

set -eo pipefail

DOCKER_ACC=marnikow
DOCKER_REPO=scala
DOCKER_LATEST=2.13.1
VERSIONS_FILE="versions.txt"

declare -a versions="$(cat $VERSIONS_FILE)"

generate_standard() {
  sed -e "s/<version>/$1/g" templates/dockerfile/standard.template >"$1/Dockerfile"
}

generate_alpine() {
  cp -R base/alpine "$1/alpine"
  sed -e "s/<version>/$1/g" templates/dockerfile/alpine.template >"$1/alpine/Dockerfile"
}

update() {
  while IFS= read -r version; do
    rm -rf "${version}"
    mkdir "${version}"

    generate_standard "${version}"
    generate_alpine "${version}"
  done <<<"$versions"
  generate_travis_yml
  generate_readme
}

update_list() {
  if [[ -z $1 ]]; then
    # nothing specified
    TARGET="$VERSIONS_FILE"
  else
    TARGET="$1"
  fi
  echo "Saving new list to $TARGET"
  wget --timeout=5 -O - -q "https://scala-lang.org/download/all.html" | xmllint --html --xpath '//div[@class="inner-box"]' - 2>/dev/null | xmlstarlet sel -t -v 'div/div/a/text()' - | sed -e 's/Scala //' >"$TARGET"
}

print_for_travis() {
  while IFS= read -r version; do
    echo "  - VERSION=${version}"
  done <<<"$versions"
}

generate_travis_yml() {
  vs="$(print_for_travis)"
  awk -v v="$vs" '{gsub(/<versions>/,v)}1' "templates/.travis.yml.template" >".travis.yml"
}

print_for_readme() {
  while IFS= read -r version; do
    folder="$(get_docker_folder "$version")"
    echo "- [\`$version\`($folder/Dockerfile)](https://github.com/marnikow/docker-scala/blob/master/$folder/Dockerfile)"
    folder="$(get_docker_folder "$version" 1)"
    echo "- [\`$version-alpine\`($folder/Dockerfile)](https://github.com/marnikow/docker-scala/blob/master/$folder/Dockerfile)"
  done <<<"$versions"
}

generate_readme() {
  vs="$(print_for_readme)"
  awk -v v="$vs" '{gsub(/<prev_versions>/,v)}1' "templates/README.md.template" >"README.md"
}

# $1 version
# $2 is it alpine
get_docker_folder() {
  if [[ $2 -eq 0 ]]; then
    FOLDER="$1"
  else
    FOLDER="$1"/alpine
  fi
  echo "$FOLDER"
}

# $1 version
# $2 is it alpine
get_docker_tag() {
  if [[ $2 -eq 0 ]]; then
    TAG="$DOCKER_ACC/$DOCKER_REPO:$1"
  else
    TAG="$DOCKER_ACC/$DOCKER_REPO:$1-alpine"
  fi
  echo "$TAG"
}

# $1 version
# $2 is it alpine
pull_docker_version() {
  TAG="$(get_docker_tag "$1" "$2")"
  docker pull "$TAG"
}

# $1 version
# $2 is it alpine
build_docker_version() {
  TAG="$(get_docker_tag "$1" "$2")"
  FOLDER="$(get_docker_folder "$1" "$2")"
  docker build -t "$TAG" "$FOLDER"
  if [[ "$DOCKER_LATEST" == "$1" ]]; then
    if [[ $2 -eq 0 ]]; then
      TAG_LATEST="$(get_docker_tag "alpine")"
    else
      TAG_LATEST="$(get_docker_tag "latest")"
    fi
    docker tag "$TAG" "$TAG_LATEST"
  fi
}

# $1 version
# $2 is it alpine
test_docker_version() {
  TAG="$(get_docker_tag "$1" "$2")"
  echo "Testing $TAG"
  if (tests/scala.sh "$TAG" && tests/scalac.sh "$TAG"); then
    echo "Testing $TAG succeeded"
    true
  else
    echo "Testing $TAG failed"
    false
  fi
}

# $1 version
# $2 is it alpine
push_docker_version() {
  TAG="$(get_docker_tag "$1" "$2")"
  docker push "$TAG"
}

# $1 version
# $2 is it alpine
has_docker_image() {
  TAG="$(get_docker_tag "$1" "$2")"
  if [[ "$(docker images -q "$TAG" 2>/dev/null)" == "" ]]; then
    false
  else
    true
  fi
}

# $1 version
# $2 is it alpine
check_and_push_docker() {
  pull_docker_version "$1" "$2" || true
  if ! (has_docker_image "$1" "$2"); then
    echo "Building"
    build_docker_version "$1" "$2"
    if (test_docker_version "$1" "$2"); then
      push_docker_version "$1" "$2"
    else
      false
    fi
  else
    test_docker_version "$1" "$2"
  fi
}

# $1 version
check_and_push_docker_versions() {
  if (check_and_push_docker "$1" && check_and_push_docker "$1" 1); then
    true
  else
    false
  fi
}

versions_to_docker() {
  docker pull -a "$DOCKER_ACC"/"$DOCKER_REPO"
  while IFS= read -r version; do
    check_and_push_docker_versions "${version}"
  done <<<"$versions"
}

if [[ -z $1 ]]; then
  # nothing specified
  update
  exit 0
else
  if [[ $1 == "update-list" ]]; then
    update_list "$2"
    exit 0
  elif [[ $1 == "travis-yml" ]]; then
    generate_travis_yml
    exit 0
  elif [[ $1 == "readme-md" ]]; then
    generate_readme
    exit 0
  elif [[ $1 == "docker" ]]; then
    echo "Dockering"
    versions_to_docker
    exit 0
  elif [[ $1 == "tag" ]]; then
    get_docker_tag "$2" "$3"
    exit 0
  elif [[ $1 == "folder" ]]; then
    get_docker_folder "$2" "$3"
    exit 0
  elif [[ $1 == "travis" ]]; then
    if [[ $2 == "CI" ]]; then
      echo "Checking, building, testing and pushing v$3 from travis"
      check_and_push_docker_versions "$3"
      exit $?
    elif [[ $2 == "pull" ]]; then
      echo "Pulling v$3 ($4) from travis"
      pull_docker_version "$3" "$4"
      exit $?
    elif [[ $2 == "build" ]]; then
      echo "Building v$3 ($4) from travis"
      build_docker_version "$3" "$4"
      exit 0
    elif [[ $2 == "test" ]]; then
      echo "Testing v$3 ($4) from travis"
      test_docker_version "$3" "$4"
      exit $?
    elif [[ $2 == "push" ]]; then
      echo "Pushing v$3 ($4) from travis"
      push_docker_version "$3" "$4"
      exit $?
    fi
    echo "Second arg not understood"
    exit 3
  fi
  echo "First arg not understood"
  exit 2
fi
exit 1
