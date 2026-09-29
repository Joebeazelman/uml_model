with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with UML_Model.Source;      use UML_Model.Source;

package UML_Model.Elements is

   type Identifier is private;

   function Make_Identifier (Name : String) return Identifier;
   function To_String (Id : Identifier) return String;
   function "=" (Left, Right : Identifier) return Boolean;
   function Is_Valid (Id : Identifier) return Boolean;

   Invalid_Identifier : constant Identifier;

   --  Stereotype is a visible record, not a private type. The
   --  vector instantiation below needs the full view, and there's
   --  no invariant worth hiding.
   type Stereotype is record
      Text : Unbounded_String;
   end record;

   function Make_Stereotype (Name : String) return Stereotype;
   function To_String (S : Stereotype) return String;

   package Stereotype_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Stereotype);
   use Stereotype_Vectors;

   subtype Stereotype_Vector is Stereotype_Vectors.Vector;

   type Tagged_Value is record
      Key   : Unbounded_String;
      Value : Unbounded_String;
   end record;

   package Tagged_Value_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Tagged_Value);
   use Tagged_Value_Vectors;

   subtype Tagged_Value_Vector is Tagged_Value_Vectors.Vector;

   type Element_With_Stereotypes is interface;

   function Stereotypes (E : Element_With_Stereotypes)
     return Stereotype_Vector is abstract;

   function Tags (E : Element_With_Stereotypes)
     return Tagged_Value_Vector is abstract;

   type Stereotyped_Element is abstract tagged record
      Stereotypes : Stereotype_Vector;
      Tags        : Tagged_Value_Vector;
      Location    : Source_Location := No_Location;
   end record;

   function Stereotypes (E : Stereotyped_Element) return Stereotype_Vector;
   function Tags        (E : Stereotyped_Element) return Tagged_Value_Vector;

private

   type Identifier is record
      Name : Unbounded_String;
   end record;

   Invalid_Identifier : constant Identifier :=
     (Name => Null_Unbounded_String);

end UML_Model.Elements;
