using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Web_chia_se_tai_lieu.Models;
using System.Linq;
using Web_chia_se_tai_lieu.Models.Home;
using System.Data.Entity;
using Web_chia_se_tai_lieu.ViewModels;

namespace Web_chia_se_tai_lieu.Controllers
{
    public class HomeController : Controller
    {
        private readonly ActionHome actionHome;
        private readonly WebtailieuContext _context;

        public HomeController( WebtailieuContext context) 
        {
            _context = context;
        }
        
       

        public IActionResult Index()
        {
            var categories = _context.Categories.ToList();
            categories.Sort((x, y) => x.Name.CompareTo(y.Name));
            
            var products = _context.Products.Where(p =>p.Status == "Confirmed");
            ViewBag.Products = products;
           
            ViewBag.Categories = categories;
            ViewBag.Users  = _context.Users.ToList();
            
            var productspre = _context.Products.Where(p => p.Price > 0).ToList();
            ViewBag.Products_top = products.OrderByDescending(p => p.Views * 0.1 + p.Likes * 0.5 + p.Downloads).Take(20).ToList();
            
            /*
            var productsfree = _context.Products.Where(p => p.Price == 0).ToList();
            ViewBag.Action_Free = productsfree.OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(20).ToList();

            ViewBag.Action_New = _context.Products.OrderByDescending(p => p.TimePost).Take(20).ToList();
            */
            return View();
        }

        public List<ProductVM> ProductVMs(List<Product> products)
        {
            List<ProductVM> productVMs = new List<ProductVM>();
            
            foreach (var product in products)
            {
                ProductVM productVM = new ProductVM();
                productVM.Id = product.Id;
                productVM.Name = product.Name;
                productVM.Description = product.Description;
                productVM.TimePost = product.TimePost;
                productVM.TimeCreate = product.TimeCreate;
                productVM.File = product.File;
                productVM.FileImage = product.FileImage;
                productVM.Status = product.Status;
                productVM.TypeFile = product.TypeFile;
                productVM.Views = product.Views;
                productVM.Likes = product.Likes;
                productVM.Downloads = product.Downloads;
                productVM.Price = product.Price;
                productVM.UserName = _context.Users.FirstOrDefault(p => p.Id == product.UserId).Name;
                productVM.CategoryId = product.CategoryId; 

                productVMs.Add(productVM);
            }
            return productVMs;
        }

        public IActionResult Load_homePartial(string viewName)
        {
           
            var products = _context.Products.Where(p => p.Price > 0 && p.Status =="Confirmed").OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(20).ToList();
            
            return PartialView("homePartial",ProductVMs(products));
        }
        public IActionResult Load_homePartial1(string viewName)
        {
            
            var products = _context.Products.Where(p => p.Price == 0 && p.Status == "Confirmed").OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(20).ToList();
            return PartialView("homePartial", ProductVMs(products));
        }

        public IActionResult Load_homePartial2(string viewName)
        {
            
            var products = _context.Products.Where(p => p.Status == "Confirmed").OrderByDescending(p => p.TimePost).Take(20).ToList();
            return PartialView("homePartial", ProductVMs(products));
        }

        //-------------------------------------Product-----------------------
        public List<Product> getLoadProduct(int? id) //id: CategoryId
        {
            if(id < 0)
                return _context.Products.Where(p=> p.Status == "Confirmed").ToList();
            else return _context.Products.Where(p => p.Status == "Confirmed" && p.CategoryId == id).ToList();
        }
        public void LoadCategories()
        {
            var products =  getLoadProduct(-1); //Lấy sản phẩm có id của danh mục = -1 == lấy hết sản phẩm
            foreach(var item in _context.Categories)
            {
                item.NumberOfProduct = products.Where(p => p.CategoryId == item.Id).Count(); 
            }

        }

        public IActionResult Product(int? id)
        {
            if(id != null)
            {

            }
            LoadCategories();
            var categories = _context.Categories.ToList();
            categories.Sort((x,y) => x.Name.CompareTo(y.Name));
            ViewBag.Categories  = categories;
            if (id != null)
            {
                var category = categories.FirstOrDefault(p => p.Id == id);
                ViewData["Category Name"] = category.Name;
                ViewData["id"] = category.Id;
            }
                
            else ViewData["Category Name"] = "Tất Cả Tài Liệu Toàn Bộ Danh Mục ";
            var products = _context.Products.Where(p => p.CategoryId == id && p.Status == "Confirmed").ToList();
            
            return View(ProductVMs(products));
        }

        public IActionResult Load_productPartial(string option1, string option2, int id, int page)
        {
            var products = ProductVMs(getLoadProduct(id));   //Sử dụng View Models (list) | Lấy sản phẩm theo danh mục (Categoryid)
            var listproduct = products;
            switch (option1)
            {
                case "value1": 
                    switch (option2)
                    {
                       case "value4":  listproduct = products.OrderByDescending(p => p.Views * 0.1 + p.Likes * 0.5 + p.Downloads).ToList(); break;
                        case "value5": listproduct = products.Where(p => p.Price == 0).ToList(); break;
                        case "value6": listproduct = products.Where(p => p.Price > 0).ToList(); break;
                    }
                    break;
                case "value2":
                    
                    switch (option2)
                    {
                        case "value4": listproduct = products.OrderByDescending(p => p.Views).ToList(); break;
                        case "value5": listproduct = products.OrderByDescending(p => p.Views).Where(p => p.Price == 0).ToList(); break;
                        case "value6": listproduct = products.OrderByDescending(p => p.Views).Where(p => p.Price > 0).ToList(); break;
                    }
                    break;
                case "value3":
                    
                    switch (option2)
                    {
                        case "value4": listproduct = products.OrderByDescending(p => p.TimePost).ToList(); break;
                        case "value5": listproduct = products.OrderByDescending(p => p.TimePost).Where(p => p.Price == 0).ToList(); break;
                        case "value6": listproduct = products.OrderByDescending(p => p.TimePost).Where(p => p.Price > 0).ToList(); break;
                    }
                    break;
            }
            ViewBag.Pages = listproduct.Count()/8 +1;
            listproduct.Skip((page-1) * 8).Take(8);
            return PartialView("_productPartial", listproduct);
        }





    }
}