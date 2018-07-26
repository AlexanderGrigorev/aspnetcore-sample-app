FROM microsoft/dotnet:2.1-sdk AS build-env

RUN dotnet new razor -o SampleWebApp
RUN dotnet new sln
RUN dotnet sln add SampleWebApp

WORKDIR /SampleWebApp
RUN dotnet restore

RUN dotnet publish SampleWebApp.csproj -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime

WORKDIR /SampleWebApp
COPY --from=build-env /SampleWebApp/out .

ENTRYPOINT ["dotnet", "SampleWebApp.dll"]

