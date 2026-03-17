#!/bin/bash
# ============================================
#   Redfinger Debloater v1.2
#   by lucivaantarez
#   github.com/lucivaantarez/redfinger-debloater
#
#   Run with:
#   curl -sL https://raw.githubusercontent.com/lucivaantarez/redfinger-debloater/main/debloat.sh -o /tmp/debloat.sh && bash /tmp/debloat.sh
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
echo "================================"
echo "  Redfinger Debloater v1.2"
echo "  github.com/lucivaantarez"
echo "================================"
echo ""

# Check root
echo "[~] Checking root access..."
if ! su -c "echo ok" > /dev/null 2>&1; then
    echo "[X] No root! Enable root on Redfinger first."
    exit 1
fi
echo "[OK] Root confirmed!"
echo ""

# Show list
echo "[!] Packages to remove:"
echo "--------------------------------"
for pkg in "${PACKAGES[@]}"; do
    echo "  $pkg"
done
echo "--------------------------------"
echo ""

read -p "[?] Continue? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "[X] Aborted."
    exit 0
fi

echo ""
echo "================================"
echo "[START] Debloating..."
echo "================================"
echo ""

SUCCESS=0
SKIPPED=0
FAILED=0

for pkg in "${PACKAGES[@]}"; do
    echo -n "  >> $pkg "
    result=$(su -c "pm uninstall --user 0 $pkg" 2>&1)

    if echo "$result" | grep -q "Success"; then
        echo "... OK"
        ((SUCCESS++))
    elif echo "$result" | grep -q "not installed\|Unknown package"; then
        echo "... SKIP"
        ((SKIPPED++))
    else
        echo "... FAIL"
        ((FAILED++))
    fi
done

echo ""
echo "================================"
echo "  OK   : $SUCCESS"
echo "  SKIP : $SKIPPED"
echo "  FAIL : $FAILED"
echo "================================"
echo "  DONE! Debloat complete!"
echo "================================"
