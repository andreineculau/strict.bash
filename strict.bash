#!/usr/bin/env bash

# source with something this like:
# {
#     DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#     source ${DIR}/strict.bash
# } 2>/dev/null

# http://linuxcommand.org/lc3_man_pages/seth.html
set -o errexit   # error exits script
set -o nounset   # no unset variables
set -o pipefail  # failure on any command errors
set -o errtrace  # shell functions inherit ERR trap
set -o functrace # shell functions inherit DEBUG trap

SHELLOPT_XTRACE=
set -o | grep xtrace | grep -q on && SHELLOPT_XTRACE=1

# better debug lines
[ -z "${SHELLOPT_XTRACE}" ] || {
    set +x
    export PS4='+(${BASH_SOURCE[0]}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    set -x
}

BASH_XTRACEFD_REDIRECT=
[ -z "${BASH_XTRACEFD:-}" ] || BASH_XTRACEFD_REDIRECT="${BASH_XTRACEFD}>/dev/null"

for sig in HUP INT QUIT TERM EXIT; do trap "TRAP_SIGNAL=\"${sig}\" TRAP_CODE=\"\$?\" TRAP_LOCATION=\"+(\${BASH_SOURCE}:\${LINENO}): \${FUNCNAME[0]:+\${FUNCNAME[0]}(): }\" TRAP_COMMAND=\"\${EXE_COMMAND:-\${BASH_COMMAND}}\" on_trap ${BASH_XTRACEFD_REDIRECT}" ${sig}; done
function on_trap() {
    set +x
    [ "${TRAP_SIGNAL}" == "EXIT" ] && [ "${TRAP_CODE}" == "0" ] && return || true
    echo >&2 "
--------------------------------------------------------------------------------
${TRAP_SIGNAL} with ${TRAP_CODE}
${TRAP_LOCATION}${TRAP_COMMAND}"
}

EXE_COMMAND=
function exe() {
    EXE_COMMAND="$@"
    eval "echo \"\$ $@\"; $@"
    unset EXE_COMMAND
}
