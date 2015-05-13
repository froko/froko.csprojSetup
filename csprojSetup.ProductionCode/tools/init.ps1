param($installPath, $toolsPath, $package, $project)

Function CopyFile($fileName, $sourcePath, $destinationPath) {
	$source = "$sourcePath\$fileName"
	$destination = "$destinationPath\$fileName"
	
	If (Test-Path $destination) {
		Write-Host "$fileName already exists"
	} 
	Else {
		Copy-Item $source -Destination $destinationPath
		Write-Host "Added $fileName to $destinationPath"
	}
}

$codeAnalysisPath = "$toolsPath\..\codeanalysis"
$solutionPath = Resolve-Path .

CopyFile "ProductionCode.StyleCop" $codeAnalysisPath $solutionPath