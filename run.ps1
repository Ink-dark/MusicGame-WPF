<#
.SYNOPSIS
MusicGame-WPF Project Creation and Build Script

.DESCRIPTION
This script is used to create, configure, and build the MusicGame-WPF project.

.NOTES
Author: MusicGame Development Team
Version: 1.1
#>

# Set error handling
$ErrorActionPreference = "Stop"

Write-Host "========================================"
Write-Host "MusicGame-WPF Project Setup Script"
Write-Host "========================================"
Write-Host ""

# Check if .NET SDK is installed
Write-Host "[1/5] Checking .NET SDK installation..."
$dotnetInstalled = $false
try {
    $dotnetVersion = dotnet --version
    Write-Host "✓ .NET SDK installed: $dotnetVersion"
    $dotnetInstalled = $true
} catch {
    Write-Host "✗ .NET SDK not installed. Please install .NET 8 SDK first:"
    Write-Host "  Download: https://dotnet.microsoft.com/download/dotnet/8.0"
    exit 1
}

# Check if project already exists
Write-Host ""
Write-Host "[2/5] Checking project structure..."
try {
    if (-Not (Test-Path -Path "MusicGame.csproj")) {
        dotnet new wpf -n MusicGame -o .
        Write-Host "✓ WPF project created successfully"
    } else {
        Write-Host "✓ Project already exists, skipping creation"
    }
} catch {
    Write-Host "✗ Failed to check/create project: $_"
    exit 1
}

# Add project dependencies
Write-Host ""
Write-Host "[3/5] Adding project dependencies..."
try {
    dotnet add package NAudio --version 2.2.1
    dotnet add package CommunityToolkit.Mvvm --version 8.2.2
    Write-Host "✓ Dependencies added successfully"
} catch {
    Write-Host "✗ Failed to add dependencies: $_"
    exit 1
}

# Create project directory structure if missing
Write-Host ""
Write-Host "[4/5] Checking project directory structure..."
try {
    # Create directories if they don't exist
    $directories = @(
        "Models",
        "ViewModels",
        "Views",
        "Services",
        "Utilities"
    )
    
    foreach ($dir in $directories) {
        if (-Not (Test-Path -Path $dir)) {
            New-Item -ItemType Directory -Path $dir | Out-Null
            Write-Host "  ✓ Created directory: $dir"
        } else {
            Write-Host "  ✓ Directory already exists: $dir"
        }
    }
    
    # Create empty files only if they don't exist
    $files = @(
        "Models\MusicFile.cs",
        "Models\Note.cs",
        "Models\Score.cs",
        "ViewModels\MainViewModel.cs",
        "ViewModels\PlayerViewModel.cs",
        "ViewModels\EditorViewModel.cs",
        "Services\AudioPlayer.cs",
        "Services\ScoreManager.cs",
        "Utilities\Helper.cs"
    )
    
    foreach ($file in $files) {
        if (-Not (Test-Path -Path $file)) {
            New-Item -ItemType File -Path $file | Out-Null
            Write-Host "  ✓ Created file: $file"
        }
    }
    
    # Special handling for XAML files - don't overwrite if they exist
    $xamlFiles = @(
        "Views\PlayerView.xaml",
        "Views\PlayerView.xaml.cs",
        "Views\EditorView.xaml",
        "Views\EditorView.xaml.cs",
        "Views\Styles.xaml"
    )
    
    foreach ($xamlFile in $xamlFiles) {
        if (-Not (Test-Path -Path $xamlFile)) {
            New-Item -ItemType File -Path $xamlFile | Out-Null
            Write-Host "  ✓ Created XAML file: $xamlFile"
        } else {
            Write-Host "  ✓ XAML file already exists, skipping: $xamlFile"
        }
    }
    
    Write-Host "✓ Project directory structure checked successfully"
} catch {
    Write-Host "✗ Failed to check directory structure: $_"
    exit 1
}

# Build project
Write-Host ""
Write-Host "[5/5] Building project..."
try {
    dotnet build -c Release
    Write-Host "✓ Project built successfully"
} catch {
    Write-Host "✗ Failed to build project: $_"
    exit 1
}

Write-Host ""
Write-Host "========================================"
Write-Host "✓ Project setup completed!"
Write-Host "========================================"
Write-Host ""

# Ask user if they want to run the project
$runProject = $true
$userInput = Read-Host -Prompt "Do you want to run the project now? (Y/N)"
if ($userInput -eq "N" -or $userInput -eq "n") {
    $runProject = $false
}

if ($runProject) {
    Write-Host ""
    Write-Host "Running the project..."
    Write-Host "========================================"
    Write-Host ""
    dotnet run
} else {
    Write-Host "To run the project:"
    Write-Host "  dotnet run"
    Write-Host ""
    Write-Host "Or run the executable directly:"
    Write-Host "  .\bin\Release\net8.0-windows\MusicGame.exe"
    Write-Host ""
}
