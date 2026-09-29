with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;

package body UML_Model.Elements is

   function Make_Identifier (Name : String) return Identifier is
   begin
      if Name'Length = 0 then
         return Invalid_Identifier;
      end if;
      if not Is_Letter (Name (Name'First)) then
         return Invalid_Identifier;
      end if;
      for C of Name loop
         if not (Is_Alphanumeric (C) or else C = '_') then
            return Invalid_Identifier;
         end if;
      end loop;
      return (Name => To_Unbounded_String (Name));
   end Make_Identifier;

   function To_String (Id : Identifier) return String is
     (To_String (Id.Name));

   function "=" (Left, Right : Identifier) return Boolean is
     (Left.Name = Right.Name);

   function Is_Valid (Id : Identifier) return Boolean is
     (Length (Id.Name) > 0);

   function Make_Stereotype (Name : String) return Stereotype is
      S : constant String := Name;
   begin
      if S'Length >= 4
        and then S (S'First) = '<'
        and then S (S'First + 1) = '<'
        and then S (S'Last - 1) = '>'
        and then S (S'Last) = '>'
      then
         return (Text => To_Unbounded_String
                   (S (S'First + 2 .. S'Last - 2)));
      end if;
      return (Text => To_Unbounded_String (S));
   end Make_Stereotype;

   function To_String (S : Stereotype) return String is
     (To_String (S.Text));

   function Stereotypes (E : Stereotyped_Element) return Stereotype_Vector is
     (E.Stereotypes);

   function Tags (E : Stereotyped_Element) return Tagged_Value_Vector is
     (E.Tags);

end UML_Model.Elements;
