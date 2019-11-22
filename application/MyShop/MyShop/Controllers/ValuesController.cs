using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MyShop.Models;
using System.Data.Entity;
using MyShop.DAL;

namespace MyShop.Controllers
{
    public class ValuesController : ApiController
    {
        private ShopContext db = new ShopContext();

        // GET api/<controller>
        public HttpResponseMessage Get()
        {
            var Contacts = db.contacts.ToList();
            return Request.CreateResponse(HttpStatusCode.OK, Contacts);
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(int id)
        {
            var record = db.contacts.FirstOrDefault(e => e.ID == id);

            if( record != null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, record);
            } 
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record With ID " + id.ToString() + " not found");
            }
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]Contact contact)
        {
            try
            {
                contact.CreateAt = DateTime.Now;
                contact.LastModifiedAt = DateTime.Now;
                db.contacts.Add(contact);
                db.SaveChanges();

                var message = Request.CreateResponse(HttpStatusCode.Created, contact);
                message.Headers.Location = new Uri(Request.RequestUri + contact.ID.ToString());

                return message;
            }
            catch(Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
            
        }

        // PUT api/<controller>/5
        public HttpResponseMessage Put(int id, [FromBody]Contact contact)
        {
            try
            {
                var record = db.contacts.FirstOrDefault(e => e.ID == id);

                if( record == null )
                {
                    return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record with ID " + id + " not found to update");
                }
                else
                {
                    record.FirstName = contact.FirstName;
                    record.LastName = contact.LastName;
                    record.Subject = contact.Subject;
                    record.Message = contact.Message;
                    record.Email = contact.Email;
                    record.LastModifiedAt = DateTime.Now;

                    db.SaveChanges();

                    return Request.CreateResponse(HttpStatusCode.OK, record);
                }


            }
            catch( Exception ex )
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }

        }

        // DELETE api/<controller>/5
        public HttpResponseMessage Delete(int id)
        {
            try
            {
                var record = db.contacts.FirstOrDefault(e => e.ID == id);

                if( record == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Record with ID " + id.ToString() + " not found to delete");
                }
                else
                {
                    db.contacts.Remove(record);
                    db.SaveChanges();
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
            }
            catch( Exception ex )
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }
    }
}