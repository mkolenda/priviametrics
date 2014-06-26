// priviametrics is a Javascript module that exposes a single function:
//
//     priviametrics.track(name, {property_1: "some value"}, {property_2: "some other value"});
//
// To start logging events from your site to Priviametrics follow these steps:
//
// 1) In the <head> section of your web page include this JavaScript file.
// For example
//   <head>
//       <script src="//priviametrics.herokuapp.com/public/assets/priviametrics.js"></script>
//       ...other tags...
//   </head>
//
// 2) Call the priviametrics.track() function when appropriate.
// Some examples:
//    On a sale - Let's assume you want to save a sale event on your website.
//      On the sale confirmation page you could call the priviametrics.track method
//      and pass in the sale amount information.
//
//           JavaScript
//             document.onreadystatechange = function () {
//                if (document.readyState == "complete") {
//                 var order_amount = 130;
//                 var order_quantity = 5;
//                 priviametrics.track('SALE', order_amount, order_quantity);
//                }};

//            JQuery
//            $(document).ready(function() {
//                 var order_amount = 130;
//                 var order_quantity = 5;
//                 priviametrics.track('SALE', order_amount, order_quantity);
//            });

//  Perhaps you want to track when a user clicks the Checkout button on your site.
//  Let's assume the button has an ID #checkout and the order total and order quantity
//  are input fields with ID's of #total and #quantity respectively.
//  You can assign the priviametrics.track() method
//  to the click event of the button and pass in the current values of #total and #quantity.
//
//  Here are a few ways you can do that.
//
//            JavaScript
//            document.onreadystatechange = function () {
//                if (document.readyState == "complete") {
//                    document.getElementById("checkout").onclick = function () {
//                        priviametrics.track('CHECKOUT',
//                            {property_1: document.getElementById('total').value},
//                            {property_2: document.getElementById('quantity').value}
//                        );
//                    }
//                }
//            };
//
//
//            JQuery
//            $(document).ready(function() {
//                $("#checkout").on("click", function() {
//                    priviametrics.track('CHECKOUT', {property_1: $('#total').val()}, {property_2: $('#quantity').val()});
//                });
//            });

var priviametrics = (function () {
    var my = {};
    _pm_event = {};

    my.track = function(name, arg_1, arg_2) {
            _pm_event.name = name;
            _pm_event.property_1 = arg_1.property_1;
            _pm_event.property_2 = arg_2.property_2;

            _send_data();
    };

    function _send_data() {
        _pm_request = new XMLHttpRequest();
        _pm_request.open("POST", "http://localhost:3000/events.json", true);
        _pm_request.setRequestHeader('Content-Type', 'application/json');
        _pm_request.onreadystatechange = function () {
            // don't do anything here, we don't want to interfere with the behavior of the host site
        };
        _pm_request.send(JSON.stringify(_pm_event));
    };

    return my;
})();
