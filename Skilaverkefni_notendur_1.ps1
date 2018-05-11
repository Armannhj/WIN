New-ADOrganizationalUnit -Name Notendur -ProtectedFromAccidentalDeletion $false 
$grunnOUPath = (Get-ADOrganizationalUnit -Filter { name -like 'Notendur' }).DistinguishedName
New-ADGroup -Name Allir -Path $grunnOUPath -GroupScope Global

$notendur = Import-Csv .\notendur.csv 

foreach($n in $notendur){
    $deild = $n.deild
    if(-not (Get-ADOrganizationalUnit -Filter { name -like $deild})){
        New-ADOrganizationalUnit -Name $deild -Path $grunnOUPath -ProtectedFromAccidentalDeletion $false
        New-ADGroup -Name $deild -Path $("ou=" + $deild + "," + $grunnOUPath) -GroupScope Global
        Add-ADGroupMember -Identity Allir -Members $deild
        ## búa til möppu fyrir deild og share-a henni
        New-Item $("C:\gogn\" + $deild) -ItemType Directory
        $rettindi = Get-Acl -Path $("C:\gogn\" + $deild)
        $nyrettindi = New-Object System.Security.AccessControl.FileSystemAccessRule($($env:USERDNSDOMAIN+ "\" + $deild),"Modify","Allow")
        $rettindi.AddAccessRule($nyrettindi)
        Set-Acl -Path $("C:\gogn\" + $deild) $rettindi
        New-SmbShare -Name $deild -Path $("C:\gogn\" + $deild) -FullAccess $($env:USERDNSDOMAIN+ "\" + $deild), administrator

    }

    New-ADUser -Name $n.nafn -DisplayName $n.nafn -GivenName $n.fornafn -Surname $n.eftirnafn -SamAccountName $n.notendanafn -UserPrincipalName $($n.notendanafn + "@" + $env:USERDNSDOMAIN) -Path $("ou=" + $deild + "," + $grunnOUPath) -AccountPassword (ConvertTo-SecureString -AsPlainText "pass.123" -Force) -Enabled $true
    Add-ADGroupMember -Identity $deild -Members $n.notendanafn
}