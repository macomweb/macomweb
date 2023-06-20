wget -O ng.sh https://raw.githubusercontent.com/macomweb/macomweb/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh


function goto
{
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP 

clear
echo "Repo: https://github.com/macomweb/macomweb/"
echo "======================="
echo "choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " CRP
./ngrok tcp --region $CRP 4000 &>/dev/null &
sleep 1
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi


# Define common parts of the Docker command
docker_common_command="docker run --rm -d --network host --privileged --cap-add=SYS_PTRACE --shm-size=1g"
password="123456"
user="reality"

# Print menu
echo "Please choose a Linux environment:"
echo "1. NoMachine Mate (Ubuntu with Mate desktop)"
echo "2. NoMachine XFCE4 (Ubuntu with XFCE4 desktop)"
echo "3. NoMachine XFCE4 with Wine (Ubuntu with XFCE4 desktop and Wine)"
echo "4. NoMachine XFCE4 (Ubuntu with Windows 10 theme)"
echo "5. NoMachine XFCE4 (Kali Linux)"
echo "6. Exit"

# Read user's choice
read -p "Enter your choice: " choice

# Run Docker command based on the user's choice
case $choice in
  1)
    machineName="nomachine-mate"
    dockerImagePath="thuonghai2711/nomachine-ubuntu-desktop:mate"
    ;;
  2)
    machineName="nomachine-xfce4"
    dockerImagePath="thuonghai2711/nomachine-ubuntu-desktop:xfce4"
    ;;
  3)
    machineName="nomachine-xfce4"
    dockerImagePath="thuonghai2711/nomachine-ubuntu-desktop:wine"
    ;;
  4)
    machineName="nomachine-xfce4"
    dockerImagePath="thuonghai2711/nomachine-ubuntu-desktop:windows10"
    ;;
  5)
    machineName="nomachine-xfce4-kali"
    dockerImagePath="thuonghai2711/nomachine-kali-desktop:latest"
    ;;
  6)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac

# Construct and run the Docker command
docker_command="$docker_common_command --name $machineName -e PASSWORD=$password -e USER=$user $dockerImagePath"
echo "Running Docker command: $docker_command"
$docker_command

clear
echo "NoMachine: https://www.nomachine.com/download"
echo Done! NoMachine Information:
echo IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
echo User: reality
echo Passwd: 123456
echo "VM can't connect? Restart Cloud Shell then Re-run script."
seq 1 43200 | while read i; do echo -en "\r Running .     $i s /43200 s";sleep 0.1;echo -en "\r Running ..    $i s /43200 s";sleep 0.1;echo -en "\r Running ...   $i s /43200 s";sleep 0.1;echo -en "\r Running ....  $i s /43200 s";sleep 0.1;echo -en "\r Running ..... $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1;echo -en "\r Running  .... $i s /43200 s";sleep 0.1;echo -en "\r Running   ... $i s /43200 s";sleep 0.1;echo -en "\r Running    .. $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1; done
