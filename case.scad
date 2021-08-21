
// Customisable parameters

button_count = 5; // how many buttons?
button_radius = 5.5; // radius of pressable part of button
button_spacing = 17; // centre-to-centre distance of buttons

case_edge_margin = 4; // how much space around the edge of the buttons?
case_depth = 3; // how thick should the case be?


// Derived & constant parameters

nudge = 0.75; // to ensure buttons fit in holes
hole_radius = button_radius + nudge;
epsilon = 0.001; // to ensure CSG subtraction works ok

hole_diameter = 2 * hole_radius;
space_count = button_count - 1;

case_width = hole_diameter + (2 * case_edge_margin);
case_length = (space_count * button_spacing)
            + hole_diameter
            + (2 * case_edge_margin);

difference() {
    cube([case_length, case_width, case_depth]);
    translate([(case_edge_margin + button_radius), case_width / 2, -epsilon]) {
        translate([0, 0, 0]) {
            for(button = [0:1:button_count-1]) {
                translate([(button_spacing * button), 0, 0]) {
                    cylinder(h = 3 * case_depth, r = hole_radius, center = true);
                }
            }
        }
    }
}