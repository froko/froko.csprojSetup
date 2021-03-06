# froko.csprojSetup
## common setup for your C# projects

The froko.csprojSetup suite provides you with predefined develop dependency NuGet packages in order to speed up the repeating work when you add new projects to a Visual Studio solution. Let's assume the following prerequisites:

- You want to treat warnings as errors when you do a Release build
- You want to have [StyleCop](https://github.com/DotNetAnalyzers/StyleCopAnalyzers) checking your code for formal correctness
- You use [Git](http://git-scm.com/) as your source control system
- You may use the [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow) workflow
- You want automatic versioning of your assemblies
- You use [xUnit](http://xunit.github.io/) for unit tests (presumably together with [FluentAssertions](http://www.fluentassertions.com/) and [FakeItEasy](http://fakeiteasy.github.io/))
- You may develop NuGet packages and want to pack them automatically after building and testing

If you can agree on most of the points above, then you should definitely give froko.csprojSetup a try!

## What's in the box?
froko.csprojSetup consists of the following unique packages:

### froko.csprojSetup
- The main package. All other packages within the suite depend on this package.
- Configures your C# project to treat warnings as errors on Release build.
- Adds [StyleCop](https://github.com/DotNetAnalyzers/StyleCopAnalyzers) to your project in order to check your code when you build it
- Adds [GitVersionTask](http://www.nuget.org/packages/GitVersionTask) to your project for automatic versioning of your assemblies

### froko.csprojSetup.ProductionCode
- Adds a central ProductionCode RuleSet file to your solution's root directory and links it with the project. The placement of the RuleSet file is done only once when you install this package the first time in your solution. So you can customize this file for your needs and don't have to worry that it gets overridden by later installations of this package or a package restore.

### froko.csprojSetup.Facts
- Adds [xUnit](http://www.nuget.org/packages/xunit) as dependency
- Adds [FluentAssertions](http://www.nuget.org/packages/FluentAssertions) as dependency
- Adds [FakeItEasy](http://www.nuget.org/packages/FakeItEasy) as dependency
- Adds a TestProject.csproj file to your solution's root directory the first time you install this package. This file holds a reference to all your test projects you create along the way by selecting them by their *.Facts suffix in the file name. This file can be used to define a msbuild call, which automatically executes all tests from all test assemblies.
- Adds a central TestCode RuleSet file to your solution's root directory and links it with the project. The placement of the RuleSet file is done only once when you install this package the first time in your solution. So you can customize this file for your needs and don't have to worry that it gets overridden by later installations of this package or a package restore.

### froko.csprojSetup.OctoPack
- Adds [OctoPack](http://www.nuget.org/packages/OctoPack) to your project
- Adds an MSBUILD target that will pack your assembly into a NuGet package after the project has been built in Release mode

### froko.csprojSetup.XmlDocumentation
- Generates XML documentation out of your code comments when you do a Release build
- The XML file has the name of the project and is written into the bin\Release folder

## Where can I get it?
All packages from above are hosted on [nuget.org](http://www.nuget.org/packages?q=froko)

## What about build scripts?
Well, since all important stuff is done during the Release build, you don't need extra build scripts anymore. Furthermore your build script can be as simple as the following two lines:

<pre>
msbuild your.Solution.sln /target:Rebuild /p:Configuration=Release /p:RunOctoPack=true
msbuild TestProject.csproj
</pre>
