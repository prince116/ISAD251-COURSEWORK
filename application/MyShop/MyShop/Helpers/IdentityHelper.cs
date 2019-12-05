using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyShop.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;

namespace MyShop.Helpers
{
    public class IdentityHelper
    {
        internal static void SeedIdentities(DbContext context)
        {
            var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

            if (!roleManager.RoleExists(RoleNames.ROLE_ADMINISTRATOR))
            {
                var roleresult = roleManager.Create(new IdentityRole(RoleNames.ROLE_ADMINISTRATOR));
            }
            if (!roleManager.RoleExists(RoleNames.ROLE_CONTRIBUTOR))
            {
                var roleresult = roleManager.Create(new IdentityRole(RoleNames.ROLE_CONTRIBUTOR));
            }
            if (!roleManager.RoleExists(RoleNames.ROLE_READER))
            {
                var roleresult = roleManager.Create(new IdentityRole(RoleNames.ROLE_READER));
            }

            string userName = "admin@myshop.com";
            string password = "Aa~11111111";

            ApplicationUser user = userManager.FindByName(userName);
            if (user == null)
            {
                user = new ApplicationUser()
                {
                    UserName = userName,
                    Email = userName,
                    EmailConfirmed = true
                };
                IdentityResult userResult = userManager.Create(user, password);
                if (userResult.Succeeded)
                {
                    var result = userManager.AddToRole(user.Id, RoleNames.ROLE_ADMINISTRATOR);
                }
            }
        }
    }
}