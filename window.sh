#!/bin/bash

str=$(cat <<EOF
#!/bin/bash
xfce4-appfinder && sleep 0.1 && wmctrl -r "Application Finder" -b add,above
EOF
)

sudo echo "$str" > /usr/bin/wstart.sh
