#!/bin/sh
# Maintained by: toleda for: github.com/toleda/audio_ALC1150
# File: audio_alc1150-90_patch.sh_v1.0
# Credit: THeKiNG, VCH888, .:ErmaC:., bcc9, RevoGirl, PikeRAlpha, SL_UnderWater,
# hackintoshfreedom
#
# OS X Realtek ALC1150 Onboard Audio
#
# Enables OS X Realtek ALC1150 onboard audio in Mountain Lion 10.9 and newer
# 1. Patches native AppleHDA.kext installed in System/Library/Extensions
# 2. Rename Desktop/audio_ALC1150 to audio_ALC1150-archive (if present)
# 3. Verify Downloads/audio_ALC1150-master present
#
# Installation
# 1. Downloads/audio_ALC1150-master/audio_alc1150-85_patch.command
# 2. Double click audio_alc1150-85_patch.command
# 3. Enter password at prompt
#
echo " "
echo "Agreement"
echo "The audio_ALC1150_patch is for personal use only. Do not distribute the patch," 
echo "any or all of the enclosed files or the resulting patched AppleHDA.kext for any" 
echo "reason without permission. The audio_ALC1150_patch is provided as is and without" 
echo "any kind of warranty."
echo " "
#
echo "Prepare Desktop/audio_ALC1150 ..."
cd ~
cp -R Downloads/audio_ALC1150-master Desktop/audio_ALC1150
cp -R /System/Library/Extensions/AppleHDA.kext Desktop/audio_ALC1150/AppleHDA-orig.kext
cd Desktop/audio_ALC1150
unzip 1150.zip
cd 1150

echo "Install files ..."
sudo rm -R /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist
sudo install -m 644 -o root -g wheel Info-90.plist /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist
sudo rm -R /System/Library/Extensions/AppleHDA.kext/Contents/Resources/*.zlib
sudo install -m 644 -o root -g wheel Platforms.xml.zlib layout1.xml.zlib layout2.xml.zlib  /System/Library/Extensions/AppleHDA.kext/Contents/Resources

echo "Patch binary ..."
sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x00\x09\xec\x10|g' /System/Library/Extensions/AppleHDA.kext/Contents/MacOS/AppleHDA

echo "Fix permissions ..."
sudo chown -R root:wheel /System/Library/Extensions/AppleHDA.kext

echo "Kernel cache..."
sudo touch /System/Library/Extensions

cd ~
rm -R Desktop/audio_ALC1150/1150
cp -R /System/Library/Extensions/AppleHDA.kext Desktop/audio_ALC1150/AppleHDA.kext

echo "Finished, restart required."