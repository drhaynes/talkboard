
use <../../openscad_modules/primitives/lib.scad>;
use <../../openscad_modules/case_design/lib.scad>;
use <../../openscad_modules/fixtures/lib.scad>;

module top_case(length = 100,
                width = 60,
                wall_thickness = 2,
                depth = 1.2,
                corner_radius = 4,
                speaker_grill_radius = 20,
                speaker_grill_edge_margin = 4,
                fixtures_inset = 5) {

   epsilon = 0.02; // to ensure CSG subtraction works ok
   size_padding = 0; //wall_thickness * 2;

   difference() {
      // basic shape
      rounded_rect(length = length + size_padding,
                   width = width + size_padding,
                   thickness = depth,
                   corner_radius = corner_radius);

      // button matrix
      translate([50, 9.5, 0]) {
         hole_grid(
         holes= 6,
         rows = 2,
         height = depth * 3
         );
      }

      // speaker grill
      speaker_pos = speaker_grill_radius + speaker_grill_edge_margin;
      translate([speaker_pos, speaker_pos, - epsilon]) {
         speaker_grill_round(radius = speaker_grill_radius, depth = depth * 2);
      }

      two_epsilon = 2 * epsilon;

      // bolt holes
      translate([fixtures_inset, fixtures_inset, -epsilon])
         countersunk_hole_m3(hole_depth = wall_thickness + two_epsilon);
      translate([fixtures_inset, width - fixtures_inset, -epsilon])
         countersunk_hole_m3(hole_depth = wall_thickness + two_epsilon);
      translate([length - fixtures_inset, fixtures_inset, -epsilon])
         countersunk_hole_m3(hole_depth = wall_thickness + two_epsilon);
      translate([length - fixtures_inset, width - fixtures_inset, -epsilon])
         countersunk_hole_m3(hole_depth = wall_thickness + two_epsilon);
   }
}

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
top_case(length = 102, width = 40, wall_thickness = 2);
