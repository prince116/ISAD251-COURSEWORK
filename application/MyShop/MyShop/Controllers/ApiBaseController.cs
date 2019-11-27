using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using MyShop.Models;
using System.Web.Http;
using Microsoft.AspNet.Identity;

namespace MyShop.Controllers
{
    public class ApiBaseController : ApiController
    {
        private ApplicationDbContext applicationDbContext = new ApplicationDbContext();

        public string getUserId()
        {
            return User.Identity.GetUserId();
        }

        public bool IsAdmin()
        {
            var userId = User.Identity.GetUserId();

            var role = applicationDbContext.Roles.Where(r => r.Name.Contains("administrator")).FirstOrDefault();
            var users = applicationDbContext.Users.Where(x => x.Roles.Select(y => y.RoleId).Contains(role.Id)).ToList();
            var IsAdmin = users.Find(x => x.Id == userId);

            if (IsAdmin == null)
            {
                return false;
            }
            return true;
        }
    }
}