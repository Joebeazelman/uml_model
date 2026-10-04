with UML_Model.Elements; use UML_Model.Elements;

package UML_Model.Types is

   type Resolution_State is (Resolved, Unresolved, Builtin);

   type Type_Reference is record
      Name  : Identifier;
      State : Resolution_State := Unresolved;
   end record;

   function Make_Type_Reference
     (Name : String; State : Resolution_State := Unresolved)
      return Type_Reference;

   function To_String (T : Type_Reference) return String;

   type Cardinality is new Natural;

   type Multiplicity is record
      Lower_Bound : Cardinality := 0;
      Upper_Bound : Cardinality := Cardinality'Last;
   end record
   with
     Dynamic_Predicate => Multiplicity.Lower_Bound <= Multiplicity.Upper_Bound;

   Exactly_One  : constant Multiplicity :=
     (Lower_Bound => 1, Upper_Bound => 1);
   Zero_Or_One  : constant Multiplicity :=
     (Lower_Bound => 0, Upper_Bound => 1);
   Zero_Or_More : constant Multiplicity :=
     (Lower_Bound => 0, Upper_Bound => Cardinality'Last);
   One_Or_More  : constant Multiplicity :=
     (Lower_Bound => 1, Upper_Bound => Cardinality'Last);

   subtype Single is Multiplicity
   with Dynamic_Predicate => Single.Lower_Bound = 1 and Single.Upper_Bound = 1;
   subtype Optional is Multiplicity
   with
     Dynamic_Predicate =>
       Optional.Lower_Bound = 0 and Optional.Upper_Bound = 1;
   subtype Unbounded is Multiplicity
   with Dynamic_Predicate => Unbounded.Upper_Bound = Cardinality'Last;

   function To_String (M : Multiplicity) return String;
   function Is_Unbounded (M : Multiplicity) return Boolean;
   function Is_Single (M : Multiplicity) return Boolean;

   function Try_Parse_Multiplicity
     (Text : String; Value : out Multiplicity) return Boolean
   with
     Post =>
       (if Try_Parse_Multiplicity'Result
        then Value.Lower_Bound <= Value.Upper_Bound);

   function Parse_Multiplicity (Text : String) return Multiplicity
   with
     Post =>
       Parse_Multiplicity'Result.Lower_Bound
       <= Parse_Multiplicity'Result.Upper_Bound;

end UML_Model.Types;
