$(document).ready(function() {

    var event_lines=[];
    for(var key in $('#chart').data('events')) {
        if (key % 7 === 0) {
            event_lines.push($('#chart').data('events')[key].created_at);
        }
    };

    var graph = new Morris.Line({
        // ID of the element in which to draw the chart.
        element: 'chart',
        // Chart data records -- each entry in this array corresponds to a point on
        // the chart.
        data: $('#chart').data('events'),
        // The name of the data record attribute that contains x-values.
        xkey: 'created_at',
        // A list of names of data record attributes that contain y-values.
        ykeys: ['property_1', 'property_2'],
        // Labels for the ykeys -- will be displayed when you hover over the
        // chart.
        labels: ['Property 1', 'Property 2'],
        xLabelFormat: function(d) {
            var curr_date = d.getDate();
            var curr_month = d.getMonth() + 1;
            var curr_year = d.getFullYear();
            return (curr_month + "-" + curr_date + "-" + curr_year)
        },
        xLabelAngle: 45,
        events: event_lines,
        eventStrokeWidth: 1

    });
});
