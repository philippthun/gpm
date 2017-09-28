. assert.sh

GPM=../bin/gpm
# Setting up v5.0 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.1')"
assert "go run go_code.go" "v6.1"

# Setting up v5.1 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.2')"
assert "go run go_code.go" "v6.2"

# Subpackage
version="a6a0a737c00caf4d4c2bb589941ace0d688168bb"
echo "github.com/garyburd/redigo/redis $version" > Godeps
assert_raises "$GPM"
pushd "${GOPATH%%:*}/src/github.com/garyburd/redigo"
assert "git rev-parse HEAD" "$version"
popd

# Repository's root on second level (e.g. cloud.google.com/go)
version="2e6a95edb1071d750f6d7db777bf66cd2997af6c"
echo "cloud.google.com/go/compute/metadata $version" > Godeps
assert_raises "$GPM"
pushd "${GOPATH%%:*}/src/cloud.google.com/go/compute/metadata"
assert "git rev-parse HEAD" "$version"
popd

## Cleanup
rm Godeps

assert_end examples
