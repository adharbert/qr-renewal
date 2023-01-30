using Microsoft.EntityFrameworkCore;
using QuoteRushRenewal.ConsoleApp.Domain;

namespace QuoteRushRenewal.ConsoleApp.Persistance
{
    class BotDbContext : DbContext
    {
        public BotDbContext()
        {
            Database.SetCommandTimeout(9000);
        }

        public DbSet<BotRenewalResults> BotRenewalResults { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //optionsBuilder.UseSqlServer("Data Source=sqlservercarrierbots.database.windows.net;Persist Security Info=False;User ID=SAsqlservercarrierbots;Password=Br1ght\\'@y5QlC@rr13rs;MultipleActiveResultSets=False;Connect Timeout=9000;Encrypt=False;TrustServerCertificate=True;Initial Catalog=dbCarrierBotsProd");
            optionsBuilder.UseSqlServer("Data Source=sqlservercarrierbots.database.windows.net;Initial Catalog=dbCarrierBotsProd;User Id=SAsqlservercarrierbots;Password=Br1ght\\\\'@y5QlC@rr13rs;Persist Security Info=True");
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BotRenewalResults>().HasNoKey();
        }

    }
}
