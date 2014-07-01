priviametrics is a Javascript module that exposes a single function:

```javascript
priviametrics.track(name, {property_1: "some value"}, {property_2: "some other value"});
```

To start logging events from your site to Priviametrics follow these steps:

1) In the <head> section of your web page include this JavaScript file.
For example

```html
   <head>
       <script src="//priviametrics.herokuapp.com/public/assets/priviametrics.js"></script>
       ...other tags...
   </head>
```

2) Call the priviametrics.track() function when appropriate.
Some examples:
    On a sale - Let's assume you want to save a sale event on your website.
      On the sale confirmation page you could call the priviametrics.track method
      and pass in the sale amount information.

```javascript
           JavaScript
             document.onreadystatechange = function () {
                if (document.readyState == "complete") {
                 var order_amount = 130;
                 var order_quantity = 5;
                 priviametrics.track('SALE', order_amount, order_quantity);
                }};

            JQuery
            $(document).ready(function() {
                 var order_amount = 130;
                 var order_quantity = 5;
                 priviametrics.track('SALE', order_amount, order_quantity);
            });
```

Perhaps you want to track when a user clicks the Checkout button on your site.
Let's assume the button has an ID #checkout and the order total and order quantity
are input fields with ID's of #total and #quantity respectively.
You can assign the priviametrics.track() method
to the click event of the button and pass in the current values of #total and #quantity.

Here are a few ways you can do that.

```javascript
            JavaScript
            document.onreadystatechange = function () {
                if (document.readyState == "complete") {
                    document.getElementById("checkout").onclick = function () {
                        priviametrics.track('CHECKOUT',
                            {property_1: document.getElementById('total').value},
                            {property_2: document.getElementById('quantity').value}
                        );
                    }
                }
            };
```

Or with JQuery

```javascript
            JQuery
            $(document).ready(function() {
                $("#checkout").on("click", function() {
                    priviametrics.track('CHECKOUT', {property_1: $('#total').val()}, {property_2: $('#quantity').val()});
                });
            });
```
