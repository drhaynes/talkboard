
use <../../openscad_modules/primitives/lib.scad>;

// Creates a grid of cylinders for cutting out a matrix of holes (e.g. for pushbuttons)
module hole_grid(holes = 10,             // how many holes?
                 rows = 2,               // number of rows the buttons should be arranged in.
                 hole_radius = 5.5,      // Set this to the exact radius (e.g. of pressable part of buttons).
                 hole_spacing = 17.5,    // centre-to-centre distance of buttons (17.5 is std for pcb buttons).
                 height = 3) {        // how tall should the cylinders for the hole be?
   nudge = 0.75; // to ensure buttons fit in holes
   adjusted_hole_radius = hole_radius + nudge;
   epsilon = 0.001; // to ensure CSG subtraction works ok

   hole_diameter = 2 * adjusted_hole_radius;
   hole_count_per_row = holes / rows;
   column_space_count = hole_count_per_row - 1;

   row_space_count = rows - 1;
   row_width = hole_spacing;

   difference() {
      // Move to first hole position
      translate([adjusted_hole_radius, adjusted_hole_radius, - epsilon]) {
         for (row = [0:1:rows - 1]) {
            // Calculate row position
            translate([0, (row * row_width), 0]) {
               for (hole = [0:1:hole_count_per_row - 1]) {
                  // Calculate hole position
                  translate([(hole_spacing * hole), 0, 0]) {
                     cylinder(h = height, r = adjusted_hole_radius, center = true);
                  }
               }
            }
         }
      }
   }
}

module speaker_grill_round(radius = 20,
                           aperture_radius = 1.0,
                           aperture_spacing = 3,
                           depth = 2) {
   intersection() {
      for (x = [-radius:aperture_spacing:radius]) {
         for (y = [-radius:aperture_spacing:radius]) {
            translate([x, y, 0]) {
               cylinder(h = depth, r = aperture_radius);
            }
         }
      }
      cylinder(h = depth, r = radius);
   }
}

module top_case(length = 100,
                width = 60,
                wall_thickness = 2,
                depth = 1.2,
                corner_radius = 4,
                speaker_grill_radius = 20,
                speaker_grill_edge_margin = 2) {

   epsilon = 0.01; // to ensure CSG subtraction works ok
   size_padding = wall_thickness * 2;

   difference() {
      // basic shape
      rounded_rect(length = length + size_padding, width = width + size_padding, thickness = depth);

      // button matrix
      translate([50, 7.5, 0]) {
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
