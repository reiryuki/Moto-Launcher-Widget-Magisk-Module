mount -o rw,remount /data
MODPATH=${0%/*}

# debug
exec 2>$MODPATH/debug-pfsd.log
set -x

# run
FILE=$MODPATH/sepolicy.sh
if [ -f $FILE ]; then
  . $FILE
fi

# context
chcon -R u:object_r:vendor_overlay_file:s0 $MODPATH/system/product/overlay

# conflict
rm -f /data/adb/modules/*/system/app/MotoSignatureApp/.replace
#rtouch /data/adb/modules/quickstepswitcher/remove
#rtouch /data/adb/modules/quickswitch/remove

# cleaning
FILE=$MODPATH/cleaner.sh
if [ -f $FILE ]; then
  . $FILE
  rm -f $FILE
fi


