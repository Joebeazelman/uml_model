package body UML_Model.Models is

   function Is_Empty (M : Model) return Boolean is
     (M.Classes.Is_Empty
      and then M.Relations.Is_Empty
      and then M.State_Machines.Is_Empty);

end UML_Model.Models;
