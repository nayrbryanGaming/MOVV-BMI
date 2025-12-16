@echo off
echo ========================================
echo MOVV BMI - Generate App Icons
echo ========================================
echo.

echo Step 1: Installing dependencies...
call flutter pub get

echo.
echo Step 2: Generating launcher icons...
call flutter pub run flutter_launcher_icons

echo.
echo ========================================
echo Done! App icons have been generated.
echo ========================================
echo.
echo Next: Run "flutter run" to see the new icon
pause

