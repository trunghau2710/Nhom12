using Microsoft.AspNetCore.Mvc;
using Web_chia_se_tai_lieu.Models;

namespace Web_chia_se_tai_lieu.Controllers
{
    public class AUserController : Controller
    {
        private readonly WebtailieuContext _context;
        public AUserController (WebtailieuContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {/*
            User user = new User();
            user.Name = "User1";
            user.Avarta = "/Images/Tải xuống.png";
            user.Birthday = DateTime.Now;
            user.Role = "user";
            user.Email = "we.nobita1@gmail.com";
            user.Password = "1234";
            _context.Add(user);
            _context.SaveChanges();*/
            return RedirectToAction("Index","AProduct");
        }
    }
}
