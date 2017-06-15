using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using SpaIdSrv.Configuration;
using Serilog;
using Microsoft.Extensions.Configuration;

namespace SpaIdSrv
{
    public class Startup
    {
        public IConfiguration configuration { get; }
        public Startup(ILoggerFactory loggerFactory, IHostingEnvironment environment)
        {
            //Dynamic configuration
            var builder = new ConfigurationBuilder()
            .SetBasePath(environment.ContentRootPath)
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile($"appsettings.{environment.EnvironmentName}.json", optional: true)
            .AddEnvironmentVariables();
            configuration = builder.Build();

            var serilog = new LoggerConfiguration()
                .MinimumLevel.Verbose()
                .Enrich.FromLogContext()
                .WriteTo.File(@"identityserver4_log.txt");

            if (environment.IsDevelopment())
            {
                serilog.WriteTo.LiterateConsole(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message}{NewLine}{Exception}{NewLine}");
            }

            loggerFactory 
                .WithFilter(new FilterLoggerSettings
                {
                { "IdentityServer", LogLevel.Debug },
                { "Microsoft", LogLevel.Information },
                { "System", LogLevel.Error },
                })
                .AddSerilog(serilog.CreateLogger());
        }

        public void ConfigureServices(IServiceCollection services)
        {
            //Make settings available
            var settings = configuration;
            services.Configure<Settings>(settings);

            // configure identity server with in-memory stores, keys, clients and resources
            services.AddIdentityServer()
                .AddTemporarySigningCredential()
                .AddInMemoryApiResources(Resources.GetApiResources())
                .AddInMemoryClients(Clients.GetClients(configuration["spaClientBaseUri"]))
                .AddTestUsers(Users.GetUsers())
                .AddInMemoryIdentityResources(Resources.GetIdentityResources()); // <-- adding identity resources/scopes
            
            //Add MVC for login, logout, consent screen etc.
            services.AddMvc();

        }

        public void Configure(IApplicationBuilder app, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole();
            app.UseDeveloperExceptionPage();

            app.UseIdentityServer();

            app.UseStaticFiles();
            app.UseMvcWithDefaultRoute();
        }
    }
}
