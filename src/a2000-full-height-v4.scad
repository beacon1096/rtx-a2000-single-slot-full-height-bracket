// User confirmed v4 chassis installation; v3 ports and GPU screws also fitted.
// Verified on one PETG build; long-term thermal and mechanical durability untested.
// GPU mounting and connector geometry derived from mr4lexndr:
// https://makerworld.com/en/models/2000710 (BY-NC-SA, embedded 3MF metadata).
// Adaptation by beacon1096: full-height single-slot PETG bracket v4, 2026-11-06.
// Chassis outline follows selected PCIe CEM 3.0 Fig. 9-5 dimensions;
// polymer thickness and unmeasured placement are prototype assumptions.

/* [Fit adjustments, mm] */
// 43.04 measured to metal opening edge; 4.4 is only a provisional half-width.
top_port_center = 47.44;
height_adjust_mm = 0;
// Positive offset increases the distance from the chassis ear to the port row.
pattern_shift_x_mm = 0;
chassis_shift_y_mm = 0;
panel_y_min = chassis_shift_y_mm;
panel_width = 18.42;
panel_thickness = 1.0;
// Preserve the successful card-to-inner-panel distance while thinning toward the case.
reference_panel_thickness = 2.4;
gpu_depth_shift = panel_thickness-reference_panel_thickness;
port_chamfer_depth = min(0.4,panel_thickness);
mount_hole_diameter = 2.2;
// Keep the PCB-contact face at Y=17.2 while recovering screw engagement.
screw_seat_thickness = 1.0;
head_recess_diameter = 5.0;
// Release possible PCB/component contact; keep the proven screw locating faces.
gpu_card_relief = 0.3;
locating_pad_radius = 3.5;
// A through-window clears locator posts and solder legs without guessing their height.
clearance_window_x = [15,65];
clearance_window_z = [5,18];
clearance_window_radius = 1;
edge_rib_depth = 0;
port_clearance = 0;
// Latch dimensions are photo-based trial clearances, not measured hardware.
latch_width = 7.2;
latch_height = 1.8;
latch_y_center = 6.5;
latch_bridge_thickness = min(1.2,panel_thickness);
latch_corner_radius = 0.3;
/* [Chassis] */
bracket_height = 120.02 + height_adjust_mm;
tongue_thickness = 1.0;
tongue_thin_length = 20;
top_ear_thickness = 1.0;
top_ear_depth = 11.43;
/* [Output] */
// Edge-down print orientation requires supports under the GPU mounting flange.
print_orientation = true;
$fn = 64;
eps = 0.02;
assert(port_chamfer_depth > 0 && port_chamfer_depth <= panel_thickness);
assert(tongue_thickness <= panel_thickness);
assert(clearance_window_z[1] <= 22-locating_pad_radius);
assert(clearance_window_z[0] >= 4.2);
assert(clearance_window_x[0] > 8.1 && clearance_window_x[1] < 70.7);
assert(gpu_card_relief >= 0 && gpu_card_relief <= 0.5);
assert(tongue_thin_length > 0 && tongue_thin_length < bracket_height);
assert(screw_seat_thickness > 0 && screw_seat_thickness <= 2);
assert(latch_bridge_thickness > 0 && latch_bridge_thickness <= panel_thickness);
// Printed v1 confirmed the connector-edge end is the tongue end.
top_x = 20.8 - top_port_center - pattern_shift_x_mm;
ymax = panel_y_min + panel_width;
flange_profile = [[59.255, 26.5499], [59.7, 26.6], [68.7, 26.6], [69.1451, 26.5499], [69.5678, 26.4019], [69.947, 26.1637], [70.2637, 25.847], [70.5019, 25.4678], [70.6499, 25.045], [70.7, 24.6], [70.7, 2.8], [8.1, 2.8], [8.1, 24.6], [8.1505, 25.0466], [8.2995, 25.4707], [8.4867, 25.7687], [8.5394, 25.8508], [8.8582, 26.1677], [9.2397, 26.4054], [9.6646, 26.5519], [10.1, 26.6], [15.7, 26.6], [16.145, 26.5499], [16.5678, 26.4019], [16.947, 26.1637], [17.2637, 25.847], [17.5019, 25.4678], [17.6499, 25.045], [17.7, 24.6], [17.7, 19.2142], [17.6659, 18.9554], [17.566, 18.7142], [17.4071, 18.5071], [15.5929, 16.6929], [15.434, 16.4858], [15.3341, 16.2446], [15.3, 15.9858], [15.3, 13.0], [15.3341, 12.7412], [15.434, 12.5], [15.5929, 12.2929], [15.8, 12.134], [16.0412, 12.0341], [16.3, 12.0], [56.7, 12.0], [56.9588, 12.0341], [57.2, 12.134], [57.4071, 12.2929], [57.566, 12.5], [57.6659, 12.7412], [57.7, 13.0], [57.7, 24.6], [57.7501, 25.045], [57.8981, 25.4678], [58.1363, 25.847], [58.453, 26.1637], [58.8322, 26.4019], [59.255, 26.5499]];
port_profile = [[3.56638, -2.97809], [3.4, -3.0], [-3.4, -3.0], [-3.65882, -2.96592], [-3.9, -2.86602], [-4.10711, -2.7071], [-4.26603, -2.5], [-4.36593, -2.25882], [-4.4, -2.0], [-4.4, 1.80001], [-3.0, 3.0], [3.0, 3.0], [4.4, 1.80001], [4.4, -2.0], [4.36593, -2.25882], [4.26603, -2.5], [4.10711, -2.7071], [3.9, -2.86602], [3.65882, -2.96592], [3.56638, -2.97809]];

module port2d(extra=0) {
    offset(delta=extra) polygon(port_profile);
}
module ports() {
    for (x=[20.8,33.5,46.2,58.9]) {
        translate([x,11.4,-eps]) linear_extrude(panel_thickness+2*eps)
            port2d(port_clearance);
        intersection() {
            hull() {
                translate([x,11.4,-eps]) linear_extrude(eps)
                    port2d(port_clearance+0.6);
                translate([x,11.4,port_chamfer_depth]) linear_extrude(eps)
                    port2d(port_clearance);
            }
            translate([x-10,8.2,-eps]) cube([20,20,panel_thickness+2*eps]);
        }
    }
}
module chassis_outline() {
    polygon([
        [top_x,panel_y_min],
        [top_x,ymax],
        [top_x+bracket_height-11.39,ymax],
        [top_x+bracket_height-7.27,panel_y_min+14.30],
        [top_x+bracket_height-1,panel_y_min+14.30],
        [top_x+bracket_height,panel_y_min+13.30],
        [top_x+bracket_height,panel_y_min+5.11],
        [top_x+bracket_height-1,panel_y_min+4.11],
        [top_x+bracket_height-7.27,panel_y_min+4.11],
        [top_x+bracket_height-11.38,panel_y_min]
    ]);
}
module faceplate() {
    linear_extrude(panel_thickness) chassis_outline();
}
module gpu_relief_cut() {
    difference() {
        translate([8.1-eps,17.2-eps,2-eps])
            cube([62.6+2*eps,gpu_card_relief+eps,24.6+2*eps]);
        for(x=[13.7,61.7]) translate([x,20,22]) rotate([90,0,0])
            cylinder(h=4,r=locating_pad_radius);
    }
}
module hardware_window() {
    translate([clearance_window_x[0]+clearance_window_radius,20,
               clearance_window_z[0]+clearance_window_radius]) rotate([90,0,0])
        linear_extrude(4)
            offset(r=clearance_window_radius)
                square([clearance_window_x[1]-clearance_window_x[0]-2*clearance_window_radius,
                        clearance_window_z[1]-clearance_window_z[0]-2*clearance_window_radius]);
}
module gpu_flange() {
    difference() {
        union() {
            translate([0,19.2,0]) rotate([90,0,0])
                linear_extrude(2) polygon(flange_profile);
            // A straight root avoids the former brace protruding into the card side.
            translate([8.1,17.2,2]) cube([62.6,2,2.2]);
        }
        if(gpu_card_relief > 0) gpu_relief_cut();
        hardware_window();
        for(x=[13.7,61.7]) {
            translate([x,20,22]) rotate([90,0,0])
                cylinder(h=4,d=mount_hole_diameter);
            translate([x,19.2+eps,22]) rotate([90,0,0])
                cylinder(h=2-screw_seat_thickness+eps,d=head_recess_diameter);
        }
    }
}
module chassis_ear() {
    difference() {
        translate([top_x,panel_y_min,-top_ear_depth])
            cube([top_ear_thickness,21.59,panel_thickness+top_ear_depth]);
        // Open screw notch points toward the extended transverse edge.
        translate([top_x-eps,ymax,-5.08]) rotate([0,90,0])
            cylinder(h=top_ear_thickness+2*eps,r=2.3);
        translate([top_x-eps,ymax,-7.38])
            cube([top_ear_thickness+2*eps,3.17+eps,4.6]);
    }
}
module vents(xs=[13:7:76]) {
    for(x=xs) translate([x,2.7,-eps])
        linear_extrude(panel_thickness+2*eps)
            offset(r=0.6) square([4.3,1.4],center=true);
}
module latch_clearance() {
    for(x=[20.8,33.5,46.2,58.9]) {
        translate([x,latch_y_center,-eps]) linear_extrude(panel_thickness+2*eps)
            offset(r=latch_corner_radius)
                square([latch_width-2*latch_corner_radius,
                        latch_height-2*latch_corner_radius],center=true);
        // A 1 mm panel already has the required latch landing thickness.
        if(latch_bridge_thickness < panel_thickness) translate([x-latch_width/2,latch_y_center+latch_height/2-eps,latch_bridge_thickness])
            cube([latch_width,8.4-latch_y_center-latch_height/2+2*eps,
                  panel_thickness-latch_bridge_thickness+eps]);
    }
}
module thin_tongue_cut() {
    translate([top_x+bracket_height-tongue_thin_length,-1,tongue_thickness])
        cube([tongue_thin_length+eps,24,30]);
}
module bracket() {
    difference() {
      union() {
        faceplate();
        translate([0,0,gpu_depth_shift]) gpu_flange();
        chassis_ear();
        if(edge_rib_depth > panel_thickness)
            translate([top_x+5.66,panel_y_min,0])
                cube([min(95,bracket_height-tongue_thin_length-5.66),1.2,edge_rib_depth]);
      }
      ports();
      latch_clearance();
      vents();
      thin_tongue_cut();
    }
}
if(print_orientation)
    translate([-top_x,26.6+gpu_depth_shift,-min(0,panel_y_min)]) rotate([90,0,0]) bracket();
else
    bracket();
