#!/bin/bash

function usage()
{

                echo ""
                echo "Usage:"
                echo "  ./server.sh [ -o | -v version | -m jvm_run_memory ] [ test | start | stop | status | bak ]"
                echo ""
				echo "Options:"
				echo ""
				echo "  -o                  - run server with jvm optimize parameters"
				echo "  -v version          - run specified version server"
				echo "  -m jvm_run_memory   - run server with specified jvm run memeory alloced"
				echo ""
				echo "Arguments:"
				echo ""
                echo "  test   - Start the pure minecraft server in test mode"
				echo "  start  - start the pure minecraft server(with o, you can use the JVM optimization options run server)"
				echo "           if the server port has been used by other process, you can use 'lsof -i :portNum' to check"
				echo "  stop   - stop the pure minecraft server"
				echo "  status - check the minecraft server run status"
				echo "  bak    - backup the world directory to gzip files"
                echo ""
				echo "Example:"
				echo ""
				echo "  Start the Server:"
				echo ""
				echo "      ./server.sh -o -v 1.12.2 -m 1024M start"
				echo ""
				echo "  Stop the Server:"
				echo "      ./server.sh stop"
				echo ""
				echo "  Check the server status:"
				echo ""
				echo "      ./server status"
				echo ""
				echo "  Run the Server block the shell:"
				echo ""
				echo "      ./server -o -v 1.12.2 -m 2048M test"
				echo ""
                exit 1
}

SERVER_VERSION=1.12.2

RUN_MEM="1024M"

OPT=""
if [ `uname -m` = "x86_64" ]; then
    OPT="-d64"
fi

while getopts :ov:m: opt
do 
	case "$opt" in
		o)
			JVM_OPTS="-server -Xss256k -XX:PermSize=256m -XX:MaxPermSize=256m -XX:NewSize=1024m -XX:MaxNewSize=1024m -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+UseFastAccessorMethods -XX:+UseConcMarkSweepGC -XX:MaxGCPauseMillis=100 -XX:+CMSParallelRemarkEnabled -XX:ParallelGCThreads=20"
		;;

		v)
			SERVER_VERSION="${OPTARG}"
		;;

		f)
		;;
		m)
			RUN_MEM="${OPTARG}"
		;;

		*) 
		;;
	esac
done

#
shift $[ $OPTIND - 1 ]
#
PURE_JAR="minecraft_server.${SERVER_VERSION}.jar"
if [ ! -f $PURE_JAR ]
then
	echo $PURE_JAR file not found!!!
	exit 1;
fi

RUN_CMD="java $JVM_OPTS -Xmx$RUN_MEM -Xms$RUN_MEM $OPT -jar $PURE_JAR nogui"

if [ $# -ne 1 ]
then
	usage
	exit 0
fi

USER=$(whoami)
PID="$(ps ux | grep "minecraft_server.*" | grep -v grep | tr -s ' '     ' ' | cut -d ' ' -f 2 | head -n 1)"

for param in "$@"
do
	case "$param" in
		test)
			${RUN_CMD} 
   			echo "Starting Minecraft Server for $(USER) in Test Mode"
		;;

		start)
			if [ -n "$PID" ]
			then
				echo "You have started a Minecraft Server"
				exit 0
			fi


			${RUN_CMD} &
			echo "Starting Minecraft Server for $USER"
		;;

		stop)
			if [ -n "$PID" ]; then
				kill -9 $PID
                echo "Minecraft Server stopped"
				exit 0
			fi
		;;
		
		status)
			if [ -n "$PID" ]
			then 
				echo "Your minecraft server is running!"
				exit 0
			fi

			echo "Your minecraft server is not running!!!"
		;;
		bak)
			tar zcvf "../world-backup/world-$(date '+%Y%m%d%H%M%S').gzip" world/
			;;
		*)
			usage
			break;
			;;
	esac
done

