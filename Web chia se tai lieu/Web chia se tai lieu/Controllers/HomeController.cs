using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Web_chia_se_tai_lieu.Models;
using System.Linq;
using Web_chia_se_tai_lieu.Models.Home;
using System.Data.Entity;
using Web_chia_se_tai_lieu.ViewModels;
using System.Security.Cryptography;
using System.Text;

namespace Web_chia_se_tai_lieu.Controllers
{
    public class HomeController : Controller
    {
        private readonly ActionHome actionHome;
        private readonly WebtailieuContext _context;

        public int Pages ;
        int Num_of_Page = 8;

        public HomeController( WebtailieuContext context) 
        {
            _context = context;
            
        }

        public string MaHoaMatKhau(string password)
        {
            UnicodeEncoding encoding = new UnicodeEncoding();
            Byte[] hashBytes = encoding.GetBytes(password);
            SHA1CryptoServiceProvider sha1 = new SHA1CryptoServiceProvider();
            Byte[] cryptPassword = sha1.ComputeHash(hashBytes);
            return BitConverter.ToString(cryptPassword);
        }

        public IActionResult Login()
        {
            
            var categories = _context.Categories.ToList();
            categories.Sort((x, y) => x.Name.CompareTo(y.Name));
            ViewBag.Categories = categories;
            ViewData["LogErorr"] = "true";
            return View();
            
        }
        [HttpPost]
        public IActionResult Login(User LogUser) 
        {
            string pass = MaHoaMatKhau(LogUser.Password);
            var user = _context.Users.FirstOrDefault(p=> p.Email.Equals(LogUser.Email) && p.Password == pass);
            if (user != null)
            {
                int id = user.Id;
                HttpContext.Session.SetInt32("UserId", id);
                return RedirectToAction("Index");
            }
            else
            {
                ViewData["LogErorr"] = "Tài Khoản Hoặc Mật Khẩu không đúng";
                return RedirectToAction("Login");
            }

        }
        public IActionResult Register (string? str)
        {
            var categories = _context.Categories.ToList();
            categories.Sort((x, y) => x.Name.CompareTo(y.Name));
            ViewBag.Categories = categories;
            if (str != null)
            {
                ViewData["Error"] = str;
            }
            else ViewData["Error"] = "true";


            return View();
        }
        [HttpPost]
        public IActionResult Register(UserVM userVM)
        {
            var checkEmail = _context.Users.FirstOrDefault(p=> p.Email.Equals(userVM.Email));
            if(checkEmail == null) 
            {
                User user =new User();
                user.Email = userVM.Email;
                user.Password = MaHoaMatKhau(userVM.Password); 
                user.Name = userVM.Name;
                user.BirthDay = userVM.DateOfBirth;
                user.Coin = userVM.Coin;
                user.Role = userVM.Role;
                _context.Users.Add(user);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            string mailerr = "Mail đã tồn tại";
            return RedirectToAction("Register", mailerr);
        }
       public IActionResult LogOut()
        {
            if(HttpContext.Session.GetInt32("UserId") != null)
            {
                HttpContext.Session.Remove("UserId");
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
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

            var id = HttpContext.Session.GetInt32("UserId");
            ViewBag.User = _context.Users.FirstOrDefault(p => p.Id == id);
            /*
            var productsfree = _context.Products.Where(p => p.Price == 0).ToList();
            ViewBag.Action_Free = productsfree.OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(20).ToList();

            ViewBag.Action_New = _context.Products.OrderByDescending(p => p.TimePost).Take(20).ToList();
            */
            return View();
        }

        public ProductVM ProductVM (Product product)
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
            productVM.FileName = Path.GetFileName(product.File);
            productVM.UserName = _context.Users.FirstOrDefault(p => p.Id == product.UserId).Name;
            productVM.CategoryId = product.CategoryId;
            productVM.CategoryName = _context.Categories.FirstOrDefault(p => p.Id == product.CategoryId).Name;

            return productVM;
        }

        public List<ProductVM> ProductVMs(List<Product> products)
        {
            List<ProductVM> productVMs = new List<ProductVM>();
            
            foreach (var product in products)
            {
                productVMs.Add(ProductVM(product));
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
        public List<Product> getLoadProduct(int id) //id: CategoryId | Nếu id < 0 thì lấy hết sản phẩm ở tất cả danh mục
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

        public IActionResult Product(int? id, List<Product>? products)
        {
            if(HttpContext.Session.GetInt32("UserId") != null)
                ViewData["userId"] = (int)HttpContext.Session.GetInt32("UserId");
            LoadCategories();
            var categories = _context.Categories.ToList();
            categories.Sort((x,y) => x.Name.CompareTo(y.Name));
            ViewBag.Categories  = categories;
            if (id > 0)
            {
                var category = categories.FirstOrDefault(p => p.Id == id);
                ViewData["Category Name"] = category.Name;
                ViewData["id"] = category.Id;
                ViewData["Pages"] = _context.Products.Where(p => p.CategoryId == id && p.Status == "Confirmed").Count() / Num_of_Page + 1;
                var products_category = _context.Products.Where(p => p.CategoryId == id && p.Status == "Confirmed").ToList();
                return View(ProductVMs(products_category));
            }
            else
            {
                if(products != null)
                {
                    ViewData["id"] = -1;
                    ViewData["Pages"] = products.Where(p => p.Status == "Confirmed").Count() / Num_of_Page + 1;
                    return View(ProductVMs(products));
                }
                ViewData["Category Name"] = "Tất Cả Tài Liệu Toàn Bộ Danh Mục ";
                ViewData["id"] = -1;
                ViewData["Pages"] = _context.Products.Where(p => p.Status == "Confirmed").Count() / Num_of_Page + 1;
                
            }
            var products_Nocategory = _context.Products.Where(p => p.Status == "Confirmed").ToList();


            return View(ProductVMs(products_Nocategory));
        }

       

        public IActionResult Load_productPartial(string option1, string option2, int id, int page) //id : CategoryId
        {
            
            List<Product> products = getLoadProduct(id);   //Sử dụng View Models (list) | Lấy sản phẩm theo danh mục (Categoryid) i > 0 || i< 0 lay het
            List<Product> listproduct = products;
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
            Pages = listproduct.Count() / Num_of_Page + 1;
            ViewData["Pages"] = Pages;
            var list =ProductVMs(listproduct.Skip((page - 1) * Num_of_Page).Take(Num_of_Page).ToList()) ;
            
            return PartialView("_productPartial", list);
        }
        public IActionResult Load_pagePartial(string option1, string option2, int id, int page) //id : CategoryId
        {
            
            List<Product> products = getLoadProduct(id);   //Sử dụng View Models (list) | Lấy sản phẩm theo danh mục (Categoryid)
            List<Product> listproduct = products;
            switch (option1)
            {
                case "value1":
                    switch (option2)
                    {
                        case "value4": listproduct = products.OrderByDescending(p => p.Views * 0.1 + p.Likes * 0.5 + p.Downloads).ToList(); break;
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
            
            Pages = listproduct.Count() / Num_of_Page + 1;
            ViewData["Page"] = page;
            return PartialView("_pagePartial", Pages);
        }

        

//---------------------------------------------Detail----------------------------------------------

        public IActionResult Detail (int id)
        {
            if (HttpContext.Session.GetInt32("UserId") != null)
                ViewData["userId"] = (int)HttpContext.Session.GetInt32("UserId");
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            var products = getLoadProduct(product.CategoryId);
            ViewBag.Products_Detail = products.Where(p => p.Id != id).OrderByDescending(p => p.Views * 0.1 + p.Likes * 0.5 + p.Downloads).Take(10).ToList();
            ViewBag.FileName = Path.GetFileName(product.File);
            
            var categories = _context.Categories.ToList();
            categories.Sort((x, y) => x.Name.CompareTo(y.Name));
            ViewBag.Categories = categories;
            return View(ProductVM(product));
        }

        public IActionResult Comment (int UserId, int ProductId)
        {
             
            CommentVM comment = new CommentVM();
            comment.UserId = UserId;
            comment.ProductId = ProductId;
            return PartialView("_commentPartial", comment);
        }
        
        public IActionResult Comment_process (int UserId, int ProductId, string value)
        {
            if(value != null)
            {
                int Id = (int)HttpContext.Session.GetInt32("UserId");
                Comment comment = new Comment();
                comment.TimeCreate = DateTime.Now;
                comment.Content = value;
                comment.ProductId = ProductId;
                comment.UserId = Id; 
                _context.Comments.Add(comment);
                _context.SaveChanges();  
            }
            CommentVM comment1 = new CommentVM();
            comment1.UserId = UserId;
            comment1.ProductId = ProductId;
            return PartialView("_commentPartial", comment1);
        }

        public CommentVM Load_CommentVM (Comment comment)
        {
            CommentVM commentVM = new CommentVM();
            commentVM.Id = comment.Id;
            commentVM.UserId = comment.UserId;
            commentVM.ProductId = comment.ProductId;
            commentVM.ProductName = _context.Products.FirstOrDefault(p => p.Id == comment.ProductId).Name;
            commentVM.UserName = _context.Users.FirstOrDefault(p => p.Id == comment.UserId).Name;
            commentVM.Content = comment.Content;
            commentVM.CreatedDate = comment.TimeCreate;
            commentVM.ImgeUrl = _context.Users.FirstOrDefault(p => p.Id == comment.UserId).Avatar;
            return commentVM;
        }
        public List<CommentVM> Load_CommentVMs(List<Comment> comments)
        {
            List<CommentVM> commentVMs = new List<CommentVM>();
            foreach (Comment comment in comments)
            {
                commentVMs.Add( Load_CommentVM(comment));
            }
            return commentVMs;
        }

        public IActionResult CommentList( int ProductId)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
                ViewData["UserId"] = "";
            else ViewData["UserId"] = (int)HttpContext.Session.GetInt32("UserId");
            List<Comment> comments = _context.Comments.Where(p =>  p.ProductId == ProductId).ToList();
            var commentVMs = Load_CommentVMs(comments);
            
            return PartialView("_listcommentPartial", commentVMs);
        }
        public IActionResult CommentList_delete(int ProductId, int deleteId)
        {
            Comment comment = _context.Comments.FirstOrDefault(p => p.Id == deleteId);
            _context.Comments.Remove(comment);
            _context.SaveChanges();
            List<Comment> comments = _context.Comments.Where(p => p.ProductId == ProductId).ToList();
            var commentVMs = Load_CommentVMs(comments);
            ViewData["UserId"] = (int)HttpContext.Session.GetInt32("UserId");
            return PartialView("_listcommentPartial", commentVMs);
        }
        [HttpPost]
        public IActionResult Search(string search)
        {
           
                List<Product> products1 = _context.Products.Where(p => p.Name.Contains(search)).ToList();
                int Id = -1;
            
            return RedirectToAction("Product",new { id =Id, products = products1});
        }



    }
}