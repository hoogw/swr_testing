USE [sidewalk_repair]
GO
/****** Object:  Table [dbo].[ReportLabel]    Script Date: 5/8/2018 6:56:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportLabel](
	[COLUMN_NAME] [nvarchar](128) NULL,
	[DATA_TYPE] [nvarchar](128) NULL,
	[NAME] [nvarchar](128) NULL,
	[Sort_Order] [int] NULL,
	[Sort_Group] [int] NULL,
	[Category] [nvarchar](50) NULL,
	[Full_Sort] [int] NULL,
	[hdrk] [int] NOT NULL
) ON [PRIMARY]

GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TRAFFIC_CONTROL_AND_PERMITS_UNITS', N'nvarchar', N'TRAFFIC_CONTROL_AND_PERMITS', 2, 1, N'General Conditions / General Requirments', 0, 5)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'MOBILIZATION_UNITS', N'nvarchar', N'MOBILIZATION', 1, 1, N'General Conditions / General Requirments', 0, 2)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TEMPORARY_DRAINAGE_INLET_PROTECTION_UNITS', N'nvarchar', N'TEMPORARY_DRAINAGE_INLET_PROTECTION', 3, 1, N'General Conditions / General Requirments', 0, 8)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_SIDEWALK_UNITS', N'nvarchar', N'REMOVE_SIDEWALK', 4, 2, N'Demolition & Removals', 0, 11)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_CURB_UNITS', N'nvarchar', N'REMOVE_CURB', 5, 2, N'Demolition & Removals', 0, 14)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_CURB_AND_GUTTER_UNITS', N'nvarchar', N'REMOVE_CURB_AND_GUTTER', 6, 2, N'Demolition & Removals', 0, 17)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_DRIVEWAY_UNITS', N'nvarchar', N'REMOVE_DRIVEWAY', 7, 2, N'Demolition & Removals', 0, 20)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY_UNITS', N'nvarchar', N'FOUR_INCH_CONCRETE_SIDEWALK_AND_DRIVEWAY', 10, 3, N'Concrete (Sidewalks & Driveways)', 0, 23)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'CONCRETE_CURB_UNITS', N'nvarchar', N'CONCRETE_CURB', 11, 3, N'Concrete (Sidewalks & Driveways)', 0, 26)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'CONCRETE_CURB_AND_GUTTER_UNITS', N'nvarchar', N'CONCRETE_CURB_AND_GUTTER', 12, 3, N'Concrete (Sidewalks & Driveways)', 0, 29)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___UNITS', N'nvarchar', N'FOUR_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH__', 13, 3, N'Concrete (Sidewalks & Driveways)', 0, 32)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK_UNITS', N'nvarchar', N'SIX_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK', 14, 3, N'Concrete (Sidewalks & Driveways)', 0, 35)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH___UNITS', N'nvarchar', N'EIGHT_INCH_CONCRETE_DRIVEWAY_AND_SIDEWALK__EARLY_HIGH_STRENGTH__', 15, 3, N'Concrete (Sidewalks & Driveways)', 0, 38)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'CONCRETE_GRINDING_UNITS', N'nvarchar', N'CONCRETE_GRINDING', 22, 3, N'Concrete (Sidewalks & Driveways)', 0, 41)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_UNITS', N'nvarchar', N'FOUR_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY', 16, 3, N'Concrete (Sidewalks & Driveways)', 0, 44)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'SIX_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY_UNITS', N'nvarchar', N'SIX_INCH_PATTERNED_l_DECORATIVE_l_BRICK_SIDEWALK_AND_DRIVEWAY', 17, 3, N'Concrete (Sidewalks & Driveways)', 0, 47)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'CURB_RAMP__ADA_COMPLIANT___UNITS', N'nvarchar', N'CURB_RAMP__ADA_COMPLIANT__', 18, 3, N'Concrete (Sidewalks & Driveways)', 0, 50)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'BACKFILL_DECOMPOSED_GRANITE_UNITS', N'nvarchar', N'BACKFILL_DECOMPOSED_GRANITE', 25, 4, N'Trees & Landscaping', 0, 56)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TREE_ROOT_PRUNING_l_SHAVING__PER_TREE___UNITS', N'nvarchar', N'TREE_ROOT_PRUNING_l_SHAVING__PER_TREE__', 26, 4, N'Trees & Landscaping', 0, 59)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TREE_CANOPY_PRUNING__PER_TREE___UNITS', N'nvarchar', N'TREE_CANOPY_PRUNING__PER_TREE__', 27, 4, N'Trees & Landscaping', 0, 62)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'INSTALL_ROOT_CONTROL_BARRIER_UNITS', N'nvarchar', N'INSTALL_ROOT_CONTROL_BARRIER', 28, 4, N'Trees & Landscaping', 0, 65)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_METAL_TREE_WELL_GRATES_UNITS', N'nvarchar', N'REMOVE_METAL_TREE_WELL_GRATES', 29, 4, N'Trees & Landscaping', 0, 68)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'BIKE_RACK__REMOVE_AND_REINSTALL___UNITS', N'nvarchar', N'BIKE_RACK__REMOVE_AND_REINSTALL__', 62, 6, N'Miscellaneous Items', 0, 74)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'STREET_SIGN__REMOVE_AND_REINSTALL___UNITS', N'nvarchar', N'STREET_SIGN__REMOVE_AND_REINSTALL__', 63, 6, N'Miscellaneous Items', 0, 77)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_NEW_SIGN_POST_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_NEW_SIGN_POST', 64, 6, N'Miscellaneous Items', 0, 80)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'NEWSPAPER_DISPENSER_OR_TRASH_BIN__REMOVE_AND_REINSTALL___UNITS', N'nvarchar', N'NEWSPAPER_DISPENSER_OR_TRASH_BIN__REMOVE_AND_REINSTALL__', 65, 6, N'Miscellaneous Items', 0, 83)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'PARKING_METER__REMOVE_AND_REINSTALL___UNITS', N'nvarchar', N'PARKING_METER__REMOVE_AND_REINSTALL__', 66, 6, N'Miscellaneous Items', 0, 86)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'MODIFY_EXISTING_IRRIGATION_SYSTEM_UNITS', N'nvarchar', N'MODIFY_EXISTING_IRRIGATION_SYSTEM', 31, 4, N'Trees & Landscaping', 0, 89)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'ADJUST_UTILITY_MAINTENANCE_HOLE_TO_GRADE_UNITS', N'nvarchar', N'ADJUST_UTILITY_MAINTENANCE_HOLE_TO_GRADE', 38, 5, N'Utilities', 0, 92)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'ADJUST_UTILITY_PULLBOX_TO_GRADE_UNITS', N'nvarchar', N'ADJUST_UTILITY_PULLBOX_TO_GRADE', 39, 5, N'Utilities', 0, 95)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'ADJUST_UTILITY_VAULT_TO_GRADE_UNITS', N'nvarchar', N'ADJUST_UTILITY_VAULT_TO_GRADE', 40, 5, N'Utilities', 0, 98)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'ADJUST_WATER_l_GAS_METER_l_VENT_TO_GRADE_UNITS', N'nvarchar', N'ADJUST_WATER_l_GAS_METER_l_VENT_TO_GRADE', 41, 5, N'Utilities', 0, 101)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_6_INCH_DIAMETER_CONCRETE_VALVE_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_6_INCH_DIAMETER_CONCRETE_VALVE', 42, 5, N'Utilities', 0, 104)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_STREET_LIGHTING_PULLBOX_WITH_LID__COMPOSITE_TYPE_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_STREET_LIGHTING_PULLBOX_WITH_LID__COMPOSITE_TYPE_2__', 43, 5, N'Utilities', 0, 107)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_STREET_LIGHTING_PULLBOX_WITH_LID__COMPOSITE_TYPE_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_STREET_LIGHTING_PULLBOX_WITH_LID__COMPOSITE_TYPE_3__', 44, 5, N'Utilities', 0, 110)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_TRAFFIC_SIGNAL_PULLBOX_WITH_LID__TYPE_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_TRAFFIC_SIGNAL_PULLBOX_WITH_LID__TYPE_2__', 45, 5, N'Utilities', 0, 113)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_TRAFFIC_SIGNAL_PULLBOX_WITH_LID__TYPE_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_TRAFFIC_SIGNAL_PULLBOX_WITH_LID__TYPE_3__', 46, 5, N'Utilities', 0, 116)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_10_INCH_X_15_INCH_DWP_METER_BOX_WITH_LID_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_10_INCH_X_15_INCH_DWP_METER_BOX_WITH_LID', 47, 5, N'Utilities', 0, 119)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_METER_BOX_WITH_COMPOSITE_LID__NO_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_METER_BOX_WITH_COMPOSITE_LID__NO_2__', 48, 5, N'Utilities', 0, 122)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_METER_BOX_WITH_COMPOSITE_LID__NO_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_METER_BOX_WITH_COMPOSITE_LID__NO_3__', 49, 5, N'Utilities', 0, 125)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_METER_BOX_WITH_STEEL_LID__NO_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_METER_BOX_WITH_STEEL_LID__NO_2__', 50, 5, N'Utilities', 0, 128)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_METER_BOX_WITH_STEEL_LID__NO_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_METER_BOX_WITH_STEEL_LID__NO_3__', 51, 5, N'Utilities', 0, 131)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_COMPOSITE_WATER_METER_LID__NO_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_COMPOSITE_WATER_METER_LID__NO_2__', 52, 5, N'Utilities', 0, 134)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_COMPOSITE_WATER_METER_LID__NO_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_COMPOSITE_WATER_METER_LID__NO_3__', 53, 5, N'Utilities', 0, 137)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_STEEL_WATER_METER_LID__NO_2___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_STEEL_WATER_METER_LID__NO_2__', 54, 5, N'Utilities', 0, 140)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_STEEL_WATER_METER_LID__NO_3___UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_STEEL_WATER_METER_LID__NO_3__', 55, 5, N'Utilities', 0, 143)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_4_FEET_X_6_FEET_DWP_VAULT_WITH_TORSION_ASSIST_COVER_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_4_FEET_X_6_FEET_DWP_VAULT_WITH_TORSION_ASSIST_COVER', 56, 5, N'Utilities', 0, 146)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_4_FEET_X_6_FEET_DWP_POLYMER_CONCRETE_VAULT_ASSEMBLY_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_4_FEET_X_6_FEET_DWP_POLYMER_CONCRETE_VAULT_ASSEMBLY', 57, 5, N'Utilities', 0, 149)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_4_FEET_X_4_FEET_DWP_VAULT_WITH_TORSION_COVER_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_4_FEET_X_4_FEET_DWP_VAULT_WITH_TORSION_COVER', 58, 5, N'Utilities', 0, 152)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_4_FEET_X_4_FEET_DWP_POLYMER_CONCRETE_VAULT_ASSEMBLY_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_4_FEET_X_4_FEET_DWP_POLYMER_CONCRETE_VAULT_ASSEMBLY', 59, 5, N'Utilities', 0, 155)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_4_FEET_X_8_FEET_DWP_VAULT_WITH_TORSION_ASSIST_COVER_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_4_FEET_X_8_FEET_DWP_VAULT_WITH_TORSION_ASSIST_COVER', 60, 5, N'Utilities', 0, 158)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'CAST_IN_PLACE_DWP_WATER_METER_BOX__TYPE_2_OR_TYPE_3___UNITS', N'nvarchar', N'CAST_IN_PLACE_DWP_WATER_METER_BOX__TYPE_2_OR_TYPE_3__', 61, 5, N'Utilities', 0, 161)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REMOVE_ASPHALT_UNITS', N'nvarchar', N'REMOVE_ASPHALT', 8, 2, N'Demolition & Removals', 0, 164)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXCAVATION_UNITS', N'nvarchar', N'EXCAVATION', 9, 2, N'Demolition & Removals', 0, 167)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'UNTREATED_BASE_MATERIAL_UNITS', N'nvarchar', N'UNTREATED_BASE_MATERIAL', 20, 3, N'Concrete (Sidewalks & Driveways)', 0, 170)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'ASPHALT_CONCRETE_UNITS', N'nvarchar', N'ASPHALT_CONCRETE', 21, 3, N'Concrete (Sidewalks & Driveways)', 0, 173)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EPOXY_CONCRETE_PATCH_UNITS', N'nvarchar', N'EPOXY_CONCRETE_PATCH', 23, 3, N'Concrete (Sidewalks & Driveways)', 0, 176)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___UNITS', N'nvarchar', N'TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER__', 33, 4, N'Trees & Landscaping', 0, 179)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___UNITS', N'nvarchar', N'TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER__', 34, 4, N'Trees & Landscaping', 0, 182)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXISTING_STUMP_REMOVAL_UNITS', N'nvarchar', N'EXISTING_STUMP_REMOVAL', 35, 4, N'Trees & Landscaping', 0, 185)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_UNITS', N'nvarchar', N'FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE', 36, 4, N'Trees & Landscaping', 0, 188)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH_UNITS', N'nvarchar', N'WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH', 37, 4, N'Trees & Landscaping', 0, 191)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_DETECTABLE_WARNING_PANEL_ON_EXISTING_RAMP_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_DETECTABLE_WARNING_PANEL_ON_EXISTING_RAMP', 19, 3, N'Concrete (Sidewalks & Driveways)', 0, 53)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT_UNITS', N'nvarchar', N'FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT', 30, 4, N'Trees & Landscaping', 0, 71)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'PARKWAY_CULVERT_SIDEWALK_DRAIN_UNITS', N'nvarchar', N'PARKWAY_CULVERT_SIDEWALK_DRAIN', 67, 6, N'Miscellaneous Items', 0, 194)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FOUR_INCH_DIAMETER_SCHEDULE_80_PVC_PIPE_UNITS', N'nvarchar', N'FOUR_INCH_DIAMETER_SCHEDULE_80_PVC_PIPE', 68, 6, N'Miscellaneous Items', 0, 197)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'SIX_INCH_DIAMETER_SCHEDULE_80_PVC_PIPE_UNITS', N'nvarchar', N'SIX_INCH_DIAMETER_SCHEDULE_80_PVC_PIPE', 69, 6, N'Miscellaneous Items', 0, 200)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'RECTANGULAR_METAL_PIPE_UNITS', N'nvarchar', N'RECTANGULAR_METAL_PIPE', 70, 6, N'Miscellaneous Items', 0, 203)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'BOLLARD__REMOVE___UNITS', N'nvarchar', N'BOLLARD__REMOVE__', 71, 6, N'Miscellaneous Items', 0, 206)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'BOLLARD__REMOVE_AND_REINSTALL___UNITS', N'nvarchar', N'BOLLARD__REMOVE_AND_REINSTALL__', 72, 6, N'Miscellaneous Items', 0, 209)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'FURNISH_AND_INSTALL_BOLLARD_UNITS', N'nvarchar', N'FURNISH_AND_INSTALL_BOLLARD', 73, 6, N'Miscellaneous Items', 0, 212)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'REIMBURSEMENT_FOR_BUS_SHELTER_REMOVAL_AND_REINSTALLATION_UNITS', N'nvarchar', N'REIMBURSEMENT_FOR_BUS_SHELTER_REMOVAL_AND_REINSTALLATION', 74, 6, N'Miscellaneous Items', 0, 215)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'PAINT__CURB___UNITS', N'nvarchar', N'PAINT__CURB__', 75, 6, N'Miscellaneous Items', 0, 218)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'TOP_SOIL_UNITS', N'nvarchar', N'TOP_SOIL', 32, 4, N'Trees & Landscaping', 0, 221)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK_UNITS', N'nvarchar', N'SIX_INCH_PERVIOUS_CONCRETE_SIDEWALK', 24, 3, N'Concrete (Sidewalks & Driveways)', 0, 224)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_1_UNITS', N'nvarchar', N'EXTRA_FIELD_1', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_2_UNITS', N'nvarchar', N'EXTRA_FIELD_2', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_3_UNITS', N'nvarchar', N'EXTRA_FIELD_3', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_4_UNITS', N'nvarchar', N'EXTRA_FIELD_4', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_5_UNITS', N'nvarchar', N'EXTRA_FIELD_5', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_6_UNITS', N'nvarchar', N'EXTRA_FIELD_6', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_7_UNITS', N'nvarchar', N'EXTRA_FIELD_7', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_8_UNITS', N'nvarchar', N'EXTRA_FIELD_8', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_9_UNITS', N'nvarchar', N'EXTRA_FIELD_9', NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[ReportLabel] ([COLUMN_NAME], [DATA_TYPE], [NAME], [Sort_Order], [Sort_Group], [Category], [Full_Sort], [hdrk]) VALUES (N'EXTRA_FIELD_10_UNITS', N'nvarchar', N'EXTRA_FIELD_10', NULL, NULL, NULL, 1, 1)
GO
