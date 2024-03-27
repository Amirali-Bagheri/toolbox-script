#!/bin/bash

RED='\033[91m'
GREEN='\033[92m'
GREEN_solid='\033[42m'
CYAN='\033[96m'
NC='\033[0m'

# Function to display the menu
display_menu() {
    echo "Menu Options:"
    echo "1. Set DNS"
    echo "2. Install aapanel"
    echo "3. Install Docker"
    echo "4. Install Gitlab Runner"
    echo "5. Configure SSH Server"
    echo "6. Configure Firewall"
    echo "7. Optimize Server Performance"
    echo "8. Run Network Speed Test"
    echo "9. Change Mirror of Docker "
    echo "10. Clean Logs of Ubuntu"
    echo "11. Hard Disk Benchmark Ubuntu"
    echo "12. Swap management"
    echo "0. Quit"
}

# Function to prompt for yes/no confirmation
confirm() {
    read -r -p "$1 [y/N]: " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Function to execute the selected command
execute_command() {
    case $1 in
        1)
            echo "${GREEN_solid}\nChoose an option to change your DNS server:${NC}\c"

            # Define an array of JSON strings
            dns_servers=(
                '{"number":1, "title":"Shecan", "dns":"178.22.122.100 185.51.200.2"}'
                '{"number":2, "title":"403.online", "dns":"10.202.10.202 10.202.10.102"}'
                '{"number":3, "title":"Electro", "dns":"78.157.42.100 78.157.42.101"}'
                '{"number":4, "title":"Radar Game", "dns":"10.202.10.10 10.202.10.11"}'
                '{"number":5, "title":"Server.ir", "dns":"194.104.158.48 194.104.158.78"}'
                '{"number":6, "title":"Host Iran", "dns":"172.29.0.100 172.29.2.100"}'
                '{"number":7, "title":"DNSPro.ir", "dns":"185.105.236.236 185.105.238.238"}'
                '{"number":8, "title":"Begzar", "dns":"185.55.226.26 185.55.225.25"}'
                '{"number":9, "title":"Shatel", "dns":"85.15.1.15 85.15.1.14"}'
                '{"number":10, "title":"Asia Tech", "dns":"194.36.174.161 178.22.122.100"}'
                '{"number":11, "title":"Pars Online", "dns":"91.99.101.12"}'
                '{"number":12, "title":"Pishgaman", "dns":"5.202.100.101"}'
                '{"number":13, "title":"Resaneh Pardaz", "dns":"185.186.242.161"}'
                '{"number":20, "title":"Cloudflare", "dns":"1.1.1.1 1.0.0.1"}'
                '{"number":21, "title":"Open DNS", "dns":"208.67.222.222 208.67.220.220"}'
                '{"number":22, "title":"Google", "dns":"8.8.8.8 8.8.4.4"}'
                '{"number":23, "title":"Quad9", "dns":"9.9.9.9 149.112.112.112"}'
                '{"number":24, "title":"PiHole", "dns":"192.168.100.27"}'
                '{"number":25, "title":"Some DNS", "dns":"91.239.100.100 89.233.43.71"}'
                '{"number":26, "title":"CZ_NIC", "dns":"193.17.47.1 185.43.135.1"}'
                '{"number":27, "title":"Level 3", "dns":"209.244.0.3 209.244.0.4"}'
                '{"number":28, "title":"Comodo Group", "dns":"8.26.56.26 8.20.247.20"}'
                '{"number":29, "title":"Control D", "dns":"76.76.2.0 76.76.10.0"}'
                '{"number":30, "title":"Alternative", "dns":"76.76.19.19 76.223.122.150"}'
                '{"number":31, "title":"Versign", "dns":"64.6.64.6 64.6.65.6"}'
                '{"number":32, "title":"Open Nic", "dns":"216.87.84.211 23.90.4.6"}'
                '{"number":33, "title":"Yandex", "dns":"77.88.8.8 77.88.8.1"}'
                '{"number":34, "title":"Dns Watch", "dns":"84.200.69.80 84.200.70.40"}'
                '{"number":35, "title":"Oracle Dyn", "dns":"216.146.35.35 216.146.36.36"}'
                '{"number":36, "title":"Freenom World", "dns":"80.80.80.80 80.80.81.81"}'
                '{"number":37, "title":"Flash Start", "dns":"185.236.104.104 185.236.105.105"}'
                '{"number":38, "title":"Neustar DNS", "dns":"156.154.70.5 156.154.71.5"}'
                '{"number":39, "title":"DYN", "dns":"216.146.35.35 216.146.36.36"}'
            )

            printf "\n"
            count=0
            # Loop through the array and parse each JSON string
            for dns_server in "${dns_servers[@]}"; do
                # Increment count
                ((count++))

                # Parse JSON string and extract fields
                number=$(jq -r '.number' <<< "$dns_server")
                title=$(jq -r '.title' <<< "$dns_server")

                # Output the fields with space between objects
                printf "$number. $title"

                # Add newline every 5 items to break into a new row
                if ((count % 3 == 0)); then
                    printf "\n"
                else
                    printf "%-20s" "" # Add spacing between two items
                fi

            done

            printf '0. Custom DNS           101. Reset DNS';
            printf '\n\n Enter Number:';
 


            read dns_choose;

            dns=$(jq -r '.dns' <<< "${dns_servers[$((dns_choose-1))]}")

            printf 'Choose OS: \n
            a. MacOS    b. Linux    c. Windows
            \n Choose OS: ';

            read os_choose;

            if [ "$os_choose" == 'a' ]
            then

                # Custom
                if [ "$dns_choose" -eq "0" ]; then
                    printf 'Enter a desired DNS server: '
                    read DNS;
                    networksetup -setdnsservers Wi-Fi $DNS
                fi

                echo "[✓]${RED}Setup DNS...${NC}"


                # Check if var is set and within range
                if [[ -n $dns_choose && ${dns_servers[$dns_choose]+exists} ]]; then
                    
                    # Set DNS servers
                    networksetup -setdnsservers Wi-Fi $dns
                else
                    echo "Invalid selection or var is not set."
                fi

                # Reset DNS
                if [ "$dns_choose" -eq "101" ]; then
                    echo "[✓]${RED}Removing${NC} these DNS servers:\n${CYAN}$(networksetup -getdnsservers Wi-Fi)${NC}"
                    sleep 0.5
                    networksetup -setdnsservers Wi-Fi empty
                    echo "${RED}[!]${NC}DNS servers are reset to your DHCP."
                    DNScheck
                fi


                echo "[✓]${GREEN}DNS Setup Done. ${NC}"

            elif [ "$os_choose" == 'b' ]; then
                                
                # Update system software packages
                sudo apt update

                # Install resolvconf
                sudo apt install resolvconf -y

                # Start and enable resolvconf service
                sudo systemctl start resolvconf.service
                sudo systemctl enable resolvconf.service

                # Clear resolv.conf.d/head
                echo "" | sudo tee /etc/resolvconf/resolv.conf.d/head > /dev/null

                # Loop through each DNS server and add as a separate nameserver entry
                for ip in $dns; do
                    sudo bash -c "echo \"nameserver $ip\" >> /etc/resolvconf/resolv.conf.d/head"
                done

                # Restart resolvconf and systemd-resolved services
                sudo systemctl restart resolvconf.service
                sudo systemctl restart systemd-resolved.service

            elif [ "$os_choose" == 'c' ]; then
                echo "Coming Soon..."
            else
                echo "No OS chosen!"
            fi

            ;;
        2)
            echo "Running Installer aapanel"
            wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh 93684c35
            echo "aapanel Successfully Installed"
            ;;
        3)
            echo "Running Docker Installer"
            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh ./get-docker.sh
            apt install docker-compose
            docker -v
            docker-compose -v
            echo "Docker Successfully Installed"
            ;;
        4)
            echo "Running Gitlab Runner Installer"
        
            # Download the binary for your system
            sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
            
            # Give it permission to execute
            sudo chmod +x /usr/local/bin/gitlab-runner
            
            # Create a GitLab Runner user
            sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
            
            # Install and run as a service
            sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
            sudo gitlab-runner start
            
            # Prompt for registration token
            read -p "Enter the GitLab Runner registration token: " registration_token
            
            # Command to register runner
            sudo gitlab-runner register --url https://gitlab.com/ --registration-token "$registration_token"
            
            # Permissions of gitlab-runner user
            sudo apt install acl
            sudo setfacl -R -m u:gitlab-runner:rwx /var/www
            chown -R gitlab-runner /var/www
            usermod -aG docker gitlab-runner
            sudo usermod -a -G sudo gitlab-runner
            
            # Create SSH Key for gitlab-runner
            su gitlab-runner
            ssh-keygen -b 4096
            cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
            cat ~/.ssh/id_rsa
            cat ~/.ssh/id_rsa.pub
            
            # Copy id_rsa.pub and add to SSH keys on Gitlab 
            
            # Add Remote of SSH of Git 
            ssh -T git@gitlab.com
            
            # Git Safe Directory
            git config --global --add safe.directory '*'
            
            echo "Gitlab Runner Successfully Installed"
            ;;
        5)
            echo "Configuring SSH Server"
            # Prompt for advanced SSH server configuration options
            read -p "Enter the new SSH port number (default is 22): " ssh_port
            read -p "Disable root login? [y/N]: " disable_root_login
            read -p "Enable key-based authentication? [y/N]: " enable_key_auth

            # Update SSH configuration file
            sudo sed -i "s/^#Port 22/Port $ssh_port/" /etc/ssh/sshd_config
            
            if [[ $disable_root_login == [yY][eE][sS] || $disable_root_login == [yY] ]]; then
                sudo sed -i "s/^#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
            fi

            if [[ $enable_key_auth == [yY][eE][sS] || $enable_key_auth == [yY] ]]; then
                sudo sed -i "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
            fi
            
            sudo systemctl restart sshd
            echo "SSH server configured with new port and advanced settings."
            ;;
        6)
            echo "Configuring Firewall"
            
            # Check if UFW is installed
            if ! command -v ufw &> /dev/null; then
                echo "UFW is not installed. Installing UFW..."
                sudo apt update
                sudo apt install ufw -y
            fi
        
            # Prompt for firewall rules
            read -p "Enable incoming SSH connections? [y/N]: " enable_ssh
            read -p "Enable incoming HTTP connections? [y/N]: " enable_http
            read -p "Enable incoming HTTPS connections? [y/N]: " enable_https
        
            # Enable UFW
            sudo ufw enable
        
            # Allow incoming SSH connections if enabled
            if [[ $enable_ssh == [yY][eE][sS] || $enable_ssh == [yY] ]]; then
                sudo ufw allow ssh
            fi
        
            # Allow incoming HTTP connections if enabled
            if [[ $enable_http == [yY][eE][sS] || $enable_http == [yY] ]]; then
                sudo ufw allow http
            fi
        
            # Allow incoming HTTPS connections if enabled
            if [[ $enable_https == [yY][eE][sS] || $enable_https == [yY] ]]; then
                sudo ufw allow https
            fi
        
            # Reload firewall rules
            sudo ufw reload
        
            echo "Firewall configuration complete."
            ;;
        7)
            echo "Optimizing Server Performance"
        
            # # Adjust kernel parameters
            # sudo sysctl -w fs.file-max=100000
            # sudo sysctl -w vm.max_map_count=262144
        
            # # Optimize network settings (example: TCP/IP stack)
            # sudo sysctl -w net.ipv4.tcp_max_syn_backlog=8192
            # sudo sysctl -w net.core.somaxconn=65535
        
            # # Enable caching (example: enable disk read cache)
            # sudo sysctl -w vm.dirty_background_bytes=67108864
            # sudo sysctl -w vm.dirty_ratio=80
        
            # echo "Server performance optimization complete."

            ;;
        8)
            echo "Running Network Speed Test"

            # Install speedtest-cli if not installed
            if ! command -v speedtest-cli &> /dev/null; then
                echo "speedtest-cli is not installed. Installing speedtest-cli..."
                sudo apt update
                sudo apt install speedtest-cli -y
            fi
        
            # Run the speed test
            speedtest-cli

            ;;
            
        9)
            echo "Changing Docker mirror for Iran Servers"
        
            # Docker daemon configuration file path
            docker_daemon_file="/etc/docker/daemon.json"
            
            # Update the mirror URLs
            echo '{
                "insecure-registries" : ["https://registry.docker.ir", "https://docker.iranserver.com", "https://focker.ir", "https://docker.arvancloud.ir"],
                "registry-mirrors": ["https://registry.docker.ir", "https://docker.iranserver.com", "https://focker.ir", "https://docker.arvancloud.ir"]
            }' | sudo tee "$docker_daemon_file" >/dev/null
        
            # Reload the Docker daemon
            sudo systemctl daemon-reload
        
            # Restart Docker service
            sudo systemctl restart docker
        
            echo "Docker mirror changed and daemon reloaded."
            ;;
        11)
            echo "Check Hard Disk Benchmark Ubuntu"

            # Install fio
            apt update
            apt install software-properties-common && add-apt-repository universe
            apt install fio

            # Define the benchmark parameters
            test_file="./temp_fio_test_file"
            result_file="./fio_result.json"
            test_size="1G"  # Adjust the size according to your needs
            test_runtime=60  # Adjust the runtime of the test in seconds

            # Run the benchmark test
            echo "Running fio benchmark test..."
            sudo fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=4k --size=$test_size --runtime=$test_runtime --filename=$test_file --direct=1 --numjobs=1 --group_reporting --output-format=json > $result_file

            # Analyze the results
            echo "Analyzing fio benchmark result..."
            if [ ! -f "$result_file" ]; then
                echo "Failed to save benchmark results. Check if fio test was successful."
                exit 1
            fi

            iops=$(jq -r '.jobs[0].write.iops' $result_file)
            bw=$(jq -r '.jobs[0].write.bw' $result_file)
            if [ -z "$iops" ] || [ -z "$bw" ]; then
                echo "Failed to get benchmark results. Check if fio test was successful."
                exit 1
            fi

            # Print the results
            echo "Benchmark results:"
            echo "IOPS: $iops"
            echo "Bandwidth: $bw"

            # Define thresholds for status
            warning_iops=10000
            warning_bw="100 MB/s"
            ok_iops=20000
            ok_bw="200 MB/s"

            # Check the status
            if (( $(echo "$iops < $warning_iops" | bc -l) )); then
                echo "Warning: Low IOPS. Consider optimizing disk performance."
            elif (( $(echo "$iops < $ok_iops" | bc -l) )); then
                echo "Status: IOPS performance is OK."
            fi

            if (( $(echo "$bw < $(echo $warning_bw | tr -d 'MB/s')" | bc -l) )); then
                echo "Warning: Low Bandwidth. Consider optimizing disk performance."
            elif (( $(echo "$bw < $(echo $ok_bw | tr -d 'MB/s')" | bc -l) )); then
                echo "Status: Bandwidth performance is OK."
            fi

            # Clean up
            rm $result_file

            ;;
        12)
            # Check if root
            if [ "$(id -u)" != "0" ]; then
                echo "This script must be run as root."
                exit 1
            fi

            echo "Select an option:"
            echo "  1. Add swap space"
            echo "  2. Edit existing swap space"
            echo "  3. Remove swap space"

            read -p "Enter option number: " choice

            if [ "$choice" == "1" ]; then
                read -p "Enter the size of swap space to add (e.g., 1G, 2G, 512M): " swap_size
                sudo fallocate -l $swap_size /swapfile
                sudo chmod 600 /swapfile
                sudo mkswap /swapfile
                sudo swapon /swapfile
                echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
                echo "Swap space of $swap_size added successfully."
            elif [ "$choice" == "2" ]; then
                sudo swapoff -a
                read -p "Enter the new size of swap space (e.g., 1G, 2G, 512M): " swap_size
                sudo fallocate -l $swap_size /swapfile
                sudo chmod 600 /swapfile
                sudo mkswap /swapfile
                sudo swapon /swapfile
                echo "Swap space edited successfully."
            elif [ "$choice" == "3" ]; then
                sudo swapoff -a
                sudo rm /swapfile
                sudo sed -i '/swapfile/d' /etc/fstab
                echo "Swap space removed successfully."
            else
                echo "Invalid option"
            fi

            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Main script logic
while true; do
    display_menu

    read -p "Enter an option number: " option

    if [[ $option == 0 ]]; then
        echo "Quitting..."
        break
    fi

    execute_command $option


    echo
done
