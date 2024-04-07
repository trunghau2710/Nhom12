using System;
using System.Collections.Generic;

namespace Web_chia_se_tai_lieu.Models;

public partial class InvoiceCoin
{
    public int Id { get; set; }

    public DateTime TimeCreate { get; set; }

    public decimal Price { get; set; }

    public int Coins { get; set; }

    public int? Mpid { get; set; }

    public int? UserId { get; set; }

    public virtual MethodsPayment? Mp { get; set; }

    public virtual User? User { get; set; }
}
