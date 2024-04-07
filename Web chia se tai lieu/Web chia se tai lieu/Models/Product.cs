using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class Product
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public int? Price { get; set; }

    public string File { get; set; } = null!;

    public string? FileImage { get; set; }

    public DateTime? TimeCreate { get; set; }

    public DateTime? TimePost { get; set; }

    public string? TypeFile { get; set; }

    public int CategoryId { get; set; }

    public int UserId { get; set; }

    public int? Views { get; set; }

    public int? Downloads { get; set; }

    public int? Likes { get; set; }

    public string? Status { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<Comment> Comments { get; } = new List<Comment>();

    public virtual ICollection<InvoiceProduct> InvoiceProducts { get; } = new List<InvoiceProduct>();

    public virtual ICollection<Report> Reports { get; } = new List<Report>();

    public virtual User User { get; set; } = null!;
}
