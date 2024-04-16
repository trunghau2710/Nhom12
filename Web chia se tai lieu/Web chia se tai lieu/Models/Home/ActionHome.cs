using Web_chia_se_tai_lieu.Models;
namespace Web_chia_se_tai_lieu.Models.Home
{
    public class ActionHome
    {
        private readonly WebtailieuContext _context;

        public IEnumerable<Product> GetAll()
        {
            return _context.Products.ToList();
        }
         public List<Product> getProductsPremium (int SL)
        {
            var products =_context.Products.Where(p=> p.Price > 0).ToList();
            return products.OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(SL).ToList();
        }

        public List<Product> getProductsFree(int SL)
        {
            var products = _context.Products.Where(p => p.Price == 0).ToList();
            return products.OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).Take(SL).ToList();
        }

        public List<Product> getProductsNew(int SL)
        {
            var products = GetAll();
            products.OrderByDescending(p => p.TimePost).Take(SL);
            return products.OrderByDescending(p => p.Downloads + p.Likes * 0.5 + p.Views * 0.1).ToList();
        }
    }
}
