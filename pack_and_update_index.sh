#!/bin/bash

usage () {
    cat <<EOF
Usage:
    Helm packages and updates the index file.
    $PROGRAM [ -h --help -?  View help ]
    Flags::
            [ -n, --name            [Required] "Chart name" ]
EOF
}

usage_and_exit () {
    usage
    exit "$1"
}

log () {
    echo "$@"
}

error () {
    echo "$@" 1>&2
    usage_and_exit 1
}

warning () {
    echo "$@" 1>&2
    EXITCODE=$((EXITCODE + 1))
}

# 解析命令行参数，长短混合模式
(( $# == 0 )) && usage_and_exit 1
while (( $# > 0 )); do
    case "$1" in
        -n | --name )
            shift
            NAME=$1
            ;;
        --help | -h | '-?' )
            usage_and_exit 0
            ;;
        -*)
            error "Unknown: $1"
            ;;
        *)
            break
            ;;
    esac
    shift $(($# == 0 ? 0 : 1))
done



WORKSPACE=$(pwd)
CHARTS_REPO_URL="https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main"

chart_dir="${WORKSPACE}/${NAME}/src"

if [ ! -d "${chart_dir}" ]; then
  error "Chart Directory '${chart_dir}' does not exist."
fi

helm package "${chart_dir}" -u -d "${chart_dir}"/_charts && rm -rf "${chart_dir}"/charts

helm repo index "$chart_dir" --url "${CHARTS_REPO_URL}/${NAME}/src"

cp "$chart_dir"/index.yaml "$chart_dir"/_index.yaml

helm repo index "$chart_dir" --url "${CHARTS_REPO_URL}/${NAME}/src" --merge "${WORKSPACE}"/index.yaml

cp -f "$chart_dir"/index.yaml "${WORKSPACE}"/index.yaml
mv "$chart_dir"/_index.yaml "$chart_dir"/index.yaml

cd "${chart_dir}" || exist
helm dependency update
