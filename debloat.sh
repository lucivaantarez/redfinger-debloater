#!/bin/bash
# ============================================
#   Redfinger Debloater v1.1
#   by lucivaantarez
#   github.com/lucivaantarez/redfinger-debloater
#
#   Run with:
#   bash <(curl -sL https://raw.githubusercontent.com/lucivaantarez/redfinger-debloater/main/debloat.sh)
# ============================================

PACKAGES=(
    # Redfinger Bloat
    "com.wsh.appstore"
    "com.wsh.toolkit"
    "com.wsh.file.observerservice"
    "com.wshl.extendedservices"
    "com.android.tools"
    "com.baidu.cloud.service"

    # Contacts & Calendar
    "com.android.contacts"
    "com.android.providers.contacts"
    "com.android.providers.downloads"
    "com.android.calendar"
    "com.android.providers.calendar"

    # Unused Apps
    "com.android.email"
    "com.android.gallery3d"
    "com.android.messaging"
    "com.android.dialer"
    "com.android.quicksearchbox"

    # Print Related
    "com.android.printspooler"
    "com.android.printservice.recommendation"
    "com.android.bips"

    # Useless System Apps
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

    # Screensaver & Wallpaper
    "com.android.dreams.basic"
    "com.android.dreams.phototable"
    "com.android.wallpaper.livepicker"
    "com.android.wallpaperbackup"
)

clear
echo "========================================"
echo "      Redfinger Debloater v1.1          "
echo "   github.com/lucivaantarez             "
echo "========================================"
echo ""

# Check root access
echo "[~] Checking root access..."
if ! su -c "echo ok" > /dev/null 2>&1; then
    echo "[X] Root not available! This script requires root (su)."
    echo "    Make sure your Redfinger has root enabled."
    exit 1
fi
echo "[OK] Root access confirmed!"
echo ""

echo "[!] The following packages will be removed:"
for pkg in "${PACKAGES[@]}"; do
    echo "    - $pkg"
done
echo ""
read -p "[?] Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo ""
    echo "[X] Aborted. Nothing was removed."
    exit 0
fi

echo ""
echo "========================================"
echo "[START] Debloating..."
echo "========================================"
echo ""

SUCCESS=0
SKIPPED=0
FAILED=0

for pkg in "${PACKAGES[@]}"; do
    printf "  Removing %-45s" "$pkg ..."
    result=$(su -c "pm uninstall --user 0 $pkg" 2>&1)

    if echo "$result" | grep -q "Success"; then
        echo "✅ Removed"
        ((SUCCESS++))
    elif echo "$result" | grep -q "not installed\|Unknown package"; then
        echo "⚠️  Skipped"
        ((SKIPPED++))
    else
        echo "❌ Failed"
        ((FAILED++))
    fi
done

echo ""
echo "========================================"
echo "  Removed : $SUCCESS"
echo "  Skipped : $SKIPPED"
echo "  Failed  : $FAILED"
echo "========================================"
echo "[DONE] Debloat complete!"
echo "========================================"
