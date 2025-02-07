# 1 - Configure the build process of application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything
COPY ./WebApi ./
# Restore as distinct layers
RUN dotnet restore 
# Build and publish a release
RUN dotnet publish -c Release -o out

# 2 - Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "WebApi.dll"]