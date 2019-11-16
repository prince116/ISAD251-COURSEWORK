﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Mvc;
using MyShop.Models;
using System.Data.Entity;
using MyShop.DAL;

namespace MyShop.Controllers
{
    public class ProductController : Controller
    {
        private ShopContext db = new ShopContext();
        // GET: Product
        public ActionResult Index(int? categoryID)
        {
            if( categoryID == null)
            {
                var products = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now).Include(p => p.ProductCategories).ToList();

                return View(products.ToList());
            } 
            else
            {
                var products = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now && s.CategoryID == categoryID).Include(p => p.ProductCategories).ToList();

                if( products == null)
                {
                    return RedirectToAction("Index");
                }

                return View(products.ToList());
            }
        }

        // GET: Product/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            } 
            else
            {
                int categoryID = product.ProductCategories.CategoryID;
                var relatedProducts = db.products.Where(p => p.CategoryID == product.CategoryID && p.ProductID != id && p.SalesPeriodStartAt <= DateTime.Now && p.SalesPeriodEndAt >= DateTime.Now).Take(4).ToList();
                ViewBag.Details = product;
                ViewBag.RelatedProducts = relatedProducts;
            }
            return View();
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Product/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Product/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Product/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Product/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Product/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Save(string FirstName, string LastName)
        {
            return Json(new { FirstName = FirstName, LastName = LastName});
        }
    }
}