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
            # Define colors
            GREEN_solid="\033[1;32m"
            NC="\033[0m"

            # Define an array of JSON strings
            dns_servers=(
                '{"number":1, "title":"Shecan", "dns":"178.22.122.100 185.51.200.2", "priority":1}'
                '{"number":2, "title":"403.online", "dns":"10.202.10.202 10.202.10.102", "priority":2}'
                '{"number":3, "title":"Electro", "dns":"78.157.42.100 78.157.42.101", "priority":3}'
                '{"number":4, "title":"Radar Game", "dns":"10.202.10.10 10.202.10.11", "priority":3}'
                '{"number":5, "title":"Server.ir", "dns":"194.104.158.48 194.104.158.78"}'
                '{"number":6, "title":"Host Iran", "dns":"172.29.0.100 172.29.2.100"}'
                '{"number":7, "title":"DNSPro.ir", "dns":"185.105.236.236 185.105.238.238"}'
                '{"number":8, "title":"Begzar", "dns":"185.55.226.26 185.55.225.25"}'
                '{"number":9, "title":"Shatel", "dns":"85.15.1.15 85.15.1.14"}'
                '{"number":10, "title":"Asia Tech", "dns":"194.36.174.161 178.22.122.100"}'
                '{"number":11, "title":"Pars Online", "dns":"91.99.101.12"}'
                '{"number":12, "title":"Pishgaman", "dns":"5.202.100.101"}'
                '{"number":13, "title":"Resaneh Pardaz", "dns":"185.186.242.161"}'
                '{"number":20, "title":"Cloudflare", "dns":"1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001", "priority":5}'
                '{"number":21, "title":"Open DNS", "dns":"208.67.222.222 208.67.220.220 2620:119:35::35 2620:119:53::53"}'
                '{"number":22, "title":"Google", "dns":"8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844", "priority":6}'
                '{"number":23, "title":"Quad9", "dns":"9.9.9.9 149.112.112.112 2620:fe::fe 2620:fe::9"}'
                '{"number":24, "title":"PiHole", "dns":"192.168.100.27 fd5c:c307:7993:db00:2e0:4cff:fe6b:1f4"}'
                '{"number":25, "title":"Some DNS", "dns":"91.239.100.100 89.233.43.71"}'
                '{"number":26, "title":"CZ_NIC", "dns":"193.17.47.1 185.43.135.1"}'
                '{"number":27, "title":"Level 3", "dns":"209.244.0.3 209.244.0.4"}'
                '{"number":28, "title":"Comodo Group", "dns":"8.26.56.26 8.20.247.20"}'
                '{"number":29, "title":"Control D", "dns":"76.76.2.0 76.76.10.0 2606:1a40:: 2606:1a40:1::"}'
                '{"number":30, "title":"Alternative", "dns":"76.76.19.19 76.223.122.150 2602:fcbc::ad 2602:fcbc:2::ad"}'
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

            # Function to print formatted options
            print_options() {
                local count=0
                for dns_server in "${dns_servers[@]}"; do
                    ((count++)) # Increment count

                    # Parse JSON string and extract fields
                    number=$(jq -r '.number' <<< "$dns_server")
                    title=$(jq -r '.title' <<< "$dns_server")

                    # Output the fields with space between objects
                    printf "(%-2s) %-40s" "$number" "$title"

                    # Add newline every 2 items to break into a new row
                    if ((count % 2 == 0)); then
                        printf "\n"
                    else
                        printf "%-1s" "" # Add spacing between two items
                    fi
                done
            }

            # Function to calculate average ping time for a given DNS server
            get_average_ping() {
                local dns=$1

                avg=$(ping -c 4 -q "$dns" | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
                if [ -z "$avg" ]; then
                    echo "9999"
                else
                    echo "$avg"
                fi
            }

            # Function to detect the operating system
            detect_os() {
                if [[ "$(uname)" == "Darwin" ]]; then
                    echo "macos"
                elif [[ "$(uname)" == "Linux" ]]; then
                    echo "linux"
                elif [[ "$(uname)" =~ ^CYGWIN.*$ ]]; then
                    echo "windows"
                else
                    echo "Unsupported operating system."
                    exit 1
                fi
            }

            # Function to set DNS based on the operating system
            set_dns() {
                local os=$1
                local dns=$2  # Added dns variable


                case "$os" in
                    "macos")
                        # macOS
                        dns_command="networksetup -setdnsservers Wi-Fi"
#                        networksetup -setdnsservers Wi-Fi "$dns"
                        ;;
                    "linux")
                        # Linux
                        dns_command="sudo bash -c 'echo \"nameserver $dns\" > /etc/resolv.conf'"

                        # Ask the user whether to install resolvconf service
                        read -p "Do you want to install resolvconf service? [y/N]: " install_resolvconf
                        if [[ $install_resolvconf =~ ^[Yy]$ ]]; then
                            sudo apt update
                            sudo apt install resolvconf -y
                            sudo systemctl start resolvconf.service
                            sudo systemctl enable resolvconf.service
                            dns_command="sudo bash -c 'echo \"nameserver $dns\" > /etc/resolvconf/resolv.conf.d/head'"

                        fi
                        ;;
                    "windows")
                        # Windows
                        # Set DNS command for Windows here
                        dns_command="netsh interface ip set dns \"Wi-Fi\" static $dns"
                        ;;
                    *)
                        echo "Unsupported operating system."
                        exit 1
                        ;;
                esac

                echo "Set DNS servers..."

                # Set DNS servers
                $dns_command $dns
            }

            # Prompt user for selection method
            read -p "Choose a method to set DNS servers:
            1) Find Best Server (Auto)
            2) Show List (Manual)
            3) Reset DNS
            4) Check DNS

            Enter your choice: " selection

            # Detect the operating system
            os=$(detect_os)

            if [ "$selection" == "1" ]; then

                clear

                # Auto: Calculate ping for each server and select the best one
                echo "Calculating ping for each server..."

                # Filter DNS servers based on priority
                filtered_dns_servers=()
                for dns_server in "${dns_servers[@]}"; do
                    priority=$(jq -r '.priority' <<< "$dns_server")
                    if [ -n "$priority" ] && [ "$priority" != "null" ]; then
                        filtered_dns_servers+=("$dns_server")
                    fi
                done

                # Create an array to store ping values
                pings=()

                # Calculate ping for each server and display the name and ping
                for dns_server in "${filtered_dns_servers[@]}"; do
                    dns=$(jq -r '.dns' <<< "$dns_server")
                    name=$(jq -r '.title' <<< "$dns_server")
                    ping=$(get_average_ping "$dns")
                    pings+=("$ping")  # Add ping value to pings array
                    echo "$name, Ping: $ping ms"
                done

                # Find the index of the server with the lowest ping
                lowest_ping_index=-1
                min_ping=9999
                for i in "${!pings[@]}"; do
                    ping="${pings[$i]}"
                    if [ "$ping" != "9999" ] && (( $(bc <<< "$ping < $min_ping") )); then
                        min_ping=$ping
                        lowest_ping_index=$i
                    fi
                done

                # Set DNS server if a server with a valid ping is found
                if [ "$lowest_ping_index" != "-1" ]; then
                    best_dns=$(jq -r '.dns' <<< "${filtered_dns_servers[$lowest_ping_index]}")
                    name=$(jq -r '.title' <<< "${filtered_dns_servers[$lowest_ping_index]}")
                    echo "\n Setting DNS to $name \n"

                    # Set DNS based on the operating system
                    set_dns "$os" "$best_dns"

                    exit
                else
                    echo "Failed to find the best server."
                fi

            elif [ "$selection" == "2" ]; then
                # Manual: Show list of DNS servers for manual selection
                echo -e "\n\n${GREEN_solid}Choose an option to change your DNS server:\n\n${NC}\c"
                print_options

                # Display custom and reset options
                printf '\n\n(0) Custom DNS \n'

                # Read selected number from terminal
                read -p "Enter the number corresponding to your choice: " dns_choose

                # Set DNS servers based on the selected number
                if [ "$dns_choose" -eq "0" ]; then
                    read -p "Enter the desired DNS server: " custom_dns
                    dns="$custom_dns"
                else
                    dns=$(jq -r '.dns' <<< "${dns_servers[$((dns_choose-1))]}")
                fi

                # Detect the operating system
                os=$(detect_os)

                # Set DNS based on the operating system
                set_dns "$os" "$dns"

                echo "\n\n${GREEN_solid}DNS Setup Done.\n${NC}\c"

                exit

            elif [ "$selection" == "3" ]; then

                # Function to reset DNS based on the operating system
                reset_dns() {
                    local os=$1

                    case "$os" in
                        "macos")
                            # Reset DNS settings for macOS
                            networksetup -setdnsservers Wi-Fi empty
                            ;;
                        "linux")
                            # Reset DNS settings for Linux
                            echo "nameserver" | sudo tee /etc/resolvconf/resolv.conf.d/head
                            sudo resolvconf -u
                            ;;
                        "windows")
                            # Reset DNS settings for Windows
                            netsh interface ip set dns "Ethernet" dhcp
                            ;;
                        *)
                            echo "Unsupported operating system."
                            exit 1
                            ;;
                    esac
                }

                # Reset DNS settings
                echo "Resetting DNS..."

                reset_dns "$os"

                echo "DNS servers are reset."

                exit

            elif [ "$selection" == "4" ]; then

                # Function to find the name of a DNS server by its IP address
                find_dns_name() {
                    local ip_address=$1

                    for dns_server in "${dns_servers[@]}"; do
                        dns=$(jq -r '.dns' <<< "$dns_server")
                        name=$(jq -r '.title' <<< "$dns_server")

                        # Split the DNS string into individual IP addresses
                        IFS=' ' read -ra dns_ips <<< "$dns"

                        # Check if the given IP address matches any of the DNS IPs
                        for dns_ip in "${dns_ips[@]}"; do
                            if [ "$dns_ip" == "$ip_address" ]; then
                                echo "DNS Server Name: $name"
                                return
                            fi
                        done
                    done

                    echo "DNS server with IP address $ip_address not found."
                }

                # Function to check DNS configuration and ping for each server
                check_dns_and_ping() {
                    local os=$1

                    # Print current DNS settings
                    case "$os" in
                        "macos")
                            echo "Current DNS servers:"
                            networksetup -getdnsservers Wi-Fi
                            ;;
                        "linux")
                            echo "Current DNS servers:"
                            cat /etc/resolv.conf | grep nameserver
                            ;;
                        "windows")
                            echo "Current DNS servers:"
                            ipconfig /all | findstr "DNS Servers"
                            ;;
                        *)
                            echo "Unsupported operating system."
                            exit 1
                            ;;
                    esac

                    # Get the DNS servers IP addresses
                    case "$os" in
                        "macos")
                            dns_ips=($(networksetup -getdnsservers Wi-Fi | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"))
                            ;;
                        "linux")
                            dns_ips=($(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'))
                            ;;
                        "windows")
                            dns_ips=($(ipconfig /all | findstr "DNS Servers" | sed 's/.*: //'))
                            ;;
                    esac

                    # Find and print DNS server name for the first IP address
                    find_dns_name "${dns_ips[0]}"

                }

                # Check DNS and ping
                check_dns_and_ping "$os"

                exit

            else
                echo "Invalid selection. Exiting..."
                exit 1
            fi

            ;;
        2)
            echo "Running Installer aapanel"
            URL=https://www.aapanel.com/script/install_6.0_en.sh && if [ -f /usr/bin/curl ];then curl -ksSO "$URL" ;else wget --no-check-certificate -O install_6.0_en.sh "$URL";fi;bash install_6.0_en.sh aapanel
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
            echo "Running Gitlab Runner Installer On Ubuntu"

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
            sudo chown -R gitlab-runner /var/www
            sudo usermod -aG docker gitlab-runner
            sudo usermod -a -G sudo gitlab-runner

            # Create SSH Key for gitlab-runner
            sudo -u gitlab-runner ssh-keygen -b 4096 -t rsa -N "" -f /home/gitlab-runner/.ssh/id_rsa
            sudo -u gitlab-runner cat /home/gitlab-runner/.ssh/id_rsa.pub >> /home/gitlab-runner/.ssh/authorized_keys
            sudo -u gitlab-runner cat /home/gitlab-runner/.ssh/id_rsa
            sudo -u gitlab-runner cat /home/gitlab-runner/.ssh/id_rsa.pub

            # Copy id_rsa.pub and add to SSH keys on Gitlab

            # Add Remote of SSH of Git
            sudo -u gitlab-runner ssh -T git@gitlab.com

            # Git Safe Directory
            sudo -u gitlab-runner git config --global --add safe.directory '*'

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

            echo "Comming Soon..."

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
        10)
            # Clean Logs of Ubuntu
            echo "Cleaning Logs of Ubuntu..."

            # Ask if user wants to truncate Docker logs
            read -p "Do you want to truncate Docker logs? (Y/n): " docker_truncate_choice
            docker_truncate_choice=${docker_truncate_choice:-Y}
            if [ "${docker_truncate_choice^^}" = "Y" ]; then
                # Truncate Docker logs
                echo "Truncating Docker logs..."
                truncate -s 0 /var/lib/docker/containers/**/*-json.log
            fi

            # Ask for cleaning unimportant Docker files
            read -p "Do you want to clean other unimportant Docker files? (Y/n): " docker_clean_choice
            docker_clean_choice=${docker_clean_choice:-Y}
            if [ "${docker_clean_choice^^}" = "Y" ]; then
                # Perform additional Docker cleanup steps here
                echo "Performing Docker system prune -a..."
                docker system prune -a -f
            fi

            # Vacuum logs and other system logs
            read -p "Do you want to perform system logs vacuuming? (Y/n): " sys_logs_vacuum_choice
            sys_logs_vacuum_choice=${sys_logs_vacuum_choice:-Y}
            if [ "${sys_logs_vacuum_choice^^}" = "Y" ]; then
                echo "Performing system logs vacuuming..."

                # Rotate and compress system logs
                logrotate -f /etc/logrotate.conf

                # Clear systemd journal logs
                journalctl --vacuum-time=1d
            fi

            # Remove old kernel versions
            read -p "Do you want to remove old kernel versions? (Y/n): " kernel_cleanup_choice
            kernel_cleanup_choice=${kernel_cleanup_choice:-Y}
            if [ "${kernel_cleanup_choice^^}" = "Y" ]; then
                echo "Removing old kernel versions..."
                sudo apt autoremove --purge
            fi

            # Clean package cache
            read -p "Do you want to clean package cache? (Y/n): " package_cache_cleanup_choice
            package_cache_cleanup_choice=${package_cache_cleanup_choice:-Y}
            if [ "${package_cache_cleanup_choice^^}" = "Y" ]; then
                echo "Cleaning package cache..."
                sudo apt clean
            fi

            echo "Log cleaning completed."

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
