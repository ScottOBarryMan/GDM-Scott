rem Project Native_AER_Active_In_Situ_Scheme_Approval_Well_List_Bulk_Load
rem File location: Active_In_Situ_Scheme_Approval_Well_List_File
rem Custome workspace: \\olympus\FileVault\Native\AER\Active_In_Situ_Scheme_Approval_Well_List\Newfile
@echo off
ren %WORKSPACE%\Active_In_Situ_Scheme_Approval_Well_List_File %Active_In_Situ_Scheme_Approval_Well_List_File%
If not exist %WORKSPACE%\%Active_In_Situ_Scheme_Approval_Well_List_File% (
  Echo Active_In_Situ_Scheme_Approval_Well_List_File %Active_In_Situ_Scheme_Approval_Well_List_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_active_in_situ_scheme_approval_well_list.py" -f "\\olympus\FileVault\Native\AER\Active_In_Situ_Scheme_Approval_Well_List\%Data_Currency%\%Active_In_Situ_Scheme_Approval_Well_List_File%" -t "t_AER_Active_In_Situ_Scheme_Approval_Well_List"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_Performance_Presentation_Bulk_Load
rem File location: Performance_Presentation_File
rem Custome workspace: \\olympus\FileVault\Native\AER\Performance_Presentation\Newfile
@echo off
ren %WORKSPACE%\Performance_Presentation_File %Performance_Presentation_File%
If not exist %WORKSPACE%\%Performance_Presentation_File% (
  Echo Performance_Presentation_File %Performance_Presentation_File% does not exist. Load terminated.
  Exit 1
)

if not exist \\olympus\FileVault\Native\AER\Performance_Presentation\%Data_Currency% (
  ren %WORKSPACE% %Data_Currency%
) else move %WORKSPACE%\%Performance_Presentation_File% \\olympus\FileVault\Native\AER\Performance_Presentation\%Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_performance_presentation.py" -f "\\olympus\FileVault\Native\AER\Performance_Presentation\%Data_Currency%\%Performance_Presentation_File%" -t "t_AER_Performance_Presentation"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_Scheme_Approval_Spatial_Bulk_Load
rem File location: Scheme_Approval_Spatial_Zip_File
rem Custom workspace: \\olympus\FileVault\Native\AER\Scheme_Approval_Spatial\Newfile
@echo off
ren %WORKSPACE%\Scheme_Approval_Spatial_Zip_File %Scheme_Approval_Spatial_Zip_File%
If not exist %WORKSPACE%\%Scheme_Approval_Spatial_Zip_File% (
  Echo Scheme_Approval_Spatial_Zip_File %Scheme_Approval_Spatial_Zip_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('\\olympus\FileVault\Native\AER\Scheme_Approval_Spatial\%Data_Currency%\%Scheme_Approval_Spatial_Zip_File%', '\\olympus\FileVault\Native\AER\Scheme_Approval_Spatial\%Data_Currency%'); }"

call activate base
python "%PYTHON%\loaders\native\load_aer_shp_scheme_approval_spatial.py" -f "\\olympus\FileVault\Native\AER\Scheme_Approval_Spatial\%Data_Currency%" -t "t_AER_Scheme_Approval_Spatial_"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_ST103_Field_Pool_List_Bulk_Load
rem File location: ST103_Field_Pool_List_File
rem Custom workspace: \\olympus\FileVault\Native\AER\ST103_Field_Pool_List\Newfile
@echo off
ren %WORKSPACE%\ST103_Field_Pool_List_File %ST103_Field_Pool_List_File%
  If not exist %WORKSPACE%\%ST103_Field_Pool_List_File% (
  Echo ST103_Field_Pool_List_File %ST103_Field_Pool_List_File% does not exist. Load terminated.
Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_st103_field_pool_list.py" -f "\\olympus\FileVault\Native\AER\ST103_Field_Pool_List\%Data_Currency%\%ST103_Field_Pool_List_File%" -t "t_AER_ST103_Field_Pool_List"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_ST39_Bulk_Load
rem File location: ST39_File
rem Custom workspace: \\olympus\FileVault\Native\AER\ST39\Newfile
@echo off
ren %WORKSPACE%\ST39_File %ST39_File%
If not exist %WORKSPACE%\%ST39_File% (
  Echo ST39_File %ST39_File% does not exist. Load terminated.
Exit 1
)

if not exist \\olympus\FileVault\Native\AER\ST39\%Data_Currency% (
  ren %WORKSPACE% %Data_Currency%
) else move %WORKSPACE%\%ST39_File% \\olympus\FileVault\Native\AER\ST39\%Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_st39.py" -f "\\olympus\FileVault\Native\AER\ST39\%Data_Currency%\%ST39_File%" -t "t_AER_ST39_"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_ST44_Bulk_Load
rem File location: ST44_File
rem Custom workspace: \\olympus\FileVault\Native\AER\ST44\Newfile
@echo off
ren %WORKSPACE%\ST44_File %ST44_File%
  If not exist %WORKSPACE%\%ST44_File% (
  Echo ST44_File %ST44_File% does not exist. Load terminated.
Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_st44.py" -f "\\olympus\FileVault\Native\AER\ST44\%Data_Currency%\%ST44_File%" -t "t_AER_ST44_"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_AER_ST53_Bulk_Load
rem File location: ST53_File
rem Custom workspace: \\olympus\FileVault\Native\AER\ST53\Newfile
@echo off
ren %WORKSPACE%\ST53_File %ST53_File%
  If not exist %WORKSPACE%\%ST53_File% (
  Echo ST53_File %ST53_File% does not exist. Load terminated.
Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_st53.py" -f "\\olympus\FileVault\Native\AER\ST53\%Data_Currency%\%ST53_File%" -t "t_AER_ST53_"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_EIA_Ref_Cap_Bulk_Load
rem File location: Ref_Cap_File
rem Custom workspace: \\olympus\FileVault\Native\EIA\Ref_Cap\Newfile
@echo off
ren %WORKSPACE%\Ref_Cap_File %Ref_Cap_File%
  If not exist %WORKSPACE%\%Ref_Cap_File% (
  Echo Ref_Cap_File %Ref_Cap_File% does not exist. Load terminated.
Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_eia_xls_refcap.py" -f "\\olympus\FileVault\Native\EIA\Ref_Cap\%Data_Currency%\%Ref_Cap_File%" -t "t_EIA_Ref_Cap"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Native_EIA_US_Liquefaction_Capacity_A_Bulk_Load
rem File location: US_Liquefaction_Capacity_File
rem Custom workspace: \\olympus\FileVault\Native\EIA\US_Liquefaction_Capacity\Newfile
@echo off
ren %WORKSPACE%\US_Liquefaction_Capacity_File %US_Liquefaction_Capacity_File%
If not exist %WORKSPACE%\%US_Liquefaction_Capacity_File% (
  Echo US_Liquefaction_Capacity_File %US_Liquefaction_Capacity_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_eia_xlsx_us_liquefaction_capacity.py" -f "\\olympus\FileVault\Native\EIA\US_Liquefaction_Capacity\%Data_Currency%\%US_Liquefaction_Capacity_File%" -t "t_EIA_US_Liquefaction_Capacity_"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_HIFLD_Liquified_Natural_Gas_Import_Export_And_Terminals_Bulk_Load
rem File location: Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File
rem Custom workspace: \\olympus\FileVault\Native\HIFLD\Liquified_Natural_Gas_Import_Export_And_Terminals\Newfile
@echo off
ren %WORKSPACE%\Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File %Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File%
If not exist %WORKSPACE%\%Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File% (
  Echo Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File %Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('\\olympus\FileVault\Native\HIFLD\Liquified_Natural_Gas_Import_Export_And_Terminals\%Data_Currency%\%Liquified_Natural_Gas_Import_Export_And_Terminals_Zip_File%', '\\olympus\FileVault\Native\HIFLD\Liquified_Natural_Gas_Import_Export_And_Terminals\%Data_Currency%'); }"

call activate base
python "%PYTHON%\loaders\native\load_hifld_shp_liquified_natural_gas_import_export_and_terminals.py" -f "\\olympus\FileVault\Native\HIFLD\Liquified_Natural_Gas_Import_Export_And_Terminals\%Data_Currency%" -t "t_HIFLD_Liquified_Natural_Gas_Import_Exports_And_Terminals"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_HIFLD_Oil_Refineries_Bulk_Load
rem File location: Oil_Refineries_Zip_File
rem Custom workspace: \\olympus\FileVault\Native\HIFLD\Oil_Refineries\Newfile
@echo off
ren %WORKSPACE%\Oil_Refineries_Zip_File %Oil_Refineries_Zip_File%
If not exist %WORKSPACE%\%Oil_Refineries_Zip_File% (
  Echo Oil_Refineries_Zip_File %Oil_Refineries_Zip_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('\\olympus\FileVault\Native\HIFLD\Oil_Refineries\%Data_Currency%\%Oil_Refineries_Zip_File%', '\\olympus\FileVault\Native\HIFLD\Oil_Refineries\%Data_Currency%'); }"

call activate base
python "%PYTHON%\loaders\native\load_hifld_shp_oil_refineries.py" -f "\\olympus\FileVault\Native\HIFLD\Oil_Refineries\%Data_Currency%" -t "t_HIFLD_Oil_Refineries"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_NRCAN_Liquefied_Natural_Gas_Terminals_Bulk_Load
rem File location: Liquefied_Natural_Gas_Terminals_File
rem Custom workspace: \\olympus\FileVault\Native\NRCAN\Liquefied_Natural_Gas_Terminals\Newfile
@echo off
ren %WORKSPACE%\Liquefied_Natural_Gas_Terminals_File %Liquefied_Natural_Gas_Terminals_File%
If not exist %WORKSPACE%\%Liquefied_Natural_Gas_Terminals_File% (
  Echo Liquefied_Natural_Gas_Terminals_File %Liquefied_Natural_Gas_Terminals_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_nrcan_csv_liquefied_natural_gas_terminals.py" -f "\\olympus\FileVault\Native\NRCAN\Liquefied_Natural_Gas_Terminals\%Data_Currency%\%Liquefied_Natural_Gas_Terminals_File%" -t "t_NRCAN_Liquefied_Natural_Gas_Terminals"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_NRCAN_Refineries_Bulk_Load
rem File location: Refineries_File
rem Custom workspace: \\olympus\FileVault\Native\NRCAN\Refineries\Newfile
@echo off
ren %WORKSPACE%\Refineries_File %Refineries_File%
If not exist %WORKSPACE%\%Refineries_File% (
  Echo Refineries_File %Refineries_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_nrcan_csv_refineries.py" -f "\\olympus\FileVault\Native\NRCAN\Refineries\%Data_Currency%\%Refineries_File%" -t "t_NRCAN_Refineries"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_PETRINEX_PRA_Oil_Sands_Area_Codes_Bulk_Load
rem File location: PRA_Oil_Sands_Area_Codes_File
rem Custom workspace: \\olympus\FileVault\Native\PETRINEX\PRA_Oil_Sands_Area_Codes_File\Newfile
@echo off
ren %WORKSPACE%\PRA_Oil_Sands_Area_Codes_File %PRA_Oil_Sands_Area_Codes_File%
If not exist %WORKSPACE%\%PRA_Oil_Sands_Area_Codes_File% (
  Echo PRA_Oil_Sands_Area_Codes_File %PRA_Oil_Sands_Area_Codes_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_petrinex_csv_pra_oilsands_area_codes.py" -f "\\olympus\FileVault\Native\PETRINEX\PRA_Oil_Sands_Area_Codes_File\%Data_Currency%\%PRA_Oil_Sands_Area_Codes_File%" -t "t_PETRINEX_PRA_Oil_Sands_Area_Codes"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated

rem ----------------------------------------------------------------------------------------------------------------------------------

rem Project Project Native_PETRINEX_PRA_Oil_Sands_Area_Deposit_Codes_Bulk_Load
rem File location: PRA_Oil_Sands_Area_Deposit_Codes_File
rem Custom workspace: \\olympus\FileVault\Native\PETRINEX\PRA_Oil_Sands_Area_Deposit_Codes\Newfile
@echo off
ren %WORKSPACE%\PRA_Oil_Sands_Area_Deposit_Codes_File %PRA_Oil_Sands_Area_Deposit_Codes_File%
If not exist %WORKSPACE%\%PRA_Oil_Sands_Area_Deposit_Codes_File% (
  Echo PRA_Oil_Sands_Area_Deposit_Codes_File %PRA_Oil_Sands_Area_Deposit_Codes_File% does not exist. Load terminated.
  Exit 1
)
ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_petrinex_csv_pra_oilsands_area_deposit_codes.py" -f "\\olympus\FileVault\Native\PETRINEX\PRA_Oil_Sands_Area_Deposit_Codes\%Data_Currency%\%PRA_Oil_Sands_Area_Deposit_Codes_File%" -t "t_PETRINEX_PRA_Oil_Sands_Area_Deposit_Codes"

rem Test Bulk loader --> passed
rem Test SRC Table --> passed
rem Job updated
