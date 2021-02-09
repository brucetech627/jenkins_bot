#!/usr/bin/env bash

#                   GNU GENERAL PUBLIC LICENSE
#                       Version 3, 29 June 2007
#
# Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#
# Script by @mrjarvis698

# Personal variables
export rom_dir=/home/ubuntu/bot
export BOT_API_KEY="1676380303:AAGdS7P4sNChgg-G6TdAVRl84ppBsGAvw8o"
export BOT_CHAT_ID2="1413501466"

. $(pwd)/export.sh

# Telegram Bot
sendMessage() {
    MESSAGE=$1
    curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$MESSAGE&chat_id=${BOT_CHAT_ID}" 1>/dev/null
    echo -e
    curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$MESSAGE&chat_id=${BOT_CHAT_ID2}" 1>/dev/null
    echo -e
}

# Repo Init
cd $rom_dir
mkdir Port
cd Port
sendMessage "Port ROM'S Download Initializing."
wget ${android_manifest_url}
cd ../
sendMessage "Port ROM Downloaded Successfully."

# Base Rom Download
sendMessage "base rom downloading."
mkdir base
cd base
wget https://tdrive.elytra8.workers.dev/xiaomi.eu_multi_HMNote7Pro_21.2.3_v12-10.zip
cd ../
sendMessage "Base downloaded Successfully."

# Unzip Port
sendMessage "Unzipping rom."
cd Port
unzip ROGChinaBeta21.2.3_V1.zip
cd ../
sendMessage "Unzipping done!."

# Copy System Files
sendMessage "Copying System Files."
mkdir result
cd Port
cp system.new.dat.br system.patch.dat system.transfer.list ../result
cd ../
sendMessage "Copied Sucessfully Successfully."

# Copy vendor, meta inf, boot.img, and cust files
sendMessage "copying files."
cd base
cp -R vendor.new.dat.br vendor.patch.dat vendor.transfer.list META-INF firmware-update boot.img cust.new.dat.br cust.patch.dat  cust.transfer.list ../result
cd ../
cd result
sendMessage "Copied Sucessfully."

# Zip files
sendMessage "Zipping Files."
zip -r port_rom META-INF firmware-update system.new.dat.br system.patch.dat system.transfer.list vendor.new.dat.br vendor.patch.dat vendor.transfer.list boot.img cust.new.dat.br cust.patch.dat  cust.transfer.list
sendMessage "Zip Completed."
# LAUNCH PROGRESS OBSERVER
sleep 60
while test ! -z "$(pidof soong_ui)"; do
        sleep 300
        # Get latest percentage
        PERCENTAGE=$(cat "$LOGFILE" | tail -n 1 | awk '{ print $2 }')
        # REPORT PerCentage to the Group
        sendMessage "Current percentage: $PERCENTAGE"
done



sendMessage "Port Finished. Check for your Build."
