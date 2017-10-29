#!/bin/bash
id | grep sudo >/dev/null
sudo="$?"
if [ "$sudo" == "0" ];then
	##User is Sudo 
		sudo cp dns-fixer.sh /usr/bin/dns-fixer
		cpfile="$?"
		sudo chmod +x /usr/bin/dns-fixer
		perm="$?"
		if [ "$perm" == "0" ] && [ "$cpfile" == "0" ] ;then
			echo -e "\033[92mThe Application Hase Been Installed Sucsessfully!"
			exit 0
		else
			echo -e "\033[91mInstalltion Failed!"
			exit 1
		fi
else
	##User Is'nt Sudo
	read -p "Because you are not in the SUDO group, we have to copy the files in your /home directory. Do you give us that permission? (Y|n) " install_for_user
	if [ "$install_for_user" == "Y" ] || [ "$install_for_user" == "y" ] || [ "$install_for_user" == "" ] ; then
		mkdir -p "~/bin"
		make_dir="$?"
		cp dns-fixer.sh ~/bin/dns-fixer
		copy_file="$?"
		chmod +x ~/bin/dns-fixer
		change_mode="$?"
		if [ "$make_dir" == "0" ] && [ "$copy_file" == "0" ] && [ "$change_mode" == "0" ] ;then
			PATH="$PATH:/home/$USER/bin"
			echo "PATH="$PATH:/home/$USER/bin"" >> ~/.bashrc
			echo -e "\033[92mThe Application Hase Been Installed for your User, Sucsessfully!"
			exit 0 
		else
			echo -e "\033[91mInstalltion Failed!"
			exit 1
		fi
	else
		echo "Abort."
		exit 1 
	fi
fi
