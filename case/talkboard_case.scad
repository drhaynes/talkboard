use <talkboard_case_bottom.scad>;
use <talkboard_case_top.scad>;


// Render quality configuration
// ============================
// Minimum angle for fragment. Set to lower for higher quality. Min is 0.01.
// Suggested value for working: 10
// Suggested vlaue for rendering: 0.5
$fa = 10;
// Minimum size of fragment. Set to lower for higher quality.
// Only applicable is $fa is low, so can be mostly left alone at 0.1.
$fs = 0.1;


// Create the actual case
length = 106;
width = 44;
depth = 33;
wall_thickness = 2;
padding_for_walls = wall_thickness * 2;

visual_spacing = 20;

// M3 bolt & nut dimensions


color("#b8c7f5") {
   bottom_case(length = length + padding_for_walls,
               width = width + padding_for_walls,
               depth = depth + wall_thickness,
               wall_thickness = wall_thickness);
}

color("#f6f6f6") {
   translate([0, 0, depth + visual_spacing]) {
      top_case(length = length + padding_for_walls,
               width = width + padding_for_walls,
               depth = wall_thickness,
               wall_thickness = wall_thickness);
   }
}
