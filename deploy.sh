#!/bin/sh

REMOTE="vjousse@marty.jousse.org"
REMOTE_DIR="/home/vjousse/scala/blog"

echo "Deploy to $REMOTE:$REMOTE_DIR"

sbt ";stage;exit"
if [ $? != 0 ]; then
  echo "Deploy canceled"
  exit 1
fi

RSYNC_OPTIONS=" \
  --archive \
  --force \
  --delete \
  --progress \
  --compress \
  --checksum \
  --verbose \
  --exclude conf/application.conf \
  --exclude logs \
  --exclude RUNNING_PID";

echo "Rsync scripts, binaries and assets"
stage="target/universal/stage"
rsync_command="rsync $RSYNC_OPTIONS $stage/bin $stage/lib public posts $REMOTE:$REMOTE_DIR"
echo "$rsync_command"
$rsync_command

