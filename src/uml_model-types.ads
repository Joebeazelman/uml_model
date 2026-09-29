with UML_Model.Elements; use UML_Model.Elements;

package UML_Model.Types is

   type Resolution_State is (Resolved, Unresolved, Builtin);

   type Type_Reference is record
      Name  : Identifier;
      State : Resolution_State := Unresolved;
   end record;

   function Make_Type_Reference
     (Name  : String;
      State : Resolution_State := Unresolved) return Type_Reference;

   function To_String (T : Type_Reference) return String;

   type Cardinality is new Natural;

   type Multiplicity is record
      Lower : Cardinality := 0;
      Upper : Cardinality := Cardinality'Last;
   end record
     with Dynamic_Predicate => Multiplicity.Lower <= Multiplicity.Upper;

   Exactly_One  : constant Multiplicity := (1, 1);
   Zero_Or_One  : constant Multiplicity := (0, 1);
   Zero_Or_More : constant Multiplicity := (0, Cardinality'Last);
   One_Or_More  : constant Multiplicity := (1, Cardinality'Last);

   subtype Single    is Multiplicity
     with Dynamic_Predicate => Single.Lower = 1 and Single.Upper = 1;
   subtype Optional  is Multiplicity
     with Dynamic_Predicate => Optional.Lower = 0 and Optional.Upper = 1;
   subtype Unbounded is Multiplicity
     with Dynamic_Predicate => Unbounded.Upper = Cardinality'Last;

   function To_String     (M : Multiplicity) return String;
   function Is_Unbounded  (M : Multiplicity) return Boolean;
   function Is_Single     (M : Multiplicity) return Boolean;

end UML_Model.Types;
