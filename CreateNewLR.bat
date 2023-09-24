if not exist ".\lab" mkdir .\lab

mkdir .\lab\sandbox
mkdir .\lab\src 

mkdir .\lab\src\src
mkdir .\lab\src\sim
mkdir .\lab\src\xdc

xcopy .\_ForScript\RestoreProject.bat .\lab\
xcopy .\_ForScript\.gitignore .\lab\