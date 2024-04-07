using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Web_chia_se_tai_lieu.Models;
using System.Linq;

namespace Web_chia_se_tai_lieu.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly WebtailieuContext _context;

        public HomeController( WebtailieuContext context) 
        {
            _context = context;
        }

       

        public IActionResult Index()
        {
            var categories = _context.Categories.ToList();
            categories.Sort((x, y) => x.Name.CompareTo(y.Name));
            
            var products = _context.Products.ToList();
            ViewBag.Products = products;
            ViewBag.Products_top = products.OrderByDescending(x => ((x.Views * 0.1) + x.Downloads + (x.Likes*0.5))).Take(20).ToList();
            

            ViewBag.Products_asc = products.OrderByDescending(x => x.Price).Take(10); 
            ViewBag.Categories = categories;
            ViewBag.Users = _context.Users.ToList();
            return View();
        } 
        
       

       
        
    }
}