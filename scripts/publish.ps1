$baseDir = Resolve-Path ..
$toolsDir = "$baseDir\tools"
$nugetDir = "$baseDir\nuget"

$nugetConsole = "$toolsDir\NuGet.exe"
	
Function NugetPackages {
	return Get-ChildItem $nugetDir\*.nupkg -Exclude *.symbols.nupkg
}

NugetPackages |
Foreach-Object {
	$package = $_.fullname
	
	Write-Host "pushing nuget package" $package
	& cmd /c "$nugetConsole push $package -Source https://www.myget.org/F/froko/api/v2/package"
}