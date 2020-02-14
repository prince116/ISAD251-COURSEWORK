# ISAD251 - Database Application Development Coursework

# Getting Started

## Running Application

1. Clone the source code from GitHub to Desktop
2. Open the project file MyShop.sln (ISAD251-COURSEWORK > application > MyShop > MyShop.sln)
3. On the menu, click Tools > NuGet Package Manager > Package Manager Console
4. Enter command "update-database"
5. On the menu, click View > Server Explorer, expand the Data Connections
7. Right click on the DefaultConnection > New Query
8. Copy all SQL statements from the SQL file (ISAD251-COURSEWORK > SQL > ISAD251.sql)
9. Paste all SQL statements to the New Query tab and execute all SQL statements.
10. On the top menu, click Build > Clean Solution
11. You can run the application.

## YouTube Video for how to run the application
[https://youtu.be/ncrS5tlbLXI](https://youtu.be/ncrS5tlbLXI)

## Accounts
    Administrator
    - Email: admin@myshop.com
    - Password: Aa~11111111

    Customer
    - Email: prince@gmail.com
    - Password: Aa~11111111


# Application Fact Sheet

The application is written by ASP.NET MVC. There are 3 RESTful APIs implemented in the system such as product, order and contact. All the APIs are requested by Ajax because the HTML tag \<form> does not support PUT and DELETE methods. When you request the API by Ajax with POST, PUT and DELETE methods, you must provide the token for validation. The usage of the token is prevent CSRF (Cross-site request forgery).

The followings will explain how to use the application.

## FIVE key features:
-	Included filter and search function in the product page
-	Allow administrator to upload product image
-	Products can be made, updated and removed
-	Administrator can control the publish date and time of products
-	Responsive layout design compatible with mobile devices

## Screenshots

![Home](/documentation/screenshots/home.png?raw=true "Chrome")

Before you purchase our product, you must login to our website. For security reasons, the “Add to cart” button will be hidden if you are logged out.

![Register](/documentation/screenshots/register.png?raw=true "Chrome")

If this is your first time to visit our website, please click “Register” button on the top of the menu.

![Login](/documentation/screenshots/login.png?raw=true "Chrome")

Otherwise, please use your existing account to login our website.

![Product](/documentation/screenshots/products.png?raw=true "Chrome")

The product page includes filter and search function. For example, if you click snacks or drinks button, the relevant items will be shown in below section. If you enter any keyword into the search box, the relevant items will be shown in below section. If you want to check the details of the product, you can click the product image or product name to visit product details page. 

![Product Details](/documentation/screenshots/product_details.png?raw=true "Chrome")

Once you confirm to buy an item, you may select the quantity and click “Add to cart” button. The selected item will be added to your shopping cart.

![Cart](/documentation/screenshots/cart.png?raw=true "Chrome")

You can update the quantity of the product in your shopping cart. The total price will be updated immediately. You also can remove unwanted items. 

![Cart](/documentation/screenshots/cart_delivery.png?raw=true "Chrome")

Once the order is confirmed, you can click the “Procced to check out” button. You are required to choose to dine in or take away.

![Thank You](/documentation/screenshots/thank_you.png?raw=true "Chrome")

Finally, your order will be placed successfully.

![My Order](/documentation/screenshots/my_order.png?raw=true "Chrome")

If you want to check your purchase history, you can click "My Order" on the top menu. All purchase records will be shown in this page.

![My Order Details](/documentation/screenshots/my_order_details.png?raw=true "Chrome")

You can click “View Details” button to check your order details.

![About Us](/documentation/screenshots/about_us.png?raw=true "Chrome")

As a customer, you can read our website background in the “about us” page.

![Contact](/documentation/screenshots/contact.png?raw=true "Chrome")

You also can provide feedback to our website in contact page.

![Admin Panel](/documentation/screenshots/admin_panel.png?raw=true "Chrome")

In the admin panel, you can manage 3 sections, such as product, order and feedback.

![Product Management Home](/documentation/screenshots/admin_product_management_home.png?raw=true "Chrome")

In the home page of the product management. It is listing all products.

![Product Management Create](/documentation/screenshots/admin_product_management_create.png?raw=true "Chrome")

You can create product.

![Product Management Details](/documentation/screenshots/admin_product_management_details.png?raw=true "Chrome")

You can read product details.

![Product Management Edit](/documentation/screenshots/admin_product_management_edit.png?raw=true "Chrome")

You can edit product details.

![Order Management Home](/documentation/screenshots/admin_order_management_home.png?raw=true "Chrome")

For the order management, you can view customers’ orders. You can search the order by order ID or Filter the order by choosing user in the dropdown list.

![Order Management Details](/documentation/screenshots/admin_order_management_details.png?raw=true "Chrome")

You can click "View Details" to view the order details.

![Order Management Details](/documentation/screenshots/admin_feedback_management.png?raw=true "Chrome")

You may also want to read some feedbacks from our customers.

## YouTube Video of application

[https://www.youtube.com/watch?v=I6266765lsQ](https://www.youtube.com/watch?v=I6266765lsQ)

# Additional Resources Credit

**Libraries:**
- Mustache.js ([https://mustache.github.io/](https://mustache.github.io/))
- Bootstrap ([https://getbootstrap.com/docs/3.3/](https://getbootstrap.com/docs/3.3/))
- jQuery ([https://jquery.com/](https://jquery.com/))
- W3.css ([https://www.w3schools.com/w3css/w3css_downloads.asp](https://www.w3schools.com/w3css/w3css_downloads.asp))
- Gulp ([https://gulpjs.com/](https://gulpjs.com/))
- npm ([https://www.npmjs.com/](https://www.npmjs.com/))
- Sass ([https://sass-lang.com/](https://sass-lang.com/))
- pug ([https://pugjs.org/api/getting-started.html](https://pugjs.org/api/getting-started.html))

**Images and Wordings:**
- Freepik ([https://www.freepik.com/free-photos-vectors/coffee](https://www.freepik.com/free-photos-vectors/coffee))
- Unsplash ([https://unsplash.com/images/food/coffee](https://unsplash.com/images/food/coffee))
- Starbucks ([https://www.starbucks.co.uk/](https://www.starbucks.co.uk/))