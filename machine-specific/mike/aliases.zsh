# SSHFS
alias sshfsl='sshfs lorenzo0:/var/www/services /mnt/vm_lorenzo0; cd /mnt/vm_lorenzo0'
alias sshm='sudo umount /mnt/meteor_node; sshfs lorenzo0:/home/michael/meteor-node /mnt/meteor_node; cd /mnt/meteor_node'
alias sshlh='sshfs lorenzo0:/home/michael/ /mnt/lorenzo_home; cd /mnt/lorenzo_home'

# Moving around
alias cpd='cd /mnt/vm_lorenzo0/pushdelivery'
alias cps='cd /mnt/vm_lorenzo0/pushscheduler'
alias cm='cd /mnt/meteor_node'
alias cl='cd /mnt/lorenzo_home'

# Vim
alias epd='e /mnt/vm_lorenzo0/pushdelivery'
alias eps='e /mnt/vm_lorenzo0/pushscheduler'
alias em='e /mnt/meteor_node'


# Storyteller
function storyteller {
	(cd ~/Testing/storyteller; ./start-selenium.sh 2&>1 > /dev/null &); 
	(cd ~/Testing/storyteller; ./start-browsermob-proxy.sh 2&>1 > /dev/null &)
	cd ~/Testing/storyteller/src/main;
}
