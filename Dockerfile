# Build Stage
FROM microsoft/aspnetcore-build:2 as build-env
WORKDIR /api
COPY . .
RUN dotnet restore
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/aspnetcore:2
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "/publish/api.dll"]