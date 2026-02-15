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

# Create WPF project
Write-Host ""
Write-Host "[2/5] Creating WPF project..."
try {
    dotnet new wpf -n MusicGame -o . --force
    Write-Host "✓ WPF project created successfully"
} catch {
    Write-Host "✗ Failed to create WPF project: $_"
    exit 1
}

# Add project dependencies
Write-Host ""
Write-Host "[3/5] Adding project dependencies..."
try {
    dotnet add package NAudio --version 2.2.1
    dotnet add package MvvmLightLibs --version 5.4.1.1
    Write-Host "✓ Dependencies added successfully"
} catch {
    Write-Host "✗ Failed to add dependencies: $_"
    exit 1
}

# Create project directory structure
Write-Host ""
Write-Host "[4/5] Creating project directory structure..."
try {
    # Create directories
    $directories = @(
        "Models",
        "ViewModels",
        "Views",
        "Services",
        "Utilities"
    )
    
    foreach ($dir in $directories) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  ✓ Created directory: $dir"
    }
    
    # Create Models
    New-Item -ItemType File -Path "Models\MusicFile.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Models\Note.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Models\Score.cs" -Force | Out-Null
    
    # Create ViewModels
    New-Item -ItemType File -Path "ViewModels\MainViewModel.cs" -Force | Out-Null
    New-Item -ItemType File -Path "ViewModels\PlayerViewModel.cs" -Force | Out-Null
    New-Item -ItemType File -Path "ViewModels\EditorViewModel.cs" -Force | Out-Null
    
    # Create Views
    New-Item -ItemType File -Path "Views\PlayerView.xaml" -Force | Out-Null
    New-Item -ItemType File -Path "Views\PlayerView.xaml.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Views\EditorView.xaml" -Force | Out-Null
    New-Item -ItemType File -Path "Views\EditorView.xaml.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Views\Styles.xaml" -Force | Out-Null
    
    # Create Services
    New-Item -ItemType File -Path "Services\AudioPlayer.cs" -Force | Out-Null
    New-Item -ItemType File -Path "Services\ScoreManager.cs" -Force | Out-Null
    
    # Create Utilities
    New-Item -ItemType File -Path "Utilities\Helper.cs" -Force | Out-Null
    
    Write-Host "✓ Project directory structure created successfully"
} catch {
    Write-Host "✗ Failed to create directory structure: $_"
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
