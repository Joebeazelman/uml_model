with Ada.Containers.Vectors;
with UML_Model.Elements; use UML_Model.Elements;
with UML_Model.Source;   use UML_Model.Source;
with UML_Model.Types;    use UML_Model.Types;

package UML_Model.Class is

   type Visibility is (Public, Vis_Private, Vis_Protected, Package_Level);

   --  The record components are named the same as their types, so
   --  the type side of each declaration is fully qualified to avoid
   --  the component shadowing the type.

   type Property is new Stereotyped_Element with record
      Name         : Identifier;
      Of_Type      : Type_Reference;
      Visibility   : UML_Model.Class.Visibility := Public;
      Multiplicity : UML_Model.Types.Multiplicity := Exactly_One;
      Default      : Fragment;
   end record;

   package Property_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Property);
   use Property_Vectors;

   subtype Property_Vector is Property_Vectors.Vector;

   type Operation is new Stereotyped_Element with record
      Name        : Identifier;
      Parameters  : Property_Vector;
      Return_Type : Type_Reference;
      Visibility  : UML_Model.Class.Visibility := Public;
   end record;

   package Operation_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Operation);
   use Operation_Vectors;

   subtype Operation_Vector is Operation_Vectors.Vector;

   type Class_Model is new Stereotyped_Element with record
      Name       : Identifier;
      Visibility : UML_Model.Class.Visibility := Public;
      Attributes : Property_Vector;
      Operations : Operation_Vector;
   end record;

   package Class_Model_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Class_Model);
   use Class_Model_Vectors;

   subtype Class_Model_Vector is Class_Model_Vectors.Vector;

end UML_Model.Class;
