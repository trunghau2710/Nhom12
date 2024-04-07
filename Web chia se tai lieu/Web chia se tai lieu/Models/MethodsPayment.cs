using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class MethodsPayment
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Detail { get; set; }

    public virtual ICollection<InvoiceCoin> InvoiceCoins { get; } = new List<InvoiceCoin>();
}
