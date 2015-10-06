// edit this stuff

can_radius = 4;
can_height = 2.5;
can_rim_depth = 0.2;
can_thickness = 0.05;

neck_thickness = 1;
neck_width = 3;
neck_length = 20;

pin_count = 4;
pin_length = 1;
pin_radius = 0.1;
pin_offset = 1;







// build can

module can_interior() {
    translate([0, 0, - can_height + neck_thickness - can_thickness])
        cylinder(can_height, can_radius - can_thickness, can_radius - can_thickness);
}
color("gray")
    difference() {
        difference() {
            translate([0, 0, neck_thickness - can_height])
                cylinder(can_height + can_rim_depth, can_radius, can_radius);
            translate([0, 0, neck_thickness + can_thickness])
                cylinder(can_rim_depth, can_radius - can_thickness, can_radius - can_thickness);
        };
        can_interior();
    }
 
    
 // build neck
    
 color("brown")
    translate([neck_width / -2, 0, 0])
        cube([neck_width, neck_length, neck_thickness]);
    intersection() {
        color("brown")
            translate([neck_width / - 2, -can_radius, 0])
                cube([neck_width, can_radius * 2, neck_thickness]);
        color("gray")
            can_interior();
    };


 // build pins
    
 pin_spacing = neck_width / (pin_count + 1);
 for (pin = [1 : pin_count]) {
     
    // pins on neck
    translate([pin_spacing * pin - neck_width / 2, neck_length - pin_spacing * pin * pin_offset - pin_spacing, neck_thickness / 2])
        cylinder(pin_length, pin_radius, pin_radius);
     
    // pins on can
    translate([pin_spacing * pin - neck_width / 2, -(can_radius - pin_spacing * 2), neck_thickness / 2])
        cylinder(pin_length, pin_radius, pin_radius);
 }
