with AUnit.Assertions;     use AUnit.Assertions;
with AUnit.Test_Cases;     use AUnit.Test_Cases;
with AUnit.Test_Suites;
with UML_Model.Elements;   use UML_Model.Elements;

package body UML_Model_Tests.Test_Stereotype is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Bare_Name (T : in out Test_Case'Class);
   procedure Test_Guillemets (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("UML_Model.Elements.Stereotype"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Bare_Name'Access,
                        "bare name preserved");
      Register_Routine (T, Test_Guillemets'Access,
                        "guillemets stripped");
   end Register_Tests;

   procedure Test_Bare_Name (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (Make_Stereotype ("interface")) = "interface",
              "bare name");
   end Test_Bare_Name;

   procedure Test_Guillemets (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (Make_Stereotype ("<<interface>>")) = "interface",
              "guillemets stripped");
   end Test_Guillemets;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end UML_Model_Tests.Test_Stereotype;
