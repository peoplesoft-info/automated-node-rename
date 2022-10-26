# Variables that need properly set
$server = "dev-server"
$tld = "tld"
$newNode = "PSFT_HR_DEV"
$nodePassword = "node pass"
$oldNode = "PSFT_HR_PROD"
$psCredentials = Get-Credential -credential PS

# Extra computations
$portalUri = "https://$server.$tld/psp/ps/"
$contentUri = "https://$server.$tld/psc/ps/"
$input = @{RENAME_NODE_REQ=@{old_node_name="$oldNode";new_node_name="$newNode";node_password="$nodePassword";portal_uri="$portalUri";contentUri="$contentUri";purge_messages=$true}} 
$json = $input | ConvertTo-Json

# Invoke the service operation
$outputJson = $json | Invoke-RestMethod -Method Post -Uri https://$server.$tld/PSIGW/RESTListeningConnector/$oldNode/RENAME_NODE_OP.v1/RenameNode/ -ContentType application/json -Credential $psCredentials
$output = $outputJson | ConvertFrom-Json
if ($output.success -eq $false) {
	Write-Host "Failed! Error is $($output.error_message)" 
}