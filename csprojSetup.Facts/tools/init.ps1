param($installPath, $toolsPath, $package, $project)

Function CopyFile($fileName, $sourcePath, $destinationPath) {
	$source = "$sourcePath\$fileName"
	$destination = "$destinationPath\$fileName"
	
	If (!(Test-Path $destination)) {
		Copy-Item $source -Destination $destinationPath
		Write-Host "Added $fileName to $destinationPath"
	}
}

$assetsPath = "$toolsPath\..\assets"
$solutionPath = Resolve-Path .

CopyFile "TestCode.ruleset" $assetsPath $solutionPath
CopyFile "TestProject.csproj" $assetsPath $solutionPath