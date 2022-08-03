setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-ddev-printenv
  mkdir -p $TESTDIR
  export PROJNAME=test-ddev-printenv
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  ddev printenv
  ddev printenv --obfuscate | grep -e '^COMPOSER_CACHE_DIR=oser$'
  ddev printenv COMPOSER_CACHE_DIR | grep -e '^/mnt/ddev-global-cache/composer$'
  ddev printenv --obfuscate COMPOSER_CACHE_DIR | grep -e '^oser$'
  ddev printenv --service db | grep -e '^MYSQL_HISTFILE'
  ddev printenv --service db --obfuscate MYSQL_HISTFILE | grep -e '^tory$'
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get drud/ddev-ddev-printenv with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get lullabot/ddev-ddev-printenv
  ddev restart >/dev/null
  ddev printenv
  ddev printenv --obfuscate | grep -e '^COMPOSER_CACHE_DIR=oser$'
  ddev printenv COMPOSER_CACHE_DIR | grep -e '^/mnt/ddev-global-cache/composer$'
  ddev printenv --obfuscate COMPOSER_CACHE_DIR | grep -e '^oser$'
  ddev printenv --service db | grep -e '^MYSQL_HISTFILE'
  ddev printenv --service db --obfuscate MYSQL_HISTFILE | grep -e '^tory$'
  # Do something useful here that verifies the add-on
  # ddev exec "curl -s elasticsearch:9200" | grep "${PROJNAME}-elasticsearch"
}
