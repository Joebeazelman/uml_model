with Ada.Containers.Vectors;
with UML_Model.Elements; use UML_Model.Elements;
with UML_Model.Source;   use UML_Model.Source;

package UML_Model.State_Machine is

   type State_Kind is
     (Simple, Composite, Initial, Final, Choice, Fork, Join, History);

   type State is new Stereotyped_Element with record
      Name         : Identifier;
      Kind         : State_Kind := Simple;
      Parent       : Identifier := Invalid_Identifier;
      Entry_Action : Fragment;
      Exit_Action  : Fragment;
   end record;

   package State_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => State);
   use State_Vectors;

   subtype State_Vector is State_Vectors.Vector;

   type Transition is new Stereotyped_Element with record
      Source  : Identifier;
      Target  : Identifier;
      Trigger : Fragment;
      Guard   : Fragment;
      Action  : Fragment;
   end record;

   package Transition_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Transition);
   use Transition_Vectors;

   subtype Transition_Vector is Transition_Vectors.Vector;

   type State_Chart_Model is new Stereotyped_Element with record
      Name        : Identifier;
      States      : State_Vector;
      Transitions : Transition_Vector;
      Initial     : Identifier := Invalid_Identifier;
   end record;

   package State_Chart_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => State_Chart_Model);
   use State_Chart_Vectors;

   subtype State_Chart_Vector is State_Chart_Vectors.Vector;

end UML_Model.State_Machine;
