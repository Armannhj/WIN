$netkort = FinnaNafnNetkortsMedIpTolu -TakaInnIpTol "169.*"

Rename-NetAdapter -Name $netkort -NewName "LAN"
New-NetIPAddress -InterfaceAlias LAN -IPAddress 172.16.16.2 -PrefixLength 21
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 127.0.0.1


# setja inn DHCP role
Install-WindowsFeature -Name DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -Name scope1 -StartRange 172.16.16.1 -EndRange 172.16.23.254 -SubnetMask 255.255.248.00
Set-DhcpServerv4OptionValue -DnsServer 172.16.16.1 -Router 172.16.16.1
Add-DhcpServerInDC -DnsName $($env:COMPUTERNAME + "." + $env:USERDNSDOMAIN)