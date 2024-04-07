using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class Category
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? NumberOfProduct { get; set; }

    public string? Image { get; set; }

    public virtual ICollection<Product> Products { get; } = new List<Product>();
}
