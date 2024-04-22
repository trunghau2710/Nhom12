namespace Web_chia_se_tai_lieu.ViewModels
{
    public class CommentVM
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string Content { get; set; }
        public string ImgeUrl { get; set; }


    }
}
