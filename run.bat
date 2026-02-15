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

REM Check if project already exists
echo.
echo [2/5] Checking project structure...
if not exist "MusicGame.csproj" (
    dotnet new wpf -n MusicGame -o .
    if %errorlevel% neq 0 (
        echo ✗ Failed to create WPF project
        exit /b 1
    ) else (
        echo ✓ WPF project created successfully
    )
) else (
    echo ✓ Project already exists, skipping creation
)

REM Add project dependencies
echo.
echo [3/5] Adding project dependencies...
dotnet add package NAudio --version 2.2.1
if %errorlevel% neq 0 (
    echo ✗ Failed to add NAudio dependency
    exit /b 1
)

dotnet add package CommunityToolkit.Mvvm --version 8.2.2
if %errorlevel% neq 0 (
    echo ✗ Failed to add CommunityToolkit.Mvvm dependency
    exit /b 1
) else (
    echo ✓ Dependencies added successfully
)

REM Create project directory structure if missing
echo.
echo [4/5] Checking project directory structure...

REM Create directories if they don't exist
set DIRECTORIES=Models ViewModels Views Services Utilities
for %%d in (%DIRECTORIES%) do (
    if not exist "%%d" (
        mkdir "%%d"
        echo   ✓ Created directory: %%d
    ) else (
        echo   ✓ Directory already exists: %%d
    )
)

REM Create Models only if they don't exist
set MODEL_FILES=MusicFile.cs Note.cs Score.cs
for %%f in (%MODEL_FILES%) do (
    if not exist "Models\%%f" (
        type nul > "Models\%%f"
        echo   ✓ Created file: Models\%%f
    )
)

REM Create ViewModels only if they don't exist
set VIEWMODEL_FILES=MainViewModel.cs PlayerViewModel.cs EditorViewModel.cs
for %%f in (%VIEWMODEL_FILES%) do (
    if not exist "ViewModels\%%f" (
        type nul > "ViewModels\%%f"
        echo   ✓ Created file: ViewModels\%%f
    )
)

REM Create Views only if they don't exist (especially XAML files)
set VIEW_FILES=PlayerView.xaml PlayerView.xaml.cs EditorView.xaml EditorView.xaml.cs Styles.xaml
for %%f in (%VIEW_FILES%) do (
    if not exist "Views\%%f" (
        type nul > "Views\%%f"
        echo   ✓ Created file: Views\%%f
    ) else (
        echo   ✓ File already exists, skipping: Views\%%f
    )
)

REM Create Services only if they don't exist
set SERVICE_FILES=AudioPlayer.cs ScoreManager.cs
for %%f in (%SERVICE_FILES%) do (
    if not exist "Services\%%f" (
        type nul > "Services\%%f"
        echo   ✓ Created file: Services\%%f
    )
)

REM Create Utilities only if they don't exist
set UTILITY_FILES=Helper.cs
for %%f in (%UTILITY_FILES%) do (
    if not exist "Utilities\%%f" (
        type nul > "Utilities\%%f"
        echo   ✓ Created file: Utilities\%%f
    )
)

echo ✓ Project directory structure checked successfully

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
