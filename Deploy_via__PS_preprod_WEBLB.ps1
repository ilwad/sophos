## Script parameters being asked for below match to parameters in the SophosXG.json file, otherwise pointing to the ##
## azuredeploy.parameters.json file for values to use.  Some options below are mandatory, some (such as region) can    ##
## be supplied inline when running this script but if they aren't then the default will be used as specified below.    ##
## Example Command: .\Deploy_via_PS.ps1 -adminUsername azureuser -authenticationType password -adminPasswordOrKey <value> -dnsLabel <value> -instanceName f5vm01 -numberOfExternalIps 1 -enableNetworkFailover Yes -provisionInternalLoadBalancer Yes -internalLoadBalancerProbePort 3456 -instanceType Standard_DS3_v2 -imageName Best1Gbps -bigIpVersion 16.1.000000 -bigIpModules ltm:nominal -vnetName <value> -vnetResourceGroupName <value> -mgmtSubnetName <value> -mgmtIpAddressRangeStart DYNAMIC -externalSubnetName <value> -externalIpAddressRangeStart DYNAMIC -externalIpSelfAddressRangeStart DYNAMIC -internalSubnetName <value> -internalIpAddressRangeStart DYNAMIC -provisionPublicIP Yes -provisionPublicIPApp Yes -declarationUrl NOT_SPECIFIED -ntpServer 0.pool.ntp.org -timeZone UTC -customImageUrn OPTIONAL -customImage OPTIONAL -allowUsageAnalytics Yes -allowPhoneHome Yes -resourceGroupName <value>

param(

$templateFilePath = "SophosXG.json",
$parametersFilePath = "parameters.json"

)

Write-Host "Disclaimer: Scripting to Deploy F5 Solution templates into Cloud Environments are provided as examples. They will be treated as best effort for issues that occur, feedback is encouraged." -foregroundcolor green
Start-Sleep -s 3

# Connect to Azure, right now it is only interactive login
#try {
#    Write-Host "Checking if already logged in!"
#    Get-AzureRmSubscription | Out-Null
#    Write-Host "Already logged in, continuing..."
#    }
#    catch {
#      Write-Host "Not logged in, please login..."
#      Login-AzureRmAccount
#   }

# Create Resource Group for ARM Deployment
#New-AzureRmResourceGroup -Name $resourceGroupName -Location "$region"

#$adminPasswordOrKeySecure = ConvertTo-SecureString -String $adminPasswordOrKey -AsPlainText -Force

#(ConvertFrom-Json $tagValues).psobject.properties | ForEach -Begin {$tagValues=@{}} -process {$tagValues."$($_.Name)" = $_.Value}

# Create Arm Deployment

$deployment = New-AzResourceGroupDeployment -Name "sopho-Deploy" 
                                            -TemplateFile $templateFilePath 
                                            -TemplateParameterFile $parametersFilePath 

# Print Output of Deployment to Console
$deployment

#$AgreementTerms = Get-AzMarketplaceTerms -Publisher "f5-networks" -Product "f5-big-ip-byol" -Name "f5-big-ltm-2slot-byol"
#Set-AzMarketplaceTerms -Publisher "f5-networks" -Product "f5-big-ip-byol" -Name "f5-big-ltm-2slot-byol" -Terms $AgreementTerms -Accept