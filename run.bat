@echo off
chcp 65001 >nul

echo ========================================
echo MusicGame-WPF Project Setup Script
echo ========================================
echo.

REM Check if .NET SDK is installed
echo [1/5] Checking .NET SDK installation...
dotnet --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "delims=" %%i in ('dotnet --version') do set DOTNET_VERSION=%%i
    echo ✓ .NET SDK installed: %DOTNET_VERSION%
) else (
    echo ✗ .NET SDK not installed. Please install .NET 8 SDK first:
    echo   Download: https://dotnet.microsoft.com/download/dotnet/8.0
    exit /b 1
)

REM Create WPF project
echo.
echo [2/5] Creating WPF project...
dotnet new wpf -n MusicGame -o . --force
if %errorlevel% neq 0 (
    echo ✗ Failed to create WPF project
    exit /b 1
) else (
    echo ✓ WPF project created successfully
)

REM Add project dependencies
echo.
echo [3/5] Adding project dependencies...
dotnet add package NAudio --version 2.2.1
if %errorlevel% neq 0 (
    echo ✗ Failed to add NAudio dependency
    exit /b 1
)

dotnet add package MvvmLightLibs --version 5.4.1.1
if %errorlevel% neq 0 (
    echo ✗ Failed to add MvvmLightLibs dependency
    exit /b 1
) else (
    echo ✓ Dependencies added successfully
)

REM Create project directory structure
echo.
echo [4/5] Creating project directory structure...

REM Create directories
set DIRECTORIES=Models ViewModels Views Services Utilities
for %%d in (%DIRECTORIES%) do (
    mkdir "%%d" 2>nul
    echo   ✓ Created directory: %%d
)

REM Create Models
set MODEL_FILES=MusicFile.cs Note.cs Score.cs
for %%f in (%MODEL_FILES%) do (
    type nul > "Models\%%f"
    echo   ✓ Created file: Models\%%f
)

REM Create ViewModels
set VIEWMODEL_FILES=MainViewModel.cs PlayerViewModel.cs EditorViewModel.cs
for %%f in (%VIEWMODEL_FILES%) do (
    type nul > "ViewModels\%%f"
    echo   ✓ Created file: ViewModels\%%f
)

REM Create Views
set VIEW_FILES=PlayerView.xaml PlayerView.xaml.cs EditorView.xaml EditorView.xaml.cs Styles.xaml
for %%f in (%VIEW_FILES%) do (
    type nul > "Views\%%f"
    echo   ✓ Created file: Views\%%f
)

REM Create Services
set SERVICE_FILES=AudioPlayer.cs ScoreManager.cs
for %%f in (%SERVICE_FILES%) do (
    type nul > "Services\%%f"
    echo   ✓ Created file: Services\%%f
)

REM Create Utilities
set UTILITY_FILES=Helper.cs
for %%f in (%UTILITY_FILES%) do (
    type nul > "Utilities\%%f"
    echo   ✓ Created file: Utilities\%%f
)

echo ✓ Project directory structure created successfully

REM Build project
echo.
echo [5/5] Building project...
dotnet build -c Release
if %errorlevel% neq 0 (
    echo ✗ Failed to build project
    exit /b 1
) else (
    echo ✓ Project built successfully
)

echo.
echo ========================================
echo ✓ Project setup completed!
echo ========================================
echo.
echo To run the project:
echo   dotnet run
echo.
echo Or run the executable directly:
echo   .\bin\Release\net8.0-windows\MusicGame.exe
echo.

pause
