FROM mcr.microsoft.com/dotnet/core/runtime:3.0-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["HelloName.csproj", ""]
RUN dotnet restore "./HelloName.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "HelloName.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloName.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloName.dll"]