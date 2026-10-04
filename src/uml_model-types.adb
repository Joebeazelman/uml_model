with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body UML_Model.Types is

   function Make_Type_Reference
     (Name : String; State : Resolution_State := Unresolved)
      return Type_Reference
   is ((Name => Make_Identifier (Name), State => State));

   function To_String (T : Type_Reference) return String
   is (To_String (T.Name));

   function To_String (M : Multiplicity) return String is
   begin
      if M.Lower_Bound = 1 and then M.Upper_Bound = 1 then
         return "1";
      elsif M.Lower_Bound = 0 and then M.Upper_Bound = 1 then
         return "0..1";
      elsif M.Lower_Bound = 0 and then M.Upper_Bound = Cardinality'Last then
         return "*";
      elsif M.Upper_Bound = Cardinality'Last then
         return
           Trim (Cardinality'Image (M.Lower_Bound), Ada.Strings.Left) & "..*";
      else
         return
           Trim (Cardinality'Image (M.Lower_Bound), Ada.Strings.Left)
           & ".."
           & Trim (Cardinality'Image (M.Upper_Bound), Ada.Strings.Left);
      end if;
   end To_String;

   function Is_Unbounded (M : Multiplicity) return Boolean
   is (M.Upper_Bound = Cardinality'Last);

   function Is_Single (M : Multiplicity) return Boolean
   is (M.Lower_Bound = 1 and then M.Upper_Bound = 1);

   function Try_Parse_Multiplicity
     (Text : String; Value : out Multiplicity) return Boolean
   is
      T       : constant String := Trim (Text, Ada.Strings.Both);
      Dot_Pos : Natural;
   begin
      if T'Length = 0 then
         Value := Exactly_One;
         return False;
      end if;

      if T = "*" or else T = "n" or else T = "many" then
         Value := Zero_Or_More;
         return True;
      elsif T = "1..*" then
         Value := One_Or_More;
         return True;
      elsif T = "0..1" then
         Value := Zero_Or_One;
         return True;
      elsif T = "1" then
         Value := Exactly_One;
         return True;
      end if;

      Dot_Pos := Index (T, "..");
      if Dot_Pos > T'First and then Dot_Pos + 1 < T'Last then
         declare
            Lower_Str : constant String := T (T'First .. Dot_Pos - 1);
            Upper_Str : constant String := T (Dot_Pos + 2 .. T'Last);
            Lower_Val : Cardinality;
            Upper_Val : Cardinality;
         begin
            Lower_Val := Cardinality'Value (Lower_Str);
            if Upper_Str = "*" or else Upper_Str = "n" then
               Upper_Val := Cardinality'Last;
            else
               Upper_Val := Cardinality'Value (Upper_Str);
            end if;

            if Lower_Val <= Upper_Val then
               Value := (Lower_Bound => Lower_Val, Upper_Bound => Upper_Val);
               return True;
            end if;
         exception
            when others =>
               return False;
         end;
      end if;

      declare
         Val : constant Cardinality := Cardinality'Value (T);
      begin
         Value := (Lower_Bound => Val, Upper_Bound => Val);
         return True;
      exception
         when others =>
            return False;
      end;
   end Try_Parse_Multiplicity;

   function Parse_Multiplicity (Text : String) return Multiplicity is
      M : Multiplicity;
   begin
      if Try_Parse_Multiplicity (Text, M) then
         return M;
      else
         return Exactly_One;
      end if;
   end Parse_Multiplicity;

end UML_Model.Types;
