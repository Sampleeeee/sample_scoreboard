$(function () {
    const convert = {
        [0]: 'start',
        [1]: 'center',
        [2]: 'end'
    };

    window.addEventListener('message', function (event) {
        var item = event.data;
        var buf = $('#wrap');
        buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Name</th><th>Rank</th></tr>");
        if (item.meta && item.meta == 'close') {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});