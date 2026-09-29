with AUnit.Reporter.Text;
with AUnit.Run;
with UML_Model_Tests.Suite;

procedure Tests is
   use AUnit;
   Failed_Tests : exception;

   function Run is new AUnit.Run.Test_Runner_With_Status
     (UML_Model_Tests.Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   if Run (Reporter) /= Success then
      raise Failed_Tests;
   end if;
end Tests;
