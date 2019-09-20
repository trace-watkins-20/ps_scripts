$all = Get-ChildItem "U:\Python\Python37-32\office_scan\pings" -Recurse
$active_list = @()

foreach ($name in $all)
{

$device_name = $name.Name -Replace ".txt",""

$lastlogon = Get-ADComputer -Identity $device_name -Properties LastLogonDate | FT Name,LastLogonDate

$logon_string = Out-String -InputObject $lastlogon


$logon_string -match "\d?\d\/(\d?\d)\/(\d\d\d\d)" | Out-Null



if(([int]$Matches.2 -ge 2019) -and ([int]$Matches.1 -ge 7))
{
$active_list += [STRING]$device_name

}
}

$active_list.trim("`n`r`t")

#$all = "Insert List of Hostnames"

$Cred = Get-Credential -UserName 'heartlandbank\' -Message 'Enter Password'

foreach($name in $active_list)

{
Write-Output $name

Invoke-Command -ComputerName $name -Credential $Cred -ScriptBlock {Get-Package "*Trend*"}

}