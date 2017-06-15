using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;

namespace SpaIdSrv
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var h = new WebHostBuilder();
            var environment = h.GetSetting("environment");
            var builder = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                    .AddJsonFile($"appsettings.{environment}.json", optional: true)
                    .AddEnvironmentVariables();
            var configuration = builder.Build();

            Console.Title = "SPA Identity Server";
            var host = new WebHostBuilder()
                .UseKestrel()
                .UseUrls(configuration["serverurls"])
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>()
                .Build();

            host.Run();
        }
    }
}
