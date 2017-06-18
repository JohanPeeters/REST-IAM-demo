FROM microsoft/aspnetcore-build:1.1
WORKDIR /app/

#Copy ssl certificate used by keycloak, as this needs to be trusted to be able to load the openidconfiguration via TLS
COPY ./softwarewolves.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

#Copy csproj and restore
COPY *.csproj .
RUN dotnet restore

#Copy and build everything else
COPY . .
RUN  dotnet publish -c Release -o out
EXPOSE 8083
ENTRYPOINT ["dotnet", "out/InvoiceApi.dll"]
