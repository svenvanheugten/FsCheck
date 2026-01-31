#!/usr/bin/env bash
set -eo pipefail

dotnet --info
dotnet tool restore
dotnet fsi build.fsx "$@"
