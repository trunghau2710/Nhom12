using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Web_chia_se_tai_lieu.Models;

public partial class WebtailieuContext : DbContext
{
    public WebtailieuContext()
    {
    }

    public WebtailieuContext(DbContextOptions<WebtailieuContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AdminUser> AdminUsers { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<InvoiceCoin> InvoiceCoins { get; set; }

    public virtual DbSet<InvoiceProduct> InvoiceProducts { get; set; }

    public virtual DbSet<MethodsPayment> MethodsPayments { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<Report> Reports { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=LAPTOP-NKSDC3SJ\\SQLEXPRESS;Initial Catalog=Webtailieu;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AdminUser>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__AdminUse__3214EC07CF3A890A");

            entity.ToTable("AdminUser");

            entity.HasIndex(e => e.Email, "UQ__AdminUse__A9D105346F58C6DD").IsUnique();

            entity.Property(e => e.Avatar).HasMaxLength(1000);
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Name).HasMaxLength(255);
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Role)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Category__3214EC07F5B24C48");

            entity.ToTable("Category");

            entity.Property(e => e.Image).HasMaxLength(1000);
            entity.Property(e => e.Name).HasMaxLength(255);
            entity.Property(e => e.NumberOfProduct).HasDefaultValueSql("((0))");
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Comment__3214EC075CC9CFBC");

            entity.ToTable("Comment");

            entity.Property(e => e.Content).HasColumnType("ntext");
            entity.Property(e => e.ProductId).HasColumnName("productId");
            entity.Property(e => e.TimeCreate).HasColumnType("date");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.Product).WithMany(p => p.Comments)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Comment__product__3C34F16F");

            entity.HasOne(d => d.User).WithMany(p => p.Comments)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Comment__userId__3D2915A8");
        });

        modelBuilder.Entity<InvoiceCoin>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Invoice___3214EC078E3989DD");

            entity.ToTable("Invoice_Coin");

            entity.Property(e => e.Mpid).HasColumnName("MPId");
            entity.Property(e => e.Price).HasColumnType("money");
            entity.Property(e => e.TimeCreate).HasColumnType("datetime");

            entity.HasOne(d => d.Mp).WithMany(p => p.InvoiceCoins)
                .HasForeignKey(d => d.Mpid)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Invoice_Co__MPId__66603565");

            entity.HasOne(d => d.User).WithMany(p => p.InvoiceCoins)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Invoice_C__UserI__656C112C");
        });

        modelBuilder.Entity<InvoiceProduct>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Invoice___3214EC07BE66FC93");

            entity.ToTable("Invoice_Product");

            entity.Property(e => e.EmailUser).HasMaxLength(1000);
            entity.Property(e => e.NameProduct).HasMaxLength(512);
            entity.Property(e => e.TimeCreate).HasColumnType("datetime");
            entity.Property(e => e.Total).HasDefaultValueSql("((0))");

            entity.HasOne(d => d.Product).WithMany(p => p.InvoiceProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Invoice_P__Produ__5FB337D6");

            entity.HasOne(d => d.User).WithMany(p => p.InvoiceProducts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Invoice_P__UserI__5EBF139D");
        });

        modelBuilder.Entity<MethodsPayment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Methods___3214EC0702525617");

            entity.ToTable("Methods_Payment");

            entity.Property(e => e.Detail).HasMaxLength(1000);
            entity.Property(e => e.Name).HasMaxLength(255);
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Product__3214EC071220918D");

            entity.ToTable("Product");

            entity.Property(e => e.Description).HasColumnType("ntext");
            entity.Property(e => e.Downloads).HasDefaultValueSql("((0))");
            entity.Property(e => e.File).HasMaxLength(1000);
            entity.Property(e => e.FileImage).HasMaxLength(1000);
            entity.Property(e => e.Likes).HasDefaultValueSql("((0))");
            entity.Property(e => e.Name).HasMaxLength(512);
            entity.Property(e => e.Price).HasDefaultValueSql("((0))");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasDefaultValueSql("('Chua Duy?t')");
            entity.Property(e => e.TimeCreate).HasColumnType("datetime");
            entity.Property(e => e.TimePost).HasColumnType("datetime");
            entity.Property(e => e.TypeFile)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Views).HasDefaultValueSql("((0))");

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Product__Likes__59FA5E80");

            entity.HasOne(d => d.User).WithMany(p => p.Products)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Product__UserId__5AEE82B9");
        });

        modelBuilder.Entity<Report>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.ProductId }).HasName("PK__Report__DCC800205CB160D5");

            entity.ToTable("Report");

            entity.Property(e => e.Content).HasColumnType("ntext");
            entity.Property(e => e.TimeCreate).HasColumnType("datetime");

            entity.HasOne(d => d.Product).WithMany(p => p.Reports)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__Report__ProductI__6E01572D");

            entity.HasOne(d => d.User).WithMany(p => p.Reports)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Report__UserId__6D0D32F4");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__User__3214EC074C2EAC8E");

            entity.ToTable("User");

            entity.HasIndex(e => e.Email, "UQ__User__A9D105348203CF45").IsUnique();

            entity.Property(e => e.Avatar).HasMaxLength(1000);
            entity.Property(e => e.BirthDay).HasColumnType("datetime");
            entity.Property(e => e.Coin).HasDefaultValueSql("((0))");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Name).HasMaxLength(255);
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Role)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
