with AUnit.Assertions;         use AUnit.Assertions;
with AUnit.Test_Cases;         use AUnit.Test_Cases;
with AUnit.Test_Suites;
with UML_Model.Source;         use UML_Model.Source;

package body UML_Model_Tests.Test_Source_Location is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Render (T : in out Test_Case'Class);
   procedure Test_Fragment (T : in out Test_Case'Class);
   procedure Test_Error (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("UML_Model.Source"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Render'Access, "location renders");
      Register_Routine (T, Test_Fragment'Access, "fragment round-trip");
      Register_Routine (T, Test_Error'Access, "error renders");
   end Register_Tests;

   procedure Test_Render (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Loc : constant Source_Location := (Line => 10, Column => 3);
   begin
      Assert (To_String (Loc) = "10:3", "expected 10:3");
   end Test_Render;

   procedure Test_Fragment (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      F : constant Fragment := Make_Fragment ("hello");
   begin
      Assert (not Is_Empty (F), "non-empty fragment");
      Assert (To_String (F) = "hello", "text round-trip");
   end Test_Fragment;

   procedure Test_Error (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      E : constant Source_Error :=
        Make_Error ((Line => 5, Column => 1), "boom");
   begin
      Assert (To_String (E) = "5:1: boom", "expected 5:1: boom");
   end Test_Error;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end UML_Model_Tests.Test_Source_Location;
