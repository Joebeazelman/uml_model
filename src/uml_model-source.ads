with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package UML_Model.Source is

   type Line_Number   is new Positive;
   type Column_Number is new Positive;

   type Source_Location is record
      Line   : Line_Number   := 1;
      Column : Column_Number := 1;
   end record;

   No_Location : constant Source_Location := (Line => 1, Column => 1);

   function To_String (Loc : Source_Location) return String;

   type Fragment is record
      Text     : Unbounded_String;
      Location : Source_Location := No_Location;
   end record;

   function Make_Fragment
     (Text : String;
      Loc  : Source_Location := No_Location) return Fragment;

   function To_String (F : Fragment) return String;
   function Is_Empty (F : Fragment) return Boolean;

   type Source_Error is record
      Location : Source_Location;
      Message  : Unbounded_String;
   end record;

   function Make_Error
     (Loc     : Source_Location;
      Message : String) return Source_Error;

   function To_String (E : Source_Error) return String;

   --  The formal parameter is named Output_Type rather than Output
   --  because the component is named Output.
   --
   --  The discriminant has a default (False) so a Result can be
   --  declared without immediate initialization. The default is the
   --  failure case, which reads as "no result yet."
   generic
      type Output_Type is private;
   package Results is
      type Result (Success : Boolean := False) is record
         case Success is
            when True  => Output : Output_Type;
            when False => Error  : Source_Error;
         end case;
      end record;

      function Ok  (O : Output_Type)  return Result;
      function Err (E : Source_Error) return Result;
   end Results;

end UML_Model.Source;
