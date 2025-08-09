# ========== Build stage ==========
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

COPY WebApp/*.csproj WebApp/
RUN dotnet restore WebApp/WebApp.csproj

COPY . .
RUN dotnet publish WebApp/WebApp.csproj -c Release -o /app/out --no-restore

# ========== Runtime stage ==========
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "WebApp.dll"]
