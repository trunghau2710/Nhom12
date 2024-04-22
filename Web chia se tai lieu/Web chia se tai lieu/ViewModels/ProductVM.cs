namespace Web_chia_se_tai_lieu.ViewModels
{
    public class ProductVM
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string? Description { get; set; }

        public int? Price { get; set; }
        public string? FileName { get; set; }

        public string File { get; set; } = null!;

        public string? FileImage { get; set; }

        public DateTime? TimeCreate { get; set; }

        public DateTime? TimePost { get; set; }

        public string? TypeFile { get; set; }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; }

        public string UserName { get; set; }

        public int? Views { get; set; }

        public int? Downloads { get; set; }

        public int? Likes { get; set; }

        public string? Status { get; set; }
    }
}
