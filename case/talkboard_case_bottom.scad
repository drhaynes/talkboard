
use <../../openscad_modules/primitives/lib.scad>;

module bottom_case(length = 100,
                   width = 60,
                   wall_thickness = 2,
                   depth = 20,
                   corner_radius = 4) {

   epsilon = 0.01; // to ensure CSG subtraction works ok

   difference() {
      // basic shape
      rounded_rect(length = length, width = width, thickness = depth);

      // internal cutout - TODO
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
bottom_case(length = 102, width = 40, depth = 20, wall_thickness = 2);
