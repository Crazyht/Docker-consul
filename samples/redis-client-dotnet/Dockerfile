FROM microsoft/dotnet:2.0-sdk as build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY redis-client-dotnet.csproj ./
RUN dotnet restore

# copy and build everything else
COPY . ./
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/redis-client-dotnet.dll"]

FROM crazyht/alpine-consul-dotnet-runtime:dev
WORKDIR /app
COPY --from=build /app/out /app
