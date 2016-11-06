
///////////////////////////////////////////////////////
/////////////Simple Syringe Pump//////////////////////
//////////////////////////////////////////////////////


//////////////////This version is for a///////////////
/////////////Stepper Motor NEMA 17, 42x48mm, /////////


//////////////////////////////////////////////////
//variables:
// change these according to the parts you use
/////////////////////////////////////////////////

width = 54; //x overall, minimum = diagonal height of motor; check if motor fits into steelbars, often edges are rounded of, so you can be a little smaller
depth = 54; //y overall, minimum = diagonal height of motor
min_wallsize = 2; //minimum wallsize of parts
shaft_r = 3; //radius of shafts, in endpart, leadscrewpart, syringepart 
diameter_steelbar=2*shaft_r;
slip = 2; //'biggerness' of all other parts for movement of motor part, 2 means 1mm smaller on every side

//endstops: commented out here, remove '*' if you want to use endstops
endstopholes_r = 3; //radius of screws/shaft used for endstops
endstopholedistance = 20; //don't forget space for collets/nuts, >4*endstopholes_r
 

//specific variables syringepart
height_syringepart = 50; //z-height of part
syringe_r = 7; //syringe diameter of a 5mL syringe (the biggest we would ever use)

//specific variables leadscrew part
height_leadscrewpart = 9; //z-height of part, must fit to thread of leadscrewnut (max 10mm with our nuts)
nut_r = 4.75; // (dia=9.5mm) leadscrew-nut thread


//specific variables motor part
height_motorpart = 14; //z-height of part (should be corresponding to length of bearings LM6uu=18.8mm, or, as here, the length of motor screws available (-3mm to hold motor in firmly) 
bearing_r = 6; //radius of bearing, LM6UU=12mm dia
motor_r = 8; //radius of middle 'hole' of motor, big enough for screw-motor-connector
motor_r2 = 11.5; //radius of middle 'round' of motor, dia=15mm +1 extra, only more stylish, not really necessary (eg for slicing the part for lasercutting)

motor_screw_r = 1.5; //radius of screws that hold stepper in, 3mm diameter (M3)
motorscrew_length = 8; //effective length of screw to mount motor (length - 3mm to hold motor)
motor_screw_hole_r = 4.5; //radius of hole to mount screws (that are not long enough), not necessary if you have long enough screws
motor_screw_distance = 31; //distance between motor_screws

//specific variables endpart
height_endpart = 5; //z-height of part

//variables to arrange parts for visualization and for put-in hardware components 
shaft_length = 333;//total length of steelshafts
motor_length = 48;
motor_width = 42; 
motor_halfdiagonal = 0.5* sqrt(2*(motor_width*motor_width)); //half the diagonal of square area of motor, could be too big when edges of motor are rounded
insert_radius=sqrt(2*(diameter_steelbar*diameter_steelbar));
place_motorpart = 120;//place where motorpart is put
place_leadscrewpart = 180;//place where leadscrewpart is put

shaftcoupler_length = 34;
shaftcoupler_radius = 6.5;

length_bearing = 19;

leadscrew_length = 101;
leadscrew_radius = 3.05;
leadscrewnut_totallength = 13.5;
leadscrewnut_maxradius = 7.5;



echo ((width/2 - (bearing_r + min_wallsize)));

rotate([90, 0, 0]) { //rotates the full model, comment out when you want to draw things, makes it easier, don't forget to comment out the '}' at the very end

/////////////////////////////////////////////////////////////
/////////////////syringepart////////////////////////////////
////////////////////////////////////////////////////////////

translate ([0, 0, (shaft_length-height_syringepart)]) //put part Zmm above 0,0,0
difference ()
{
translate ([0, 0, height_syringepart/2]) 
cube ([width + slip, depth + slip, height_syringepart], center = true);

//half-part carrying syringe
translate ([0, 0.5*depth, 0.65*height_syringepart]) 
cube ([1.1*width, depth, height_syringepart], center = true);
//syringe acess opening
translate ([0, 0.5*depth, 0.25*height_syringepart]) 
cube ([2*syringe_r, depth, height_syringepart], center = true);

//center square-hole where syringe fits in
translate ([0, 0, -(0.1*height_syringepart)]) 
cylinder(r = syringe_r, h = 1.2*height_syringepart, $fa=1, $fs=0.5);

//shaft-holes
//right top
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
//right bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
//left top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
//left bottom
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);

//additional holes to mount 'things' with screws if needed

//left middle
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(bearing_r + min_wallsize)), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
//right middle
translate ([(width/2 - (bearing_r + min_wallsize)), (-(bearing_r + min_wallsize)), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
//middle bottom
translate ([(0), (-(depth/2 - (bearing_r + min_wallsize))), -(height_syringepart) ]) 
cylinder(r = shaft_r, h = 3*height_syringepart, $fa=1, $fs=0.5);
}

////////////////////////////////////////////////////////////
/////////////leadscrewpart////////////////////////////////////
//////////////////////////////////////////////////////////

translate ([0, 0, place_leadscrewpart]) 

difference ()
{
union ()
{
translate ([0, 0, height_leadscrewpart/2]) 
cube ([width + slip, depth + slip, height_leadscrewpart], center = true);

//add endstop-structure
translate ([-endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_leadscrewpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_leadscrewpart, $fa=1, $fs=0.5);   
}

//endstop holes
translate ([-endstopholedistance/2, depth/2+endstopholes_r, -height_leadscrewpart])
*#cylinder(r = endstopholes_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, -height_leadscrewpart])
*#cylinder(r = endstopholes_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5);

//center square-hole where leadscrewnut fits in
translate ([0, 0, -(0.1*height_leadscrewpart)]) 
# cylinder(r = nut_r, h = 1.2*height_leadscrewpart, $fa=1, $fs=0.5);

//shaft-holes
//left bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)), -(height_leadscrewpart) ]) 
cylinder(r = shaft_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5);
//right bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), -(height_leadscrewpart) ]) 
cylinder(r = shaft_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5);
//left top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), -(height_leadscrewpart) ]) 
cylinder(r = shaft_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5);
//right top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))), -(height_leadscrewpart) ]) 
cylinder(r = shaft_r, h = 3*height_leadscrewpart, $fa=1, $fs=0.5);
}

////////////////////////////////////////////////////////////
/////////////motor part////////////////////////////////////
//////////////////////////////////////////////////////////

translate ([0, 0, place_motorpart]) 

difference ()
{
union ()
{
//core body
translate ([0, 0, height_motorpart/2]) 
cube ([width, depth, height_motorpart], center = true);

//add endstop-structure
translate ([-endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_motorpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_motorpart, $fa=1, $fs=0.5);   
}

//endstop holes
translate ([-endstopholedistance/2, depth/2+endstopholes_r, -height_motorpart])
*# cylinder(r = endstopholes_r, h = 3*height_motorpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, -height_motorpart])
*# cylinder(r = endstopholes_r, h = 3*height_motorpart, $fa=1, $fs=0.5);

//center middle hole
translate ([0, 0, -(height_motorpart) ]) 
cylinder(r = motor_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
translate ([0, 0, -(height_motorpart) ])
cylinder(r = motor_r2, h = 1.3*height_motorpart, $fa=1, $fs=0.5);

//holes for bearings
//left bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)), -(height_motorpart) ]) 
cylinder(r = bearing_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//right top
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), -(height_motorpart) ]) 
cylinder(r = bearing_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//left top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), -(height_motorpart) ]) 
cylinder(r = bearing_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//right bottom
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))), -(height_motorpart) ]) 
cylinder(r = bearing_r, h = 3*height_motorpart, $fa=1, $fs=0.5);

//holes for motor screws

rotate([0,0,45])
{
//right top
translate ([(motor_screw_distance/2), (motor_screw_distance/2), -(height_motorpart)]) 
cylinder(r = motor_screw_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//widened hole if you do not have long enough screws (optional) to mount motor
translate ([(motor_screw_distance/2), (motor_screw_distance/2), (motorscrew_length)]) 
cylinder(r = motor_screw_hole_r, h = height_motorpart, $fa=1, $fs=0.5);

//right bottom
translate ([(motor_screw_distance/2), -(motor_screw_distance/2), -(height_motorpart)]) 
cylinder(r = motor_screw_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//widened hole if you do not have long enough screws (optional) to mount motor
translate ([(motor_screw_distance/2), -(motor_screw_distance/2), (motorscrew_length)]) 
cylinder(r = motor_screw_hole_r, h = height_motorpart, $fa=1, $fs=0.5);

//left top
translate ([-(motor_screw_distance/2), (motor_screw_distance/2), -(height_motorpart)]) 
cylinder(r = motor_screw_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//widened hole if you do not have long enough screws (optional) to mount motor
translate ([-(motor_screw_distance/2), (motor_screw_distance/2), (motorscrew_length)]) 
cylinder(r = motor_screw_hole_r, h = height_motorpart, $fa=1, $fs=0.5);

//left bottom
translate ([-(motor_screw_distance/2), -(motor_screw_distance/2), -(height_motorpart)]) 
cylinder(r = motor_screw_r, h = 3*height_motorpart, $fa=1, $fs=0.5);
//widened hole if you do not have long enough screws (optional) to mount motor
translate ([-(motor_screw_distance/2), -(motor_screw_distance/2), (motorscrew_length)]) 
cylinder(r = motor_screw_hole_r, h = height_motorpart, $fa=1, $fs=0.5);
}
}

//////////////////////////////////////////////////////////
///////////////////endpart////////////////////////////////
//////////////////////////////////////////////////////////

translate ([0, 0, 0]) //put part Zmm above 0,0,0

difference ()
{
union ()
{
//core body
translate ([0, 0, height_endpart/2]) 
cube ([width + slip, depth + slip, height_endpart], center = true);

//add endstop-structure
translate ([-endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_endpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, 0])
*cylinder(r = 2.5*endstopholes_r, h = height_endpart, $fa=1, $fs=0.5);   
}

//endstop holes
translate ([-endstopholedistance/2, depth/2+endstopholes_r, -height_endpart])
*# cylinder(r = endstopholes_r, h = 3*height_endpart, $fa=1, $fs=0.5); 
translate ([endstopholedistance/2, depth/2+endstopholes_r, -height_endpart])
*# cylinder(r = endstopholes_r, h = 3*height_endpart, $fa=1, $fs=0.5);

//center square-hole 
translate ([0, 0, height_endpart/2]) 
cylinder(h = 3*height_endpart, r=(width/2 - (bearing_r + min_wallsize)), $fn=4,center = true);

//shaft-holes
//left bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)), -(height_endpart) ]) 
cylinder(r = shaft_r, h = 3*height_endpart, $fa=1, $fs=0.5);
//right bottom
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), -(height_endpart) ]) 
cylinder(r = shaft_r, h = 3*height_endpart, $fa=1, $fs=0.5);
//left top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), -(height_endpart) ]) 
cylinder(r = shaft_r, h = 3*height_endpart, $fa=1, $fs=0.5);
//right top
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))), -(height_endpart) ]) 
cylinder(r = shaft_r, h = 3*height_endpart, $fa=1, $fs=0.5);
}

////////////////////////////////////////////////////////////////////
//////HARDWARE for visualization only///////////////////////////////
///////////////////////////////////////////////////////////////////

/////////////////
//steel shafts
//left bottom
color ("slategray", a=1.0)
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)), 0 ]) 
cylinder(r = shaft_r, h = shaft_length, $fa=1, $fs=0.5);
//right bottom
color ("slategray", a=1.0)
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), 0 ]) 
cylinder(r = shaft_r, h = shaft_length, $fa=1, $fs=0.5);
//left top
color ("slategray", a=1.0)
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), 0 ]) 
cylinder(r = shaft_r, h = shaft_length, $fa=1, $fs=0.5);
//right top
color ("slategray", a=1.0)
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))),0 ]) 
cylinder(r = shaft_r, h = shaft_length, $fa=1, $fs=0.5);

/////////////////
//motor
color ("black", a=1.0)
translate ([0,0,(place_motorpart-motor_length/2) ])
cylinder(h = motor_length, r=motor_halfdiagonal, $fn=4,center = true);

/////////////////
//motor-screws
rotate([0,0,45])
translate ([0,0,(place_motorpart) ]) 
{
//top
color ("silver", a=1.0)
translate ([(motor_screw_distance/2), (motor_screw_distance/2), 0]) 
cylinder(r = motor_screw_r, h = height_motorpart, $fa=1, $fs=0.5);
//middle right
color ("silver", a=1.0)
translate ([(motor_screw_distance/2), -(motor_screw_distance/2), 0]) 
cylinder(r = motor_screw_r, h = height_motorpart, $fa=1, $fs=0.5);
//middle left
color ("silver", a=1.0)
translate ([-(motor_screw_distance/2), (motor_screw_distance/2), 0]) 
cylinder(r = motor_screw_r, h = height_motorpart, $fa=1, $fs=0.5);
//bottom
color ("silver", a=1.0)
translate ([-(motor_screw_distance/2), -(motor_screw_distance/2), 0]) 
cylinder(r = motor_screw_r, h = height_motorpart, $fa=1, $fs=0.5);
}

/////////////////
//LMUU-bearings

translate ([0,0,(place_motorpart) ]) 
{
//right top
color ("orangered", a=1.0)
translate ([(width/2 - (bearing_r + min_wallsize)), (depth/2 - (bearing_r + min_wallsize)),0 ]) 
cylinder(r = bearing_r, h = length_bearing, $fa=1, $fs=0.5);
//right bottom
color ("orangered", a=1.0)
translate ([(width/2 - (bearing_r + min_wallsize)), (-(depth/2 - (bearing_r + min_wallsize))), 0 ]) 
cylinder(r = bearing_r, h = length_bearing, $fa=1, $fs=0.5);
//left top
color ("orangered", a=1.0)
translate ([(-(width/2 - (bearing_r + min_wallsize))), (depth/2 - (bearing_r + min_wallsize)), 0 ]) 
cylinder(r = bearing_r, h = length_bearing, $fa=1, $fs=0.5);
//right bottom
color ("orangered", a=1.0)
translate ([(-(width/2 - (bearing_r + min_wallsize))), (-(depth/2 - (bearing_r + min_wallsize))), 0 ]) 
cylinder(r = bearing_r, h = length_bearing, $fa=1, $fs=0.5);
}

///////////////////
//shaftcoupler
color ("red", a=1.0)
translate ([0,0,(place_motorpart) ])
cylinder(r = shaftcoupler_radius, h = shaftcoupler_length, $fa=1, $fs=0.5); 

//////////////////
//Leadscrew
color ("silver", a=1.0)
translate ([0,0,(place_motorpart+ 0.75*shaftcoupler_length) ])
cylinder(r = leadscrew_radius, h = leadscrew_length, $fa=1, $fs=0.5); 

////////////////
//Leadscrewnut
color ("red", a=1.0)
translate ([0, 0, place_leadscrewpart+height_leadscrewpart/2-leadscrewnut_totallength/2])  
cylinder(r = leadscrewnut_maxradius, h = leadscrewnut_totallength, $fa=1, $fs=0.5); 


}//comment this out when you not want to have the full model rotated
