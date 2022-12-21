#!/bin/bash

if ! [ $(id -u) = 0 ]; then
    echo "This script must be run as sudo or root, try again..."
    exit 1
fi;

light_folder_badge_opacity=1.0
dark_folder_badge_opacity=1.0


light_icons="$(find /usr/share/icons/breeze/places/* -type f -and ! -path '*16*' -and ! -path '*22*' -and ! -path '*symbolic*' | xargs grep -nl "ColorScheme-Text")"

dark_icons="$(find /usr/share/icons/breeze-dark/places/* -type f -and ! -path '*16*' -and ! -path '*22*' -and ! -path '*symbolic*' | xargs grep -nl "ColorScheme-Text")"


# badge text to bg
match1='class=\"ColorScheme-Text\"'
replace1='class=\"ColorScheme-Background\"'
#badge opacity
match2='\"fill:currentColor;fill-opacity:*.*\;stroke:none\"'
replace2='\"fill:currentColor;fill-opacity:'${light_folder_badge_opacity}'\;stroke:none\"'

echo "Patching light icons in place..."
while IFS= read -r line; do
    sed -i "s/${match1}/${replace1}/g" $line
    sed -i "s/${match2}/${replace2}/g" $line
done <<< "$light_icons"


# badge text to bg
match1='class=\"ColorScheme-Text\"'
replace1='class=\"ColorScheme-Background\"'
#badge opacity
match2='\"fill:currentColor;fill-opacity:*.*\;stroke:none\"'
replace2='\"fill:currentColor;fill-opacity:'${dark_folder_badge_opacity}'\;stroke:none\"'

echo "Patching dark icons in place..."
while IFS= read -r line; do
    sed -i "s/${match1}/${replace1}/g" $line
    sed -i "s/${match2}/${replace2}/g" $line
done <<< "$dark_icons"

echo "Done!"
