
use <../../openscad_modules/primitives/lib.scad>;
use <../../openscad_modules/fixtures/lib.scad>;

module bottom_case(length = 100,          // outer dimensions - not a great API, but ok for now
                   width = 60,            // ideally we'd want to specify inner dimensions... or at least
                   wall_thickness = 2,    // an option or alternative module for inner/outer.
                   depth = 20,
                   corner_radius = 4,
                   fixtures_inset = 5) {

   epsilon = 0.01; // to ensure CSG subtraction works ok

   difference() {
      // Basic shape:
      rounded_rect(length = length,
                   width = width,
                   thickness = depth,
                   corner_radius = corner_radius);

      // Internal cutout:
      inner_offset = 2 * wall_thickness;
      // The inner radius is calculated to maintain constant wall thickness.
      inner_radius = corner_radius - (wall_thickness / 2);
      translate([wall_thickness, wall_thickness, wall_thickness+1]) {
         rounded_rect(length = length - inner_offset,
         width = width - inner_offset,
         thickness = depth,
         corner_radius = inner_radius);
      }

      // Bolt fixturess
      boss_depth = depth / 2;
      bottom_hole_depth = 5;

      translate([fixtures_inset, fixtures_inset, bottom_hole_depth]) {
         rotate([0, 180, 0]) {
            hex_nut_hole_m3(hole_depth = 6);
         }
      }
      translate([length - fixtures_inset, fixtures_inset, bottom_hole_depth]) {
         rotate([0, 180, 0]) {
            hex_nut_hole_m3(hole_depth = 6);
         }
      }
      translate([length - fixtures_inset, width - fixtures_inset, bottom_hole_depth]) {
         rotate([0, 180, 0]) {
            hex_nut_hole_m3(hole_depth = 6);
         }
      }
      translate([fixtures_inset, width - fixtures_inset, bottom_hole_depth]) {
         rotate([0, 180, 0]) {
            hex_nut_hole_m3(hole_depth = 6);
         }
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
bottom_case(length = 102, width = 40, depth = 20, wall_thickness = 2);
