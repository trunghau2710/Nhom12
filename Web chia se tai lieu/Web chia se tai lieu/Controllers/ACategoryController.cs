using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using System.Reflection;
using Web_chia_se_tai_lieu.Models;
using System.Data.SqlClient;
namespace Web_chia_se_tai_lieu.Controllers
{
    public class ACategoryController : Controller
    {
        private readonly WebtailieuContext _context;

      
        

        public ACategoryController (WebtailieuContext context)
        {
            _context = context;
        }
        public  IActionResult Index()
        {
            
                List<Category> categories = _context.Categories.ToList();
             
                _context.SaveChanges();
                return View(categories);
                   
        }

        public IActionResult Add()
        {

            return View();
        }

        [HttpPost]
        public IActionResult Add (Category category, IFormFile Image)
        {
            if (Image != null)
            {
                category.Image = SaveImage(Image);
            }
            else category.Image = "";
            
            category.NumberOfProduct = 0;
            
            _context.Categories.Add(category);
            _context.SaveChanges();
            return RedirectToAction(nameof(Index)) ;
        }

        public IActionResult Edit()
        {
            return View();
        }

        public string SaveImage (IFormFile Image)
        {
            var savePath = Path.Combine("wwwroot/Images", Image.FileName);
            using(var fileStream = new FileStream(savePath, FileMode.Create))
            {
                Image.CopyTo(fileStream);
            }
            return "/Images/" + Image.FileName;
        }

        public IActionResult Delete(int id)
        {
            var category = _context.Categories.FirstOrDefault(c => c.Id == id);
            return View(category);
        }
        [HttpPost, ActionName("DeleteConfirm")]
        public IActionResult DeleteConfirm(int id)
        {
            var category = _context.Categories.FirstOrDefault(p => p.Id == id);
            _context.Categories.Remove(category);
            _context.SaveChanges();
            return RedirectToAction(nameof(Index)) ;
        }
    }
}
