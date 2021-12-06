
// Creates a top case for a grid of pressable buttons
module button_hole_grid(buttons = 10,           // how many buttons?
                        rows = 2,               // number of rows the buttons should be arranged in.
                        button_radius = 5.5,    // Exact radius of pressable part of buttons.
                        button_spacing = 17.5,  // centre-to-centre distance of buttons (17.5 is std for pcb buttons).
                        edge_margin_above = 4,  // how much space around the edge of the buttons?
                        edge_margin_below = 4,
                        edge_margin_before = 4,
                        edge_margin_after = 4,
                        thickness = 3) {        // how thick should the case be?
    nudge = 0.75; // to ensure buttons fit in holes
    hole_radius = button_radius + nudge;
    epsilon = 0.001; // to ensure CSG subtraction works ok

    hole_diameter = 2 * hole_radius;
    button_count_per_row = buttons / rows;
    column_space_count = button_count_per_row - 1;

    row_space_count = rows - 1;
    row_width = button_spacing;
    case_width = hole_diameter + (row_space_count * button_spacing) + (edge_margin_above + edge_margin_below);
    case_length = (column_space_count * button_spacing)
                + hole_diameter
                + (edge_margin_before + edge_margin_after);

    difference() {
        cube([case_length, case_width, thickness]);
        // Move to first button hole position
        translate([(edge_margin_before + button_radius), edge_margin_below + button_radius, -epsilon]) {
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

module top_case(thickness = 1.2, speaker_diameter = 40, grill_edge_margin = 2) {
    epsilon = 0.01; // to ensure CSG subtraction works ok
    speaker_radius = speaker_diameter / 2;
    
    difference() {
        button_hole_grid (
            buttons = 6,
            rows = 2,
            edge_margin_above = 7.5,
            edge_margin_below = 6.5,
            edge_margin_before = 50,
            edge_margin_after = 10,
            thickness = thickness
        );
        translate([speaker_radius + grill_edge_margin, speaker_radius + grill_edge_margin, -epsilon]) {
            cylinder(h = 1.5 * thickness, r = speaker_radius);
        }
    }
}

top_case();
