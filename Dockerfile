# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:e2f26f26169fd10d6f1b426e01c97397717b32e9d5ab4ee4a7d5497ed9403007 AS build
WORKDIR ./sources

# copy everything else and build app
COPY WebGoat.NET/. ./sources/WebGoat.NET/
WORKDIR ./sources/WebGoat.NET
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:10.0@sha256:f1126d438ccc359f51cc6d4701a8deae513856cf10f5fe645d29ea6403dcac6b
WORKDIR /app
COPY --from=build /app ./

LABEL org.opencontainers.image.source=https://github.com/tobyash86/WebGoat.NET
LABEL org.opencontainers.image.description="WebGoat.NET - port of original WebGoat.NET (.NET Framework) to .NET"

ENTRYPOINT ["dotnet", "WebGoat.NET.dll"] 
