# Toolbox Script

### Features:

1. Set DNS
2. Install aapanel
3. Install Docker
4. Install Gitlab Runner
5. Configure SSH Server
6. Configure Firewall
7. Optimize Server Performance
8. Run Network Speed Test
9. Change Mirror of Docker
10. Clean Logs of Ubuntu
11. Hard Disk Benchmark Ubuntu
12. Swap management



# Server Configuration Bash Script

This Bash script provides a menu-driven interface to perform various server configuration tasks. It automates tasks like setting up DNS, installing software packages like aaPanel and Docker, configuring SSH server, optimizing server performance, running network speed tests, changing Docker mirrors, benchmarking hard disks, and managing swap space.

## Features

- Menu-driven interface for easy navigation.
- Options for setting DNS with predefined servers or custom DNS.
- Automated installation of popular software packages like aaPanel, Docker, and GitLab Runner.
- Configuration of SSH server settings such as port number, root login, and key-based authentication.
- Firewall configuration with options to enable/disable incoming SSH, HTTP, and HTTPS connections.
- Optimizing server performance by adjusting kernel parameters and network settings (example configurations are commented out).
- Running network speed tests using speedtest-cli.
- Changing Docker mirrors for Iran servers.
- Benchmarking hard disks using fio and analyzing the results.
- Managing swap space with options to add, edit, or remove swap space.

  

## Usage:


### Download and Run Script from GitHub Repository

You can easily download and execute the `toolbox.sh` script from the GitHub repository using either `curl` or `wget`.

#### Using curl:

```bash
curl -O https://raw.githubusercontent.com/Amirali-Bagheri/toolbox-script/main/toolbox.sh && chmod +x toolbox.sh && ./toolbox.sh
```

- `curl -O https://raw.githubusercontent.com/Amirali-Bagheri/toolbox-script/main/toolbox.sh`: Downloads the `toolbox.sh` script from the specified URL and saves it with the same name in the current directory.
- `chmod +x toolbox.sh`: Changes the permissions of the downloaded script to make it executable.
- `./toolbox.sh`: Executes the downloaded script.

#### Using wget:

```bash
wget https://raw.githubusercontent.com/Amirali-Bagheri/toolbox-script/main/toolbox.sh && chmod +x toolbox.sh && ./toolbox.sh
```

- `wget https://raw.githubusercontent.com/Amirali-Bagheri/toolbox-script/main/toolbox.sh`: Downloads the `toolbox.sh` script from the specified URL.
- `chmod +x toolbox.sh`: Changes the permissions of the downloaded script to make it executable.
- `./toolbox.sh`: Executes the downloaded script.

## Important Note

This script is provided as-is, without any warranty. Use it at your own risk. Always review the code before executing it on your server.
Make sure to review the script content and its purpose before executing it on your system.
Follow the on-screen prompts to select and execute the desired configuration tasks.
