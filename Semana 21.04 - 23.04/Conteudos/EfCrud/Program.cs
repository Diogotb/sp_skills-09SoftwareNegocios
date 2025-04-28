using EfCrud.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading.Tasks;

namespace EfCrud.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<Category> Categories { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            var connectionString = "Server=localhost;Database=teste;User=root;Password=123456789;";
            var serverVersion = new MySqlServerVersion(new Version(8, 0, 34));
            options.UseMySql(connectionString, serverVersion);
        }
    }

    public class Program
    {
        public static async Task Main()
        {
            using var context = new AppDbContext();

            // CREATE
            var category = new Category(0, "Categoria 1", "categoria-1", "Descrição da Categoria 1");
            await context.Categories.AddAsync(category);
            await context.SaveChangesAsync();

            // READ
            var categories = await context.Categories.Where(x => x.Active).ToListAsync();
            var oneCategory = await context.Categories.FirstOrDefaultAsync(x => x.Id == 1);

            // UPDATE
            var categoryToUpdate = await context.Categories.FirstOrDefaultAsync(x => x.Id == 1);
            if (categoryToUpdate != null)
            {
                categoryToUpdate.Title = "Categoria Atualizada";
                context.Categories.Update(categoryToUpdate);
                await context.SaveChangesAsync();
            }

            // DELETE
            var categoryToDelete = await context.Categories.FirstOrDefaultAsync(x => x.Id == 1);
            if (categoryToDelete != null)
            {
                context.Categories.Remove(categoryToDelete);
                await context.SaveChangesAsync();
            }
        }
    }
}
