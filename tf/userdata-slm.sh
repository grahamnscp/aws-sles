#!/bin/bash
# combustion:

# Redirect output to the console
exec > >(exec tee -a /dev/tty0) 2>&1

echo "==========> Started combustion config script.."

# shell
echo "alias l='ls -latFrh'" >> /home/ec2-user/.bashrc
echo "alias vi=vim"         >> /home/ec2-user/.bashrc
echo "set background=dark"  >> /home/ec2-user/.vimrc
chown ec2-user:users /home/ec2-user/.vimrc
echo "alias l='ls -latFrh'" >> /root/.bashrc
echo "alias vi=vim"         >> /root/.bashrc
echo "set background=dark"  >> /root/.vimrc


# create systemd script for fist boot config
echo Creating slm-config.sh script for first boot..
cat > /root/bin/slm-config.sh << _EOFSCRIPT_
#!/bin/bash

if [ ! -e /root/.slm-config-started ] ; then
  touch /root/.slm-config-started
fi

echo "slm-config: Started.."


echo slm-config: Running transactional-update pkg install..
transactional-update --continue --non-interactive pkg install jq


echo "slm-config: Done, exiting.."
touch /root/.slm-config-ran
systemctl reboot
exit 0

_EOFSCRIPT_
chmod 0755 /root/bin/slm-config.sh

echo Creating slm-config systemd service definition..
cat <<- _EOFCONFIG_ > /etc/systemd/system/slm-config.service
[Unit]
Description=Custom SL Micro Config Service
Wants=network-online.target
After=network.target network-online.target
ConditionPathExists=/root/bin/slm-config.sh
ConditionPathExists=!/root/.slm-config-ran

[Service]
Type=forking
TimeoutStartSec=900
ExecStart=/root/bin/slm-config.sh
RemainAfterExit=yes
KillMode=process

[Install]
WantedBy=multi-user.target
_EOFCONFIG_
chmod 0644 /etc/systemd/system/slm-config.service
systemctl enable slm-config.service


# done
echo "Configured with combustion at boot" >> /etc/issue.d/combustion
echo "" >> /etc/issue.d/combustion

echo "userdata: ==========> Exiting combustion config script and rebooting.."
systemctl reboot
exit 0

