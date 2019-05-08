if [ "$(xcrun simctl list | grep Boot| wc -l)" -gt 0 ]
then echo "found booted sims"
else echo "no sim booted"
fi

for udid in $(xcrun simctl list devices | \
    grep "(Booted)"         | \
    grep -E -o -i "([0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})")
do echo $udid
done


# Type a script or drag a script file from your workspace to insert its path.
# xcrun simctl uninstall booted "com.joinhandshake.Handshake.student"
# Don't use ${PRODUCT_BUNDLE_IDENTIFIER} for this schema
if [ "$(xcrun simctl list | grep Boot| wc -l)" -eq 1 ];then
    echo "found booted sims $(eval xcrun simctl list | grep Boot)"
    xcrun simctl uninstall booted "com.joinhandshake.Handshake.student"
elif [ "$(xcrun simctl list | grep Boot| wc -l)" -gt 1 ];then
    echo "found more than one booted simulators"
    for udid in $(xcrun simctl list devices | \
                    grep "(Booted)"         | \
                    grep -E -o -i "([0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})")
    do
        echo $udid
        xcrun simctl uninstall $udid "com.joinhandshake.Handshake.student"
    done
else
    echo "no sim booted"
fi
