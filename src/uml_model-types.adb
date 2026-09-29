with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body UML_Model.Types is

   function Make_Type_Reference
     (Name  : String;
      State : Resolution_State := Unresolved) return Type_Reference is
     ((Name => Make_Identifier (Name), State => State));

   function To_String (T : Type_Reference) return String is
     (To_String (T.Name));

   function To_String (M : Multiplicity) return String is
   begin
      if M.Lower = 1 and then M.Upper = 1 then
         return "1";
      elsif M.Lower = 0 and then M.Upper = 1 then
         return "0..1";
      elsif M.Lower = 0 and then M.Upper = Cardinality'Last then
         return "*";
      elsif M.Upper = Cardinality'Last then
         return Trim (Cardinality'Image (M.Lower), Ada.Strings.Left) & "..*";
      else
         return Trim (Cardinality'Image (M.Lower), Ada.Strings.Left)
                & ".."
                & Trim (Cardinality'Image (M.Upper), Ada.Strings.Left);
      end if;
   end To_String;

   function Is_Unbounded (M : Multiplicity) return Boolean is
     (M.Upper = Cardinality'Last);

   function Is_Single (M : Multiplicity) return Boolean is
     (M.Lower = 1 and then M.Upper = 1);

end UML_Model.Types;
