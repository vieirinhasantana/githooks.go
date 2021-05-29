#!/bin/bash

echo "==> Checking that code complies with gofmt requirements..."
gofmt_files=$(gofmt -l `find . -name '*.go' | grep -v vendor`)
if [[ -n ${gofmt_files} ]]; then
    echo 'gofmt needs running on the following files:'
    echo "${gofmt_files}"
    echo "You can use the command: \`gofmt -w \$(gofmt -l \`find . -name \'*.go\' | grep -v vendor)\` to reformat code."
    exit 1
fi

git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"

GO111MODULE=off go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
golangci-lint run --tests=false --skip-files=mock.go --disable=goimports --enable-all

exit $?
