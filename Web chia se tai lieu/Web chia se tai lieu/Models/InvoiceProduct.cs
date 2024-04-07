using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class InvoiceProduct
{
    public int Id { get; set; }

    public DateTime TimeCreate { get; set; }

    public int? Total { get; set; }

    public string EmailUser { get; set; } = null!;

    public string NameProduct { get; set; } = null!;

    public int? UserId { get; set; }

    public int? ProductId { get; set; }

    public virtual Product? Product { get; set; }

    public virtual User? User { get; set; }
}
