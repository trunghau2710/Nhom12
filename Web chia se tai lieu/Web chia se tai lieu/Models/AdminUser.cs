using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class AdminUser
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? Role { get; set; }

    public string? Avatar { get; set; }
}
