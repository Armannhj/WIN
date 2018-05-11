### FINNA NETKORT ####

function FinnaNafnNetkortsMedIpTolu{
    param(
        [Parameter(Mandatory=$true, HelpMessage="Sl��u inn ip t�lvu e�a hluta af henni. Settu * ef ekki �ll Ip-talan")]
        [string]$TakaInnIpTol
        )

        $tala = $TakaInnIpTol
        $ip = (Get-NetIPAddress -IPAddress $tala).InterfaceAlias
        if($ip){
            $ip
        }else{
        Write-Error -Message "FinnanafnNetkorstMedIPTolu : Fann ekki netkort me� ip t�luna " + $tala
        }
}
