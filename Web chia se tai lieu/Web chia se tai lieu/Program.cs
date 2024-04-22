using Microsoft.EntityFrameworkCore;
using Web_chia_se_tai_lieu.Models;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<WebtailieuContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("DbContext")));



builder.Services.AddDistributedMemoryCache(); // L?u tr? Session trong b? nh? cache
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(20); // Th?i gian h?t h?n (t�y ch?n)
    options.Cookie.HttpOnly = true; // Thi?t l?p thu?c t�nh HttpOnly cho cookie (t�y ch?n)
    options.Cookie.IsEssential = true; // ?�nh d?u cookie l� c?n thi?t (t�y ch?n)
});
// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseSession();

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
