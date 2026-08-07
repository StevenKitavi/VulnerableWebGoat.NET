# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:10.0@sha256:72dd743782f2ae7e5476fd64f6a460045e3998dc862218b80e6944cba79a01b0 AS build
WORKDIR ./sources

# copy everything else and build app
COPY WebGoat.NET/. ./sources/WebGoat.NET/
WORKDIR ./sources/WebGoat.NET
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:fd7596eaea7ad453fe7ac16724a3c9ae36edcda894ba13743d6a5c83d6a3b36d
WORKDIR /app
COPY --from=build /app ./

LABEL org.opencontainers.image.source=https://github.com/tobyash86/WebGoat.NET
LABEL org.opencontainers.image.description="WebGoat.NET - port of original WebGoat.NET (.NET Framework) to .NET"

ENTRYPOINT ["dotnet", "WebGoat.NET.dll"] 
