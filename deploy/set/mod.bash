set -euo pipefail
. "`cd $(dirname ${BASH_SOURCE[0]}) && pwd`/../../helper/helper.bash"

env_file="${1}/env"
shift

mod="${1}"
key="${2}"
val="${3}"

if [ -z "${mod}" ] || [ -z "${key}" ] || [ -z "${val}" ]; then
	echo 'Some args are empty:' >&2
	echo "    mod=\"${mod}\"" >&2
	echo "    key=\"${key}\"" >&2
	echo "    val=\"${val}\"" >&2
	echo 'Usage:' >&2
	echo '    deploy.set.mod tikv log_dir /tmp/log' >&2
	echo 'Will write to tiup yaml as:' >&2
	echo '    tikv_servers:' >&2
	echo '      - host: ...' >&2
	echo '        log_dir: "/tmp/log"' >&2
	exit 1
fi

echo "tidb.mod.${mod}.${key}=${val}" | tee -a "${env_file}"
