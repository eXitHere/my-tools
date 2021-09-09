# try to exec admin!
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"

# find IPv4
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
    $remoteport = $matches[0];
} else{
    echo "the ip address of WSL 2 cannot be found";
    exit;
}

#[Ports]
$ports=@(3000, 8080, 3500, 3501, 3502);

#[Static ip]
$addr='0.0.0.0';
$ports_a = $ports -join ",";

#iex = Invoke-Expression

# remove old rules
iex "netsh interface portproxy reset";

for( $i = 0; $i -lt $ports.length; $i++ ){
    $port = $ports[$i];
    # iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}

iex "netsh interface portproxy show v4tov4";