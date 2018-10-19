#!/bin/sh
# set env for CDC

JAVA_HOME=/opt/softwareag/jvm/jvm
DCI_HOME=/opt/softwareag/common/db
CDBS_HOME=/opt/softwareag/common/db

#exportStartHeap


DCI_START_HEAP="${DCI_START_HEAP:-10}";export DCI_START_HEAP

DCI_MAX_HEAP="${DCI_MAX_HEAP:-512}";export DCI_MAX_HEAP

#exportJavaOpts

JAVA_OPTS="$JAVA_OPTS -DCDBS.home.path=$CDBS_HOME"
JAVA_OPTS="$JAVA_OPTS -DDCI.home.path=$DCI_HOME"
JAVA_OPTS="$JAVA_OPTS -Dlog.dir=$DCI_HOME/logs"
JAVA_OPTS="$JAVA_OPTS  -DtermOutOn=true"
JAVA_OPTS="$JAVA_OPTS  -DspoolOn=true"

##==================To enable debug, change this property to 'DEBUG'==========
JAVA_OPTS="$JAVA_OPTS  -DlogLevel=INFO"
##============================================================================

JAVA_OPTS="$JAVA_OPTS  -Xms${DCI_START_HEAP}m"
JAVA_OPTS="$JAVA_OPTS  -Xmx${DCI_MAX_HEAP}m"
JAVA_OPTS="$JAVA_OPTS  -Xss256k"

export JAVA_OPTS

##exportClassPath
CLASSPATH="$CLASSPATH:$DCI_HOME"
CLASSPATH="$CLASSPATH:$DCI_HOME/lib/wm-cdc-client.jar"
for file in $DCI_HOME%/lib/wm-cdc-client_*
do
      CLASSPATH=${CLASSPATH}:$file
done
CLASSPATH="$CLASSPATH:$DCI_HOME/lib/CDC_PELP_ja_Messages-ALL-Any.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/lib/CDC_PELP_ar_Messages-ALL-Any.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/commons-cli.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/wm-cdc-core.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/jargs.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/wm-g11nutils.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/log4j.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/derby.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/mysql-connector-java-5.1.44-bin.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/wm-caf-common.jar"
for file in $DCI_HOME/../lib/ext/sl53*
do
      CLASSPATH=${CLASSPATH}:$file
done
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/dd-cjdbc.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/xml-apis.jar"
CLASSPATH="$CLASSPATH:$DCI_HOME/../lib/ext/xercesImpl.jar"
CLASSPATH="$CLASSPATH:$JAVA_HOME/lib/tools.jar"
CLASSPATH="$CLASSPATH:$JAVA_HOME/jre/lib/charsets.jar"
export CLASSPATH

echo CLASSPATH: $CLASSPATH
