#!/usr/bin/env bash

MIN_CLANG_FORMAT_VERSION=9

die()
{
    echo "$@" >&2
    exit 1
}

cd "${0%/*}/.." || die "Couldn't cd into the project root directory"

command -v clang-format > /dev/null || die "clang-format not found"
clang_format_version=$(clang-format --version | sed -ne 's/[^0-9]*\([0-9]*\)\..*/\1/p')
[ "$clang_format_version" -ge $MIN_CLANG_FORMAT_VERSION ] || \
    die "clang-format v$MIN_CLANG_FORMAT_VERSION+ required; found v$clang_format_version"

all_source_files="o1heap/* tests/*.cpp tests/*.hpp"
for i in $all_source_files; do echo "$i"; done

# shellcheck disable=SC2086
clang-format -i -fallback-style=none -style=file $all_source_files || die "clang-format has failed"
