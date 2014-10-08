// JS constants.
var GRAPH_ID = '#graph';  // the HTML div for d3 to draw in.

// Called when everything is fully loaded.
$(document).ready(function() {
  // Load the group data from the empty div.
  data = $('.group_data').data('groups');
  console.log(data);
  draw_graph(GRAPH_ID, data);
});

function draw_graph(where_to_draw, data_to_draw) {
  var w = 900;
  var h = 400;

  var circleWidth = 5;

  var fontFamily = 'Bree Serif';
  var fontSizeHighlight = '1.5em';
  var fontSizeNormal = '1em';

  var palette = {
        "lightgray": "#819090",
        "gray": "#708284",
        "mediumgray": "#536870",
        "darkgray": "#475B62",

        "darkblue": "#0A2933",
        "darkerblue": "#042029",

        "paleryellow": "#FCF4DC",
        "paleyellow": "#EAE3CB",
        "yellow": "#A57706",
        "orange": "#BD3613",
        "red": "#D11C24",
        "pink": "#C61C6F",
        "purple": "#595AB7",
        "blue": "#2176C7",
        "green": "#259286",
        "yellowgreen": "#738A05"
  };

  var nodes = [];
  var links = [];
  for (var row = 0; row < data_to_draw.length; row++) {
    var col;
    var row_index = row * data_to_draw.length;
    for (col = 0; col < data_to_draw[row].length; col++) {
      nodes[row_index + col] = {"name": data_to_draw[row][col]};
    }

    for (col = 0; col < data_to_draw[row].length; col++) {
      var other_col;
      for (other_col = 0; other_col < data_to_draw[row].length; other_col++) {
        if (other_col == col) continue;
        links.push({source: nodes[row_index + col],
                    target: nodes[row_index + other_col]});
      }
    }
  }

  var vis = d3.select(where_to_draw)
        .append("svg:svg")
        .attr("class", "stage")
        .attr("width", w)
        .attr("height", h);

  var force = d3.layout.force()
      .nodes(nodes)
      .links([])
      .gravity(0.1)
      .charge(-1000)
      .size([w, h]);

   var link = vis.selectAll(".link")
          .data(links)
          .enter().append("line")
          .attr("class", "link")
          .attr("stroke", "#CCC")
          .attr("fill", "none");

   var node = vis.selectAll("circle.node")
        .data(nodes)
        .enter().append("g")
        .attr("class", "node")

        //MOUSEOVER
        .on("mouseover", function(d,i) {
          if (i>0) {
            //CIRCLE
            d3.select(this).selectAll("circle")
            .transition()
            .duration(250)
            .style("cursor", "none")
            .attr("r", circleWidth+3)
            .attr("fill",palette.darkblue);

            //TEXT
            d3.select(this).select("text")
            .transition()
            .style("cursor", "none")
            .duration(250)
            .style("cursor", "none")
            .attr("font-size","1.5em")
            .attr("x", 15 )
            .attr("y", 5 );
          } else {
            //CIRCLE
            d3.select(this).selectAll("circle")
            .style("cursor", "none");

            //TEXT
            d3.select(this).select("text")
            .style("cursor", "none");
          }
        })

        //MOUSEOUT
        .on("mouseout", function(d,i) {
          if (i>0) {
            //CIRCLE
            d3.select(this).selectAll("circle")
            .transition()
            .duration(250)
            .attr("r", circleWidth)
            .attr("fill",palette.pink);

            //TEXT
            d3.select(this).select("text")
            .transition()
            .duration(250)
            .attr("font-size","1em")
            .attr("x", 8 )
            .attr("y", 4 );
          }
        })

        .call(force.drag);


      //CIRCLE
      node.append("svg:circle")
        .attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; })
        .attr("r", circleWidth)
        .attr("fill", function(d, i) {
          if (i>0) { return  palette.pink; }
          else { return palette.black; } } );

      //TEXT
      node.append("text")
        .text(function(d, i) { return d.name; })
        .attr("x",    function(d, i) { return circleWidth + 5; })
        .attr("y",            function(d, i) {
          if (i>0) { return circleWidth + 0; } else { return 8; } })
        .attr("font-family",  "Bree Serif")
        .attr("fill",         function(d, i) {  return  palette.black;  })
        .attr("font-size",    function(d, i) {  return  "1em"; })
        .attr("text-anchor",  function(d, i) {
          if (i>0) { return  "beginning"; } else { return "end"; } });


  force.on("tick", function(e) {
    node.attr("transform", function(d, i) {
          return "translate(" + d.x + "," + d.y + ")";
      });

     link.attr("x1", function(d)   { return d.source.x; })
         .attr("y1", function(d)   { return d.source.y; })
         .attr("x2", function(d)   { return d.target.x; })
         .attr("y2", function(d)   { return d.target.y; });
  });

  force.start();
}
