[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
    [string]$BinaryPath,
   [Parameter(Mandatory=$False)]
    [bool]$DebugMode
)

Set-ExecutionPolicy Bypass -Scope Process

$host.UI.RawUI.WindowTitle = "Myrtille Configuration . . . PLEASE DO NOT CLOSE THIS WINDOW . . ."

try
{
	# check if the service exists
	if (!(Get-Service "Myrtille.Services" -ErrorAction SilentlyContinue))
	{
		# create the service
		New-Service -Name "Myrtille.Services" -Description "Myrtille HTTP(S) to RDP and SSH gateway" -BinaryPathName $BinaryPath -StartupType "Automatic"
		Write-Output "Created Myrtille.Services`r`n"
	}
	else
	{
		Write-Output "Myrtille.Services already exists"
	}

	# start the service
	Start-Service -Name "Myrtille.Services"
	Write-Output "Started Myrtille.Services`r`n"

	if ($DebugMode)
	{
		Read-Host "`r`nPress ENTER to continue..."
	}
}
catch
{
	Write-Output $_.Exception.Message

	if ($DebugMode)
	{
		Read-Host "`r`nPress ENTER to continue..."
	}

	exit 1
}