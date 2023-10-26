module EnhancedScanner.DefaultToDataTab

// SETTINGS
public class DefaultToDataTabConfig {
  @runtimeProperty("ModSettings.mod", "Enhanced Scanner")
  @runtimeProperty("ModSettings.category", "")
  @runtimeProperty("ModSettings.displayName", "Default to Data Tab")
  @runtimeProperty("ModSettings.description", "OFF: hack tab is always default. NON-COMBAT: data tab is default when out of combat. ALWAYS: data tab is always default.")
  @runtimeProperty("ModSettings.displayValues.Off", "Off")
  @runtimeProperty("ModSettings.displayValues.NonCombat", "Only out of combat")
  @runtimeProperty("ModSettings.displayValues.Always", "Always")
  let defaultToDataTab: DefaultToDataTabEnum = DefaultToDataTabEnum.Off;
}

enum DefaultToDataTabEnum {
  Off = 0,
  NonCombat = 1,
  Always = 2
}

// START OF MOD CODE
@wrapMethod(scannerDetailsGameController) // extends inkHUDGameController
protected cb func OnScannerDetailsShown(animationProxy:ref<inkAnimProxy>) {
  wrappedMethod(animationProxy);
  let configSettings = new DefaultToDataTabConfig();
  if Equals(configSettings.defaultToDataTab, DefaultToDataTabEnum.Always)
  || ( Equals(configSettings.defaultToDataTab, DefaultToDataTabEnum.NonCombat)
    && this.GetPSMBlackboard(this.GetPlayerControlledObject()).GetInt(GetAllBlackboardDefs().PlayerStateMachine.Combat) != EnumInt(gamePSMCombat.InCombat) ) {

    this.SetTab(ScannerDetailTab.Data, true);
  };
}