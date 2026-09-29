with AUnit.Assertions;   use AUnit.Assertions;
with AUnit.Test_Cases;   use AUnit.Test_Cases;
with AUnit.Test_Suites;
with UML_Model.Types;    use UML_Model.Types;

package body UML_Model_Tests.Test_Multiplicity is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Exactly_One (T : in out Test_Case'Class);
   procedure Test_Zero_Or_One (T : in out Test_Case'Class);
   procedure Test_Zero_Or_More (T : in out Test_Case'Class);
   procedure Test_One_Or_More (T : in out Test_Case'Class);
   procedure Test_Predicate (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("UML_Model.Types.Multiplicity"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Exactly_One'Access,   "1 renders as 1");
      Register_Routine (T, Test_Zero_Or_One'Access,   "0..1 renders");
      Register_Routine (T, Test_Zero_Or_More'Access,  "* renders");
      Register_Routine (T, Test_One_Or_More'Access,   "1..* renders");
      Register_Routine (T, Test_Predicate'Access,
                        "Is_Unbounded / Is_Single");
   end Register_Tests;

   procedure Test_Exactly_One (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (Exactly_One) = "1", "expected 1");
   end Test_Exactly_One;

   procedure Test_Zero_Or_One (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (Zero_Or_One) = "0..1", "expected 0..1");
   end Test_Zero_Or_One;

   procedure Test_Zero_Or_More (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (Zero_Or_More) = "*", "expected *");
   end Test_Zero_Or_More;

   procedure Test_One_Or_More (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (To_String (One_Or_More) = "1..*", "expected 1..*");
   end Test_One_Or_More;

   procedure Test_Predicate (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (Is_Single (Exactly_One), "Exactly_One is single");
      Assert (not Is_Single (Zero_Or_More), "Zero_Or_More is not single");
      Assert (Is_Unbounded (Zero_Or_More), "Zero_Or_More is unbounded");
      Assert (not Is_Unbounded (Exactly_One),
              "Exactly_One is not unbounded");
   end Test_Predicate;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end UML_Model_Tests.Test_Multiplicity;
