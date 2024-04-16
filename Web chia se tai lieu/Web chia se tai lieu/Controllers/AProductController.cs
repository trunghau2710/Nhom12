using Microsoft.AspNetCore.Connections;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Web_chia_se_tai_lieu.Models;
using System.IO;

namespace Web_chia_se_tai_lieu.Controllers
{
    public class AProductController : Controller
    {
        private readonly WebtailieuContext _context;
        


        public AProductController(WebtailieuContext context)
        {
            _context = context;
        }
        
        public IActionResult Index()
        {
           
            
            foreach (var product in _context.Products)
            {
                
                if(product.Views == null ||  product.Views ==0)
                {
                    product.Views = Random(10000);
                }
                if(product.Downloads == null || product.Downloads == 0)
                    product.Downloads = Random(500);
                if (product.Likes == null || product.Likes == 0)
                    product.Likes = Random(1000);
                var date = DateTime.Now;
                if(product.TimeCreate.Value.Year < date.Year)
                    product.TimeCreate = date.AddDays(-2);
                _context.Products.Update(product);
               
            }
            _context.SaveChanges();
            var products = _context.Products.ToList();
            return View(products);
        }

        public int GetIdProduct()
        {
            int i = 0;
            foreach (var x in _context.Products)
                i = x.Id;
            return i;
        }

        public IActionResult Add ()
        {
            
            var categories = _context.Categories.ToList();
            ViewBag.Categories = new SelectList(categories, "Id", "Name");
            
            return View();
        }

        public int Random (int x)
        {
            Random rd = new Random();
            return rd.Next(1,x);
        }
        [HttpPost]
        public IActionResult Add(Product product, IFormFile FileUrl, IFormFile ImageUrl)
        { //Ham ModelState se kiem tra lai du lieu cua Model duoc truyen tu view qua
            //Ta chi truyen FIle anh vs file qua 2 bien FileUrl ... con model.FileUrl vs cac bien con lai thi chua nhan duoc nen can phai bo kiem tra
            
            ModelState.Remove("File");
            ModelState.Remove("FileImage");
            ModelState.Remove("Category");
            ModelState.Remove("User");
            
            int id = GetIdProduct() + 1;

            if (ImageUrl != null)
            {
                product.FileImage = SaveImage(ImageUrl,id);
            }
            if (FileUrl != null)
            {
                product.File = SaveFile(FileUrl, id);
                product.TypeFile = Path.GetExtension(FileUrl.FileName);
            }
            if (ModelState.IsValid)
            {
                product.User = _context.Users.FirstOrDefault(p => p.Id == 1);
                product.Status = "No Confirm";
                product.UserId = 1;
                product.Views = 0;
                product.Likes = 0;
                product.Downloads = 0;
                product.TimeCreate = DateTime.Now;
                _context.Products.Add(product);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }      
            var categories = _context.Categories.ToList();
            ViewBag.categories = new SelectList(categories, "Id", "Name");
            return RedirectToAction(nameof(Add)); 
             
           
        }

        public IActionResult Update(int id)
        {
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            var categories = _context.Categories.ToList();
            ViewBag.categories = new SelectList(categories, "Id", "Name");
            return View(product);
        }
        [HttpPost]
        public IActionResult Update(int id, Product product, IFormFile ImageUrl, IFormFile FileUrl) 
        {
            ModelState.Remove("File");
            ModelState.Remove("FileImage");
            ModelState.Remove("Category");
            ModelState.Remove("User");

            
            if(ImageUrl != null)
            {
                product.FileImage = SaveImage(ImageUrl, id);
            }
            if( FileUrl != null)
            {
                product.File = SaveFile(FileUrl, id);
                product.TypeFile = Path.GetExtension(FileUrl.FileName);
            }
            if(ModelState.IsValid)
            {
                var existProduct =  _context.Products.FirstOrDefault(product => product.Id == id);
                if (existProduct != null)
                {
                    existProduct.Name = product.Name;
                    existProduct.Description = product.Description;
                    existProduct.CategoryId = product.CategoryId;
                    existProduct.TimeCreate = product.TimeCreate;
                    existProduct.Price = product.Price;
                    existProduct.File = product.File;
                    existProduct.FileImage = product.FileImage;
                    existProduct.Views = product.Views;
                    existProduct.Likes = product.Likes;
                    existProduct.Downloads = product.Downloads;
                    existProduct.Status = "No Confirm";
                    existProduct.TypeFile = product.TypeFile;
                    _context.Products.Update(existProduct);
                    _context.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            var categories = _context.Categories;
            ViewBag.Categories = new SelectList("categories", "Id", "Name");
            return View(product);

        }
        public string SaveImage(IFormFile Image, int id)
        {
            int index = Image.FileName.IndexOf(".");
            var filename = Image.FileName.Insert(index - 1, "_" + id.ToString());
            var savePath = Path.Combine("wwwroot/Images",filename);
            using (var fileStream = new FileStream(savePath, FileMode.Create))
            {
                Image.CopyTo(fileStream);
            }
            return "/Images/" + Image.FileName;
        }
        public string SaveFile(IFormFile FileUrl, int id)
        {
            int index =  FileUrl.FileName.IndexOf(".");
            var filename = FileUrl.FileName.Insert(index - 1, "_" + id.ToString());
            var savePath = Path.Combine("wwwroot/file", filename);
            using (var fileStream = new FileStream(savePath, FileMode.Create))
            {
                FileUrl.CopyTo(fileStream);
            }
            return "/file/" + FileUrl.FileName;
        }

       
        public IActionResult Confirmed (int id)
        {
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            if (product == null)
            {
                return NotFound();
            }
            else
            {
                var category = _context.Categories.FirstOrDefault(c => c.Id == product.CategoryId);
                category.NumberOfProduct += 1;
                
                product.Status = "Confirmed";
                product.TimePost = DateTime.Now;
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }
        
        public IActionResult Cancer(int id)
        {
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            if (product == null)
            {
                return NotFound();
            }
            else
            {
                product.Status = "Cancelled";
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        public void DeleteFile (string FileUrl)
        {
            var filePath = ("wwwroot"+ FileUrl);
            if(System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }
        }

        public IActionResult Delete(int id) 
        {
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            if(product == null)
            {
                return NotFound();
            }
            else
            {
                DeleteFile(product.File);
                DeleteFile(product.FileImage);
                _context.Products.Remove(product);
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }
    }
}
