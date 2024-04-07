using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class Report
{
    public int UserId { get; set; }

    public int ProductId { get; set; }

    public string? Content { get; set; }

    public DateTime? TimeCreate { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
