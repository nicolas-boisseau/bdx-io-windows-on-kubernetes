ARG SDK=mcr.microsoft.com/dotnet/framework/sdk:4.8.1-windowsservercore-ltsc2025
ARG RUNTIME=mcr.microsoft.com/dotnet/framework/aspnet:4.8.1-windowsservercore-ltsc2025

FROM $SDK AS builder

WORKDIR C:/Temp
COPY . .
COPY ./Config/* ./LegacyApp/ 

WORKDIR C:/Temp/LegacyApp

RUN msbuild.exe

FROM $RUNTIME AS final

COPY --from=builder "C:\\Temp\\LegacyApp\\" /inetpub/wwwroot/ 
COPY ./Config/web.config /inetpub/wwwroot/web.config

EXPOSE 80