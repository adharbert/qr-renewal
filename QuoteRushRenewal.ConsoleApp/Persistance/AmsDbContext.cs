using Microsoft.EntityFrameworkCore;
using QuoteRushRenewal.ConsoleApp.Domain;

namespace QuoteRushRenewal.ConsoleApp.Persistance
{
    public class AmsDbContext : DbContext
    {
        public AmsDbContext()
        {
            Database.SetCommandTimeout(9000);
        }



        public DbSet<AMSRenewalResults> AMSRenewalResults { get; set; }



        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=63.89.3.222;Persist Security Info=False;User ID=3010652_RO;Password=D78_h4NWH+sbd4ia;MultipleActiveResultSets=False;Connect Timeout=9000;Encrypt=False;TrustServerCertificate=True;Initial Catalog=A3010652D1");
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AMSRenewalResults>().HasNoKey();
        }
    }
}
