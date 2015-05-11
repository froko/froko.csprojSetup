$baseDir = Resolve-Path ..
$toolsDir = "$baseDir\tools"
$nugetDir = "$baseDir\nuget"

$gitVersionCommand = "$toolsDir\GitVersion.exe"
$nugetConsole = "$toolsDir\NuGet.exe"
	
Function GitVersion() {
	& cmd /c "$gitVersionCommand > $baseDir\version.json"
	$version = [IO.File]::ReadAllText("$baseDir\version.json") | ConvertFrom-Json
	
	return $version.NuGetVersion
}

Function NugetProjects {
    $directoryNames = Get-Childitem $baseDir -recurse -filter "*.nuspec" | %{$_.DirectoryName} | Get-Unique
	
	return Get-Childitem $baseDir | Where{$_.psIsContainer -eq $true -and $directoryNames.Contains($_.FullName)}
}
	
$version = GitVersion

New-Item $nugetDir -ItemType directory -Force
Remove-Item $nugetDir\*.* -Force -ErrorAction SilentlyContinue
	
NugetProjects |
Foreach-Object {
	$projectPath = $_.fullname
	$projectName = $_.name
	$nuspecFile = "$projectPath\$projectName.nuspec"
	
	& cmd /c "$nugetConsole pack $nuspecFile -version $version -OutputDirectory $nugetDir"
}