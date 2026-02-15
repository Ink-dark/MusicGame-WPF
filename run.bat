@echo off
chcp 65001 >nul

echo ========================================
echo MusicGame-WPF 项目创建和构建脚本
echo ========================================
echo.

REM 检查 .NET SDK 是否安装
echo [1/5] 检查 .NET SDK 安装情况...
try {
    dotnet --version >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "delims=" %%i in ('dotnet --version') do set DOTNET_VERSION=%%i
        echo ✓ .NET SDK 已安装: %DOTNET_VERSION%
    ) else (
        echo ✗ .NET SDK 未安装，请先安装 .NET 8 SDK:
        echo   下载地址: https://dotnet.microsoft.com/download/dotnet/8.0
        exit /b 1
    )
} catch {
    echo ✗ .NET SDK 未安装，请先安装 .NET 8 SDK:
    echo   下载地址: https://dotnet.microsoft.com/download/dotnet/8.0
    exit /b 1
}

REM 创建 WPF 项目
echo.
echo [2/5] 创建 WPF 项目...
dotnet new wpf -n MusicGame -o . --force
if %errorlevel% neq 0 (
    echo ✗ 创建 WPF 项目失败
    exit /b 1
) else (
    echo ✓ WPF 项目创建成功
)

REM 添加项目依赖
echo.
echo [3/5] 添加项目依赖...
dotnet add package NAudio --version 2.2.1
if %errorlevel% neq 0 (
    echo ✗ 添加 NAudio 依赖失败
    exit /b 1
)

dotnet add package MvvmLightLibs --version 5.4.1.1
if %errorlevel% neq 0 (
    echo ✗ 添加 MvvmLightLibs 依赖失败
    exit /b 1
) else (
    echo ✓ 依赖添加成功
)

REM 创建项目目录结构
echo.
echo [4/5] 创建项目目录结构...

REM 创建目录
set DIRECTORIES=Models ViewModels Views Services Utilities
for %%d in (%DIRECTORIES%) do (
    mkdir "%%d" 2>nul
    echo   ✓ 创建目录: %%d
)

REM 创建 Models
set MODEL_FILES=MusicFile.cs Note.cs Score.cs
for %%f in (%MODEL_FILES%) do (
    type nul > "Models\%%f"
    echo   ✓ 创建文件: Models\%%f
)

REM 创建 ViewModels
set VIEWMODEL_FILES=MainViewModel.cs PlayerViewModel.cs EditorViewModel.cs
for %%f in (%VIEWMODEL_FILES%) do (
    type nul > "ViewModels\%%f"
    echo   ✓ 创建文件: ViewModels\%%f
)

REM 创建 Views
set VIEW_FILES=PlayerView.xaml PlayerView.xaml.cs EditorView.xaml EditorView.xaml.cs Styles.xaml
for %%f in (%VIEW_FILES%) do (
    type nul > "Views\%%f"
    echo   ✓ 创建文件: Views\%%f
)

REM 创建 Services
set SERVICE_FILES=AudioPlayer.cs ScoreManager.cs
for %%f in (%SERVICE_FILES%) do (
    type nul > "Services\%%f"
    echo   ✓ 创建文件: Services\%%f
)

REM 创建 Utilities
set UTILITY_FILES=Helper.cs
for %%f in (%UTILITY_FILES%) do (
    type nul > "Utilities\%%f"
    echo   ✓ 创建文件: Utilities\%%f
)

echo ✓ 项目目录结构创建完成

REM 构建项目
echo.
echo [5/5] 构建项目...
dotnet build -c Release
if %errorlevel% neq 0 (
    echo ✗ 项目构建失败
    exit /b 1
) else (
    echo ✓ 项目构建成功
)

echo.
echo ========================================
echo ✓ 项目创建和构建完成！
echo ========================================
echo.
echo 使用以下命令运行项目:
echo   dotnet run
echo.
echo 或直接运行生成的可执行文件:
echo   .\bin\Release\net8.0-windows\MusicGame.exe
echo.

pause
