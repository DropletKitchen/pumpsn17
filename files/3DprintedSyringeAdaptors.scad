//syringe adaptors for pumps with a 14mm diameter cut-out
// r of our syringes are:
//Hamilton 200uL/500uL: OD 7.75; (r=3.875)
//1mL plastic: OD 7mm
//ring for 5mL BD: 14.75mm (fits into default part but neets 5mm ring)
//sge glass 100 & 250micL r=4.5+0.25
//default length of connector: 60mm

//variables
length_syringe=60; //put in desired length of the part (might depend on syringe)
syringe_r=4.5 +0.25; //radius of the syringe in question + material/3D-printer dependent addition for easy fit (here 0.5mm), 

cutout_r=7; //radius of the cut-out in the 'syringe-part' of the pump = outer cylinder of part, here 7

fix_r=cutout_r+2; //feature to fix connector (add 2mm)
fix_h=2;

rim=10; //length of plastic all around
//model

difference ()
{
    translate ([0,0,0]) 
    rotate ([0,0,0])
    union ()
        {
            cylinder(r = cutout_r, h = length_syringe, $fa=1, $fs=0.5);
            cylinder(r = fix_r, h = fix_h, $fa=1, $fs=0.5);
        }
        
    cylinder(r = syringe_r, h = 4*length_syringe, $fa=1, $fs=0.5, center=true);
    translate ([0,0,rim/2])    
    cube ([2*syringe_r, 2*syringe_r, length_syringe]);
}