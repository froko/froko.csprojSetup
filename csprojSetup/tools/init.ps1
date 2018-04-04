param($installPath, $toolsPath, $package, $project)

Function CopyFile($fileName, $sourcePath, $destinationPath) {
	$source = "$sourcePath\$fileName"
	$destination = "$destinationPath\$fileName"
	
	If (!(Test-Path $destination)) {
		Copy-Item $source -Destination $destinationPath
		Write-Host "Added $fileName to $destinationPath"
	}
}

$codeAnalysisPath = "$toolsPath\..\codeanalysis"
$solutionPath = Resolve-Path .

CopyFile "stylecop.json" $codeAnalysisPath $solutionPath