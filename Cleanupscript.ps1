#	 Request-CosmicClusterElevation -Ring prod -Location northeurope -Role Contributor -Reason "Delete kevlar-linux-security-monitoring pods"
#
# 3. Get the lockbox requests approved. Wait for 10 minutes after the LBs are approved. Sometimes, it takes a while for the access to be reflected in the alias_debug account.


$ClusterList = @(
"prod-d02-005-nam-centralus"
)

foreach($ClusterId in $ClusterList) {
	Write-Host "$ClusterId"
	$arr = $ClusterId.Split("-")
	$ring = $arr[0]
	$silo = $arr[1]
	$instance = $arr[2]
	$location = $arr[4]
	
	# Setting the cluster context
	cc set $ring $silo $location -i $instance
	
	# Forcefully deleting the kevlar-linux-security-monitoring pods
	cc delete pods -l name=kevlar-linux-security-monitoring --force -n kevlar-linux-tools
}
