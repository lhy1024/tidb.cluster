set -euo pipefail
. "`cd $(dirname ${BASH_SOURCE[0]}) && pwd`/../helper/helper.bash"

env=`cat "${1}/env"`

confirm=`confirm_str "${env}"`
name=`must_env_val "${env}" 'tidb.cluster'`

keep_monitor=`must_env_val "${env}" 'tidb.op.keep-monitor'`
keep_monitor=`to_true "${keep_monitor}"`

if [ "${keep_monitor}" != 'true' ]; then
	# Not stop: prometheus,grafana
	roles="pd,tikv,pump,tidb,tiflash,drainer,cdc,alertmanager,tispark-master,tispark-worker"
	roles=" --role ${roles}"
else
	roles=''
fi

tiup cluster --format=plain stop "${name}"${confirm}${roles}
