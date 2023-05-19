<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<Program SubType="IEC" xmlns="http://br-automation.co.at/AS/Program">
  <Files>
    <File Description="Init, cyclic, exit code">AxisMgr.st</File>
    <File Description="Local variables, specific to this axis" Private="true">Variables.var</File>
    <File Description="Simulation handling">SimulationControl.st</File>
    <File Description="Code that is specific to this axis">AxisControlModes.st</File>
    <File Description="Functions for manual/automatic command" Private="true">LocalFunctions.fun</File>
    <File Description="Defines conditions for manual mode">ManualCommand.st</File>
    <File Description="Defines conditions for automatic mode">AutomaticCommand.st</File>
    <File Description="Local variables, used for all axes" Private="true" Reference="true">\Logical\MachineControl\AxisReferencedFiles\AxisMgr.var</File>
    <File Description="Local data types" Private="true" Reference="true">\Logical\MachineControl\AxisReferencedFiles\AxisMgr.typ</File>
    <File Description="Generic state machine, used for all axes" Reference="true">\Logical\MachineControl\AxisReferencedFiles\AxisStateMachine.st</File>
    <File Description="Changes the axis configuration at runtime" Reference="true">\Logical\MachineControl\AxisReferencedFiles\ChangeConfiguration.st</File>
    <File Description="Recipe handling" Reference="true">\Logical\MachineControl\AxisReferencedFiles\Recipe.st</File>
  </Files>
</Program>