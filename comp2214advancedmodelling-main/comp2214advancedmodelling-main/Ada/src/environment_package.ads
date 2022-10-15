with Button_Package; use Button_Package;
with Door_Package; use Door_Package;
with Multi; use Multi;
with Floor_Package; use Floor_Package;
with Motor_Package; use Motor_Package;
with Cabin_Package; use Cabin_Package;
with Shaft_Package; use Shaft_Package;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package Environment_Package with SPARK_Mode is

   function HasCabinAbove(n : in Cabin_Number) return Boolean with
     Global => (Input => (cabins_array),
                Proof_In => (up_buttons_array, down_buttons_array)),
     Pre => Invariants(cabins_array, up_buttons_array, down_buttons_array),
   -- Task B2. Please fill in the missing Depends clause, i.e., Depends => ...
   -- Task B2. Please replace True with the Postcondition for this function
     Depends => (HasCabinAbove'Result => (cabins_array,n)),
     Post => (if (for all I in cabins_array'Range 
              => cabins_array(I).shaft = cabins_array(n).shaft and
                cabins_array(I).floor = cabins_array(n).floor + 1) 
                then HasCabinAbove'Result = True 
              else HasCabinAbove'Result = False)
   ;
   
   function HasCabinBelow(n : in Cabin_Number) return Boolean with
     Global => (Input => (cabins_array),
                Proof_In => (up_buttons_array, down_buttons_array)),
     Pre => Invariants(cabins_array, up_buttons_array, down_buttons_array),
   -- Task B2. Please fill in the missing Depends clause, i.e., Depends => ...
   -- Task B2. Please replace True with the Postcondition for this function
     Depends => (HasCabinBelow'Result => (cabins_array,n)),
     Post => (if (for all I in cabins_array'Range
              => cabins_array(I).shaft = cabins_array(n).shaft and
                cabins_array(I).floor = cabins_array(n).floor - 1) 
                then HasCabinBelow'Result = True
             else HasCabinBelow'Result = False)
   ;

   function HasCabinAtBottomUpShaft return Boolean with
     Global => (Input => (cabins_array),
                Proof_In => (up_buttons_array, down_buttons_array)),
     Pre => Invariants(cabins_array, up_buttons_array, down_buttons_array),
   -- Task B2. Please fill in the missing Depends clause, i.e., Depends => ...
   -- Task B2. Please replace True with the Postcondition for this function
     Depends => (HasCabinAtBottomUpShaft'Result => cabins_array),
     Post => (if (for all I in cabins_array'Range
              => cabins_array(I).shaft = Up and
                cabins_array(I).floor = 0)
                then HasCabinAtBottomUpShaft'Result = True
             else HasCabinAtBottomUpShaft'Result = False)
   ;

   function HasCabinAtTopDownShaft return Boolean with
     Global => (Input => (cabins_array),
                Proof_In => (up_buttons_array, down_buttons_array)),
     Pre => Invariants(cabins_array, up_buttons_array, down_buttons_array),
   -- Task B2. Please fill in the missing Depends clause, i.e., Depends => ...
   -- Task B2. Please replace True with the Postcondition for this function
     Depends => (HasCabinAtTopDownShaft'Result => cabins_array),
     Post => (if (for all I in cabins_array'Range
              => cabins_array(I).shaft = Down and
                cabins_array(I).floor = TOP_FLOOR)
                then HasCabinAtTopDownShaft'Result = True
             else HasCabinAtTopDownShaft'Result = False)
   ;

   procedure environment with
     Global => (Input => (Default_Width,
                          Default_Base),
                  Proof_In=> (
                          up_buttons_array,
                          down_buttons_array
                          ),
                In_Out => (File_System,
                          cabins_array)
               ),
       Pre => Invariants(cabins_array,
                         up_buttons_array,
                         down_buttons_array),
     Post => Invariants(cabins_array,
                         up_buttons_array,
                         down_buttons_array);

end Environment_Package;
