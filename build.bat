@echo off
java -jar "C:\tools\ffdec\ffdec.jar" -importScript 151706_ultimate_sonic.swf sonic_fly.swf decompiled/scripts
if %errorlevel% neq 0 (
    echo BUILD FAILED
    exit /b %errorlevel%
)
echo BUILD OK: sonic_fly.swf
