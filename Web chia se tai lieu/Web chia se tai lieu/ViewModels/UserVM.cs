using System.ComponentModel.DataAnnotations;

namespace Web_chia_se_tai_lieu.ViewModels
{
    public class UserVM
    {
        [Required]
        public string Name { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        [Compare("Password", ErrorMessage = "Xác nhận mật khẩu không khớp.")]
        public string ConfirmPassword { get; set; }


        [Required]
        [DataType(DataType.Date)]
        public DateTime DateOfBirth { get; set; }
        public string? Avatar { get; set; }
        public int? Coin { get; set; } = 0;
        public string Role { get; set; } = "user";
    }
}
