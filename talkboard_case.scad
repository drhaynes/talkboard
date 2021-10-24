
// Creates a top case for a grid of pressable buttons
module button_hole_grid(buttons = 10,        // how many buttons?
                        rows = 2,            // number of rows the buttons should be arranged in.
                        button_radius = 5.5, // Exact radius of pressable part of buttons.
                        button_spacing = 17, // centre-to-centre distance of buttons.
                        edge_margin = 4,     // how much space around the edge of the buttons?
                        thickness = 3) {     // how thick should the case be?
    nudge = 0.75; // to ensure buttons fit in holes
    hole_radius = button_radius + nudge;
    epsilon = 0.001; // to ensure CSG subtraction works ok

    hole_diameter = 2 * hole_radius;
    button_count_per_row = buttons / rows;
    column_space_count = button_count_per_row - 1;

    row_space_count = rows - 1;
    row_width = button_spacing;
    case_width = hole_diameter + (row_space_count * button_spacing) + (edge_margin * 2);
    case_length = (column_space_count * button_spacing)
                + hole_diameter
                + (2 * edge_margin);

    difference() {
        cube([case_length, case_width, thickness]);
        // Move to first button hole position
        translate([(edge_margin + button_radius), edge_margin + button_radius, -epsilon]) {
            for(row = [0:1:rows-1]) {
                // Calculate row position
                translate([0, (row * row_width), 0]) {
                    for(button = [0:1:button_count_per_row-1]) {
                        // Calculate button position
                        translate([(button_spacing * button), 0, 0]) {
                            cylinder(h = 3 * thickness, r = hole_radius, center = true);
                        }
                    }
                }
            }
        }
    }
}

button_hole_grid();
