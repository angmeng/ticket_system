
// ******************************** VISITS  ********************************************
$(function () {
    var datasets = {
        "Vessel 1": {
            label: "Vessel 1",
            data: [[1, 290], [2, 300], [3, 450], [4, 303], [5, 420], [6, 110], [7, 250]]
        },        
        "Vessel 2": {
            label: "Vessel 2",
            data: [[1, 432], [2, 54], [3, 644], [4, 433], [5, 566], [6, 664], [7, 555]]
        },
        "Vessel 3": {
            label: "Vessel 3",
            data: [[1, 754], [2, 134], [3, 555], [4, 333], [5, 433], [6, 433], [7, 455]]
        },
        "Vessel 4": {
            label: "Vessel 4",
            data: [[1, 454], [2, 363], [3, 746], [4, 144], [5, 233], [6, 233], [7, 344]]
        }
      
    };

    // hard-code color indices to prevent them from shifting as
    // countries are turned on/off
    var i = 0;
    $.each(datasets, function(key, val) {
        val.color = i;
        ++i;
    });
    
    // insert checkboxes 
    var choiceContainer = $("#choices");
    $.each(datasets, function(key, val) {
        choiceContainer.append('<input type="checkbox" style="float:left;margin-left:5px" name="' + key +
                               '" checked="checked" id="id' + key + '">' +
                               '<label style="float:left; margin:0 15px 5px; color:#777777;" for="id' + key + '">'
                                + val.label + '</label>');
    });
    choiceContainer.find("input").click(plotAccordingToChoices);

    
    function plotAccordingToChoices() {
        var data = [];

        choiceContainer.find("input:checked").each(function () {
            var key = $(this).attr("name");
            if (key && datasets[key])
                data.push(datasets[key]);
        });

        if (data.length > 0)
            $.plot($("#placeholder"), data, {
                yaxis: { min: 0, },
                xaxis: { tickDecimals: 0 }
            });
    }

    plotAccordingToChoices();


// *********************************** Earning *******************************************

  $(function () {

    // data
    var data = [
        { label: "Vessel 1",  data: 50},
        { label: "Vessel 2",  data: 30},
        { label: "Vessel 3",  data: 90},
        { label: "Vessel 4",  data: 70},
        { label: "Vessel 5",  data: 80},
        { label: "Vessel 6",  data: 110}
    ];
    /*var data = [
        { label: "Series1",  data: [[1,10]]},
        { label: "Series2",  data: [[1,30]]},
        { label: "Series3",  data: [[1,90]]},
        { label: "Series4",  data: [[1,70]]},
        { label: "Series5",  data: [[1,80]]},
        { label: "Series6",  data: [[1,0]]}
    ];*/
  /*  var data = [];
    var series = Math.floor(Math.random()*10)+1;
    for( var i = 0; i<series; i++)
    {
        data[i] = { label: "200"+(i+1), data: Math.floor(Math.random()*100)+1 }
    } */
       $.plot($("#earning"), data,
{
        series: {
            pie: {
                show: true,
                radius: 1,
                label: {
                    show: true,
                    radius: 2/3,
                    formatter: function(label, series){
                        return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
                    },
                    threshold: 0.1
                }
            }
        },
        legend: {
            show: false
        }
});
    
    });

});

