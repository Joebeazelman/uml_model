with AUnit.Test_Suites;
with UML_Model_Tests.Test_Identifier;
with UML_Model_Tests.Test_Multiplicity;
with UML_Model_Tests.Test_Source_Location;
with UML_Model_Tests.Test_Stereotype;

package body UML_Model_Tests.Suite is

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (Test_Identifier.Suite);
      Result.Add_Test (Test_Multiplicity.Suite);
      Result.Add_Test (Test_Source_Location.Suite);
      Result.Add_Test (Test_Stereotype.Suite);
      return Result;
   end Suite;

end UML_Model_Tests.Suite;
