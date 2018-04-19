[WindowColor]
Measure=Registry
RegHKey=HKEY_CURRENT_USER
RegKey=SOFTWARE\Microsoft\Windows\DWM
RegValue=ColorizationColor
OnChangeAction=[!UpdateMeasure SetColors]
UpdateDivider=400