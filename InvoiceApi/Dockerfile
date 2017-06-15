FROM microsoft/aspnetcore-build:1.1
WORKDIR /app/

#Copy csproj and restore
COPY *.csproj .
RUN dotnet restore

#Copy and build everything else
COPY . .
RUN  dotnet publish -c Release -o out
EXPOSE 8083
ENTRYPOINT ["dotnet", "out/InvoiceApi.dll"]
