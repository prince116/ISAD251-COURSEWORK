using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using MyShop.DAL;
using MyShop.Models;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using MyShop.ViewModels;

namespace MyShop.Controllers
{
    public class ProductsController : ApiController
    {
        private ShopContext db = new ShopContext();

        // GET api/<controller>//public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}
        

        // GET api/<controller>/5
        public HttpResponseMessage Get(int id)
        {
            var record = db.products.FirstOrDefault(e => e.ProductID == id);

            if (record != null)
            {
                ProductViewModels product = new ProductViewModels();
                product.ProductId = record.ProductID;
                product.ProductName = record.ProductName;
                product.ProductDescription = record.ProductDescription;
                product.Price = record.Price;
                product.DiscountedPrice = record.DiscountedPrice;

                var response = new HttpResponseMessage(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(product));
                response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record With ID " + id.ToString() + " not found");
            }
        }

        // POST api/<controller>
        [ValidateAntiForgeryToken]
        public HttpResponseMessage Post([FromBody]Product product)
        {
            try
            {
                product.CreatedAt = DateTime.Now;
                product.LastModifiedAt = DateTime.Now;
                db.products.Add(product);
                db.SaveChanges();

                // Return record has been created status
                return Request.CreateResponse(HttpStatusCode.Created, "Record has been created."); ;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        // PUT api/<controller>/5
        [ValidateAntiForgeryToken]
        public HttpResponseMessage Put(int id, [FromBody]Product product)
        {
            try
            {
                var record = db.products.FirstOrDefault(e => e.ProductID == id);

                if (record == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record with ID " + id + " not found to update");
                }
                else
                {
                    record.ProductName = product.ProductName;
                    record.ProductDescription = product.ProductDescription;
                    record.CategoryID = product.CategoryID;
                    record.Price = product.Price;
                    record.DiscountedPrice = product.DiscountedPrice;
                    record.SalesPeriodStartAt = product.SalesPeriodStartAt;
                    record.SalesPeriodEndAt = product.SalesPeriodEndAt;
                    record.StockQuantity = product.StockQuantity;
                    record.LastModifiedAt = DateTime.Now;

                    db.SaveChanges();

                    return Request.CreateResponse(HttpStatusCode.OK, "Record with ID " + id.ToString() + " has been updated");
                }


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete(int id)
        {
            try
            {
                var record = db.products.FirstOrDefault(e => e.ProductID == id);

                if (record == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record with ID " + id.ToString() + " not found to delete");
                }
                else
                {
                    db.products.Remove(record);
                    db.SaveChanges();
                    return Request.CreateResponse(HttpStatusCode.OK, "Record with ID " + id.ToString() + " has been deleted");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }
    }
}