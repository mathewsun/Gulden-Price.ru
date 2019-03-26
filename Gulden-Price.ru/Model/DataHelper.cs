using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace Gulden_Price.ru.Model
{
    public class DataHelper
    {
        public static User GetUser(Guid userId)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.Users.FirstOrDefault(x => x.UserId == userId);
            }
        }

        public static User GetUserByName(string userName)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.Users.FirstOrDefault(x => x.UserName == userName);
            }
        }

        public static void UpdateUser(User item)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                User obj = ctx.Users.FirstOrDefault(x => x.UserId == item.UserId);

                if (obj != null)
                {
                    obj.VendorName = item.VendorName;
                    obj.Phone = item.Phone;
                    obj.Address = item.Address;
                    obj.Description = item.Description;

                    ctx.SubmitChanges();
                }
            }
        }

        public static int GetUsersCount()
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.Users.Count();
            }
        }

        public static List<User> GetUsersByRole(string role)
        {
            List<User> list = new List<User>();

            string[] usersInRole = Roles.GetUsersInRole(role);

            foreach (var item in usersInRole)
            {
                list.Add(GetUserByName(item));
            }

            return list;
        }

        public static void UpdateUserRole(Guid userId, string roleName)
        {
            Role role = new Role();

            using (var ctx = new DataClasses1DataContext())
            {
                role = ctx.Roles.FirstOrDefault(x => x.RoleName == roleName);
            }

            UsersInRole uir;

            using (var ctx = new DataClasses1DataContext())
            {
                uir = ctx.UsersInRoles.FirstOrDefault(x => x.RoleId == role.RoleId && x.UserId == userId);

                if (uir != null)
                {
                    ctx.UsersInRoles.DeleteOnSubmit(uir);
                }
                else
                {
                    uir = new UsersInRole();

                    uir.UserId = userId;
                    uir.RoleId = role.RoleId;

                    ctx.UsersInRoles.InsertOnSubmit(uir);
                }

                ctx.SubmitChanges();
            }
        }

        public static List<fnGetAllUsersResult> GetAllUsers()
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.fnGetAllUsers().ToList();
            }
        }

        public static void DeleteUser(Guid id)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                User obj = ctx.Users.Single(x => x.UserId == id);

                ctx.Users.DeleteOnSubmit(obj);

                try
                {
                    ctx.SubmitChanges();
                }
                catch
                {
                }
            }
        }

        public static List<User> GetVendors()
        {
            return GetUsersByRole("Vendor");
        }

        public static int GetVendorsCount()
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.UsersInRoles.Count(x => x.RoleId == Guid.Parse("BB13D57B-8201-4036-A238-E5524C11DCAF"));
            }
        }
        #region Продукты

        public static int UpdateProduct(Product item)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                int result = 0;

                Product obj = ctx.Products.FirstOrDefault(x => x.Id == item.Id);

                if (obj == null)
                {
                    obj = ctx.Products.FirstOrDefault(x => x.Name == item.Name && x.UserID == item.UserID);
                }

                if (obj != null)
                {
                    obj.Name = item.Name;
                    obj.Price = item.Price;
                    obj.UserID = item.UserID;
                    obj.WhenDate = DateTime.Now;

                    result = 2;
                }
                else
                {
                    ctx.Products.InsertOnSubmit(item);

                    result = 1;
                }

                try
                {
                    ctx.SubmitChanges();
                }
                catch
                {
                    result = 0;
                }

                return result;
            }
        }

        public static List<fnGetAllProductsResult> GetAllProducts(string filter, string sort, string dir, int size, int pageNum)
        {
            if (string.IsNullOrEmpty(sort))
            {
                sort = "name";
            }

            if (string.IsNullOrEmpty(dir))
            {
                dir = "asc";
            }

            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.fnGetAllProducts(filter, sort, dir, size, pageNum).ToList();
            }
        }

        public static int GetAllProductsCount(string filter)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                int? result = ctx.fnGetAllProductsCount(filter);

                return result.HasValue ? result.Value : 0;
            }
        }

        public static List<Product> GetProductsByUser(Guid userId)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.Products.Where(x => x.UserID == userId).OrderBy(x => x.Name).ToList();
            }
        }

        public static int GetProductsByUserCount(Guid userId)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                return ctx.Products.Count(x => x.UserID == userId);
            }
        }

        public static void DeleteProduct(int id)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                Product obj = ctx.Products.Single(x => x.Id == id);

                ctx.Products.DeleteOnSubmit(obj);

                try
                {
                    ctx.SubmitChanges();
                }
                catch
                {
                }
            }
        }

        public static void DeleteProductsByUser(Guid userId)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                var items = ctx.Products.Where(c => c.UserID == userId);

                ctx.Products.DeleteAllOnSubmit(items);
                ctx.SubmitChanges();
            }
        }

        public static void DeleteOldProducts(Guid userId)
        {
            using (var ctx = new DataClasses1DataContext())
            {
                int? result = 0;

                ctx.spDeleteOldProducts(userId, ref result);
            }
        }

        #endregion
    }
}
