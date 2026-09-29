with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with UML_Model.Elements;      use UML_Model.Elements;
with UML_Model.Types;         use UML_Model.Types;
with UML_Model.Class;         use UML_Model.Class;
with UML_Model.State_Machine; use UML_Model.State_Machine;

package UML_Model.Models is

   type Relation_Kind is
     (Association, Aggregation, Composition, Inheritance, Realization);

   type Relation is new Stereotyped_Element with record
      Kind         : Relation_Kind;
      Source       : Identifier;
      Target       : Identifier;
      Source_Role  : Unbounded_String;
      Target_Role  : Unbounded_String;
      Multiplicity : UML_Model.Types.Multiplicity := Exactly_One;
   end record;

   package Relation_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Relation);
   use Relation_Vectors;

   subtype Relation_Vector is Relation_Vectors.Vector;

   type Model is record
      Classes        : Class_Model_Vector;
      Relations      : Relation_Vector;
      State_Machines : State_Chart_Vector;
   end record;

   Empty_Model : constant Model :=
     (Classes        => Class_Model_Vectors.Empty_Vector,
      Relations      => Relation_Vectors.Empty_Vector,
      State_Machines => State_Chart_Vectors.Empty_Vector);

   function Is_Empty (M : Model) return Boolean;

end UML_Model.Models;
