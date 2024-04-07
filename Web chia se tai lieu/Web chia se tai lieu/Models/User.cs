using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class User
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Role { get; set; } = null!;

    public string? Avatar { get; set; }

    public DateTime? BirthDay { get; set; }

    public int? Coin { get; set; }

    public virtual ICollection<Comment> Comments { get; } = new List<Comment>();

    public virtual ICollection<InvoiceCoin> InvoiceCoins { get; } = new List<InvoiceCoin>();

    public virtual ICollection<InvoiceProduct> InvoiceProducts { get; } = new List<InvoiceProduct>();

    public virtual ICollection<Product> Products { get; } = new List<Product>();

    public virtual ICollection<Report> Reports { get; } = new List<Report>();
}
