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




