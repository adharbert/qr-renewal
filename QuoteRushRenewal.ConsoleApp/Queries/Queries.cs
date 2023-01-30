using Microsoft.Extensions.FileProviders;
using System;
using System.IO;
using System.Reflection;
namespace QuoteRushRenewal.ConsoleApp.Queries
{
    public static class Queries
    {
        private static readonly IFileProvider Files = new ManifestEmbeddedFileProvider(Assembly.GetExecutingAssembly(), "Queries");
        public static string Named(string name) => ReadSqlFile(name, allowNotFound: false);
        private static string ReadSqlFile(string name, bool allowNotFound = false)
        {
            string text = "";
            try
            {
                string queryPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\Queries";
                string fileWithPath = $"{queryPath}\\{name}.sql";
                if (File.Exists(fileWithPath))
                {
                    using (var sr = new StreamReader(fileWithPath))
                    {
                        text = sr.ReadToEnd();
                    }
                } 
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
            }
            return text;
        }
    }
}