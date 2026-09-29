with AUnit.Assertions;       use AUnit.Assertions;
with AUnit.Test_Cases;       use AUnit.Test_Cases;
with AUnit.Test_Suites;
with UML_Model.Elements;     use UML_Model.Elements;

package body UML_Model_Tests.Test_Identifier is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Valid (T : in out Test_Case'Class);
   procedure Test_Invalid_Empty (T : in out Test_Case'Class);
   procedure Test_Invalid_Leading_Digit (T : in out Test_Case'Class);
   procedure Test_Invalid_Special_Char (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("UML_Model.Elements.Identifier"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Valid'Access,
                        "valid identifier accepted");
      Register_Routine (T, Test_Invalid_Empty'Access,
                        "empty identifier rejected");
      Register_Routine (T, Test_Invalid_Leading_Digit'Access,
                        "leading digit rejected");
      Register_Routine (T, Test_Invalid_Special_Char'Access,
                        "special character rejected");
   end Register_Tests;

   procedure Test_Valid (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Id : constant Identifier := Make_Identifier ("Foo_Bar");
   begin
      Assert (Is_Valid (Id), "Foo_Bar should be valid");
      Assert (To_String (Id) = "Foo_Bar", "round-trip mismatch");
   end Test_Valid;

   procedure Test_Invalid_Empty (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (not Is_Valid (Make_Identifier ("")),
              "empty should be invalid");
   end Test_Invalid_Empty;

   procedure Test_Invalid_Leading_Digit (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (not Is_Valid (Make_Identifier ("9Foo")),
              "leading digit should be invalid");
   end Test_Invalid_Leading_Digit;

   procedure Test_Invalid_Special_Char (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (not Is_Valid (Make_Identifier ("Foo-Bar")),
              "hyphen should be invalid");
   end Test_Invalid_Special_Char;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end UML_Model_Tests.Test_Identifier;
