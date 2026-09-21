#!/bin/bash
# Default deny public zone with service rule(s) allowed to specific source IP
set -euo pipefail

# Service Configuration
SOURCEIP="192.168.1.1" # for entire subnet ranges add /24
SVCPORT1="443"
#SVCPORT2=""
SVCPROTO1="tcp"
#SVCPROTO2=""
#
# 1. Add additional service ports
sudo firewall-cmd --permanent --add-rich-rule="rule family=\"ipv4\" source address=\"$SOURCEIP\" port port=\"$SVCPORT1\" protocol=\"$SVCPROTO1\" accept"
sudo firewall-cmd --reload
#sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address=\"$SOURCEIP\" port port=\"$SVCPORT2\" protocol=\"$SVCPROTO2\" accept' && sudo firewall-cmd --reload

# 2. Other config changes.
#sudo firewall-cmd --permanent --zone=public --remove-service=cockpit
#sudo firewall-cmd --set-default-zone=public

# 3. Set the drop target permanently, not live/runtime.
sudo firewall-cmd --permanent --zone=public --set-target=DROP

# 4. Apply everything in one shot.
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# 5. Remove rules
# sudo firewall-cmd --remove-rich-rule='rule family="ipv4" source address="" port port="" protocol="" accept' --permanent

# 6. Raw rules
#
# Service port to specific IP range
#
# sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.20.1.0/24" port port="8080" protocol="tcp" accept'
#
# SSH to specific IP range
#
# sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.50" service name="ssh" accept'
