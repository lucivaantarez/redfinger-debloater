#!/bin/bash
# ============================================
#   Redfinger Debloater v1.3
#   by lucivaantarez
#   github.com/lucivaantarez/redfinger-debloater
#
#   Run with:
#   curl -sL https://raw.githubusercontent.com/lucivaantarez/redfinger-debloater/main/debloat.sh -o ~/debloat.sh && bash ~/debloat.sh
# ============================================

PACKAGES=(
    "com.wsh.appstore"
    "com.wsh.toolkit"
    "com.wsh.file.observerservice"
    "com.wshl.extendedservices"
    "com.android.tools"
    "com.baidu.cloud.service"
    "com.android.contacts"
    "com.android.providers.contacts"
    "com.android.providers.downloads"
    "com.android.calendar"
    "com.android.providers.calendar"
    "com.android.email"
    "com.android.gallery3d"
    "com.android.messaging"
    "com.android.dialer"
    "com.android.quicksearchbox"
    "com.android.printspooler"
    "com.android.printservice.recommendation"
    "com.android.bips"
    "com.android.soundrecorder"
    "com.android.htmlviewer"
    "com.android.protips"
    "com.android.traceur"
    "com.android.smspush"
    "com.android.bookmarkprovider"
    "com.android.nfc"
    "com.android.mtp"
    "com.android.hotspot2"
    "com.android.pacprocessor"
    "com.android.simappdialog"
    "com.android.cellbroadcastreceiver"
    "com.android.se"
    "com.android.companiondevicemanager"
    "com.android.egg"
    "com.android.dreams.basic"
    "com.android.dreams.phototable"
    "com.android.wallpaper.livepicker"
    "com.android.wallpaperbackup"
)

clear
echo "=========================="
echo " Redfinger Debloater v1.3"
echo " by lucivaantarez"
echo "=========================="
echo ""
echo "[~] Checking root..."
if ! su -c "echo ok" > /dev/null 2>&1; then
    echo "[X] No root! Exiting."
    exit 1
fi
echo "[OK] Root confirmed!"
echo ""
echo "[START] Removing ${#PACKAGES[@]} packages..."
echo "--------------------------"

SUCCESS=0
SKIPPED=0
FAILED=0

for pkg in "${PACKAGES[@]}"; do
    result=$(su -c "pm uninstall --user 0 $pkg" 2>&1)
    if echo "$result" | grep -q "Success"; then
        echo "[OK]   $pkg"
        ((SUCCESS++))
    elif echo "$result" | grep -q "not installed\|Unknown package"; then
        echo "[SKIP] $pkg"
        ((SKIPPED++))
    else
        echo "[FAIL] $pkg"
        ((FAILED++))
    fi
done

echo "--------------------------"
echo " OK   : $SUCCESS"
echo " SKIP : $SKIPPED"
echo " FAIL : $FAILED"
echo "=========================="
echo " DONE!"
echo "=========================="
