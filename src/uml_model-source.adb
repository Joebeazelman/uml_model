with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body UML_Model.Source is

   function To_String (Loc : Source_Location) return String is
      Line_Img   : constant String := Line_Number'Image (Loc.Line);
      Column_Img : constant String := Column_Number'Image (Loc.Column);
   begin
      return Line_Img (2 .. Line_Img'Last)
             & ":"
             & Column_Img (2 .. Column_Img'Last);
   end To_String;

   function Make_Fragment
     (Text : String;
      Loc  : Source_Location := No_Location) return Fragment is
     ((Text => To_Unbounded_String (Text), Location => Loc));

   function To_String (F : Fragment) return String is
     (To_String (F.Text));

   function Is_Empty (F : Fragment) return Boolean is
     (Length (F.Text) = 0);

   function Make_Error
     (Loc     : Source_Location;
      Message : String) return Source_Error is
     ((Location => Loc, Message => To_Unbounded_String (Message)));

   function To_String (E : Source_Error) return String is
     (To_String (E.Location) & ": " & To_String (E.Message));

   package body Results is
      function Ok (O : Output_Type) return Result is
        ((Success => True, Output => O));

      function Err (E : Source_Error) return Result is
        ((Success => False, Error => E));
   end Results;

end UML_Model.Source;
