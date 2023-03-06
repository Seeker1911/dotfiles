#! /bin/sh

USAGE="./link_profile.sh --profile [aws-developer, dev-principal, etc.]"

usage() {
    echo "Usage: $USAGE"
}


while true; do
  case "$1" in
    --profile) ACCOUNT=$2; shift 2;;
    -p) ACCOUNT=$2; shift 2;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ -z "${ACCOUNT}" ]
then
  usage
fi

ln -sf ~/.aws/"$ACCOUNT" ~/.aws/credentials
