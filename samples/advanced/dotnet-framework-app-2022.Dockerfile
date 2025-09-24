ARG STARTUP_FILES='Startup.ps1 SetConfigurationV2.ps1'
ARG LOG_MONITOR_FILES='LogMonitor.exe LogMonitorConfig.json'

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

SHELL [ "powershell.exe" ]

EXPOSE 443

RUN Set-Service -Name w3svc -StartupType 'Manual'; \
  Remove-WebSite -Name 'Default Web Site'; \
  'App', 'Logs' | ForEach-Object { New-Item C:\$_ -ItemType Directory | Out-Null; }; \
  New-Website -Name 'App' -IPAddress '*' -Port 443 -PhysicalPath C:\App -ApplicationPool '.NET v4.5' -Ssl;

WORKDIR 'C:\App'

COPY Code/ .
COPY $STARTUP_FILES C:/Startup/
COPY $LOG_MONITOR_FILES C:/LogMonitor/

ENTRYPOINT ["powershell.exe", "C:\\Startup\\Startup.ps1"]