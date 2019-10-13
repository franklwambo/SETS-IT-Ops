--********************************************Anc.CCC_baseline***************************************************************************************************************************************
INSERT into clarice.[Anc].[baseline] (
       [system_id] ,[art_startyear],[art_startmonth],[art_startday]
      ,[hiv_positive_date],[source_department],[created_at],[created_by]
      ,[modified_at] ,[modified_by] ,[rowguid] ,[baseline_reference_id])
      
SELECT [system_id] ,[art_startyear],[art_startmonth],[art_startday]
      ,[hiv_positive_date],[source_department],[created_at],[created_by]
      ,[modified_at] ,[modified_by] ,[rowguid] ,[baseline_reference_id]
	  
FROM opinya.[Anc].[baseline] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[baseline] b 
where b.[baseline_reference_id]  = n.[baseline_reference_id]  )

--********************************************Anc.CCC_logs***************************************************************************************************************************************
INSERT into clarice.[Anc].[ccc_logs] (
       [visit_log_id],[system_id],[visit_date],[created_at],[sent_flag])
      
SELECT [visit_log_id],[system_id],[visit_date],[created_at],[sent_flag]
	  
FROM opinya.[Anc].[ccc_logs] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[ccc_logs] b 
where b.[visit_log_id] COLLATE database_default = n.visit_log_id COLLATE database_default )

--******************************************************************CCC TREATMENT ADHERENCE**********************************************************************************************************************

INSERT INTO clarice.[Anc].[ccc_treatment_adherence]
           ([system_id],[adherence_category],[why_adherence_fairpoor],[created_at],[created_by],[modified_at] ,[modified_by],[ccc_visit_id],rowguid)
SELECT      [system_id],[adherence_category],[why_adherence_fairpoor],[created_at],[created_by],[modified_at] ,[modified_by],[ccc_visit_id],rowguid
FROM opinya.[Anc].[ccc_treatment_adherence] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[ccc_treatment_adherence] b 
where  b.rowguid = n.rowguid  )

--******************************************************************ANC_CCC_Visits**********************************************************************************************************************

INSERT INTO clarice.[Anc].[ccc_visits]
           ([system_id],[visit_year] ,[visit_month] ,[visit_day],[visit_type]
      ,[created_at] ,[created_by] ,[modified_at],[modified_by],[rowguid])
SELECT      [system_id],[visit_year] ,[visit_month] ,[visit_day],[visit_type]
      ,[created_at] ,[created_by] ,[modified_at],[modified_by],[rowguid]
FROM [opinya].[Anc].[ccc_visits] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[ccc_visits] b 
where b.[rowguid]  = n.[rowguid]  )

--************************************ANC CLINICAL OBSERVATIONS***********************************************************************************************************************************************
INSERT into clarice.[Anc].[clinical_observations] (
          [system_id] ,[syphilis],[haemoglobin],[cd4_count],[who_stage],[art_start_date],[tb_status],[cancer_screening_method],
          [cervical_cancer_screening],[created_at],[created_by],[modified_at],[modified_by],[visit_id] ,[anc_visit_id],[viral_load] ,[entry_id])
SELECT [system_id] ,[syphilis],[haemoglobin],[cd4_count],[who_stage],[art_start_date],[tb_status],[cancer_screening_method],
       [cervical_cancer_screening],[created_at],[created_by],[modified_at],[modified_by],[visit_id] ,[anc_visit_id],[viral_load] ,[entry_id]
FROM opinya.[Anc].[clinical_observations] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[clinical_observations] b 
where --b.[anc_visit_id] COLLATE database_default = n.anc_visit_id COLLATE database_default
 b.entry_id=n.entry_id )



--******************************************************************ANC_Consent**********************************************************************************************************************

INSERT INTO clarice.[Anc].[consent]
           ([system_id],[consent_type],[consent_value]
      ,[date_consented],[involved_user],[consent_id],[rowguid])
SELECT      [system_id],[consent_type],[consent_value]
      ,[date_consented],[involved_user],[consent_id],[rowguid]
FROM [opinya].[Anc].[consent] n
where NOT EXISTS (SELECT * FROM clarice.[Anc].[consent] b 
where b.[consent_id]  = n.[consent_id]  )











--***************************************************Anc.[dtl_anc_records_availability]*******************************************************************************************************************************
INSERT into clarice.Anc.[dtl_anc_records_availability] (
          
      [System_id],[Status],[Unavailability_reason],[Date_created],[Created_by]  )
SELECT 
      [System_id],[Status],[Unavailability_reason],[Date_created],[Created_by] 
FROM opinya.Anc.[dtl_anc_records_availability] n
where NOT EXISTS (SELECT * FROM clarice.Anc.[dtl_anc_records_availability] b 
where b.[System_id] COLLATE database_default = n.System_id COLLATE database_default 
and  b.[Date_created]  = n.Date_created )

--************************************************** [Anc].[dtl_ccc_records_availability]**********************************************************************************************************************************
INSERT INTO clarice.[Anc].[dtl_ccc_records_availability]
           ([System_id],[Status],[Unavailability_reason],[Date_created],[Created_by])
           
   SELECT [System_id],[Status],[Unavailability_reason],[Date_created],[Created_by]
    
FROM opinya.[Anc].[dtl_ccc_records_availability] n
    
where NOT EXISTS (SELECT * FROM clarice.[Anc].[dtl_ccc_records_availability] b 

where b.[system_id] COLLATE database_default = n.system_id COLLATE database_default 
and  b.[Date_created]  = n.Date_created )

--***********************************************************************ANC-LAB****************************************************************************************************************
INSERT INTO clarice.[Anc].[dtl_lab] (
           [system_id],[lab_code],[lab_value] ,[lab_year] ,[lab_month] ,[lab_day]
            ,[created_at] ,[created_by],[modified_at],[modified_by],ccc_visit_id, rowguid
           )
SELECT [system_id],[lab_code],[lab_value] ,[lab_year] ,[lab_month] ,[lab_day]
      ,[created_at] ,[created_by],[modified_at],[modified_by],[ccc_visit_id] ,rowguid

FROM opinya.[Anc].[dtl_lab] n
   
where NOT EXISTS (SELECT * FROM clarice.[Anc].[dtl_lab] b  where b.rowguid = n.rowguid) 

----**************************************************************[Anc].[dtl_regimen]****************************************************************************
INSERT INTO clarice.[Anc].[dtl_regimen]
           ([system_id] ,[regimen_name] ,[date_created] ,[created_by] ,[date_modified],[modified_by],[ccc_visit_id] ,[in_gui_list],rowguid)
SELECT      [system_id] ,[regimen_name] ,[date_created] ,[created_by] ,[date_modified],[modified_by],[ccc_visit_id] ,[in_gui_list],rowguid

FROM opinya.[Anc].[dtl_regimen] n
   
where NOT EXISTS (SELECT * FROM clarice.[Anc].[dtl_regimen] b  where b.rowguid = n.rowguid ) 

--**************************************************************[Anc].[ord_pharmacy]******************************************************************************

INSERT INTO clarice.[Anc].[ord_pharmacy]
           ([system_id],[CTX_given],[Mother_NVP],[Mother_AZT],[Mother_HAART],[Baby_NVP],[created_at]
            ,[created_by],[modified_at],[modified_by],[visit_id],[anc_visit_id],[entry_id],rowguid)
 
SELECT [system_id],[CTX_given],[Mother_NVP],[Mother_AZT],[Mother_HAART],[Baby_NVP],[created_at]
        ,[created_by],[modified_at],[modified_by],[visit_id],[anc_visit_id],[entry_id],rowguid
           
FROM  opinya.[Anc].[ord_pharmacy] n
 
where NOT EXISTS (SELECT * FROM clarice.[Anc].[ord_pharmacy]  b where b.rowguid=n.rowguid   and b.entry_id=n.entry_id )


--***********************************************[Anc].[ord_treatment]**********************************************************************************************
INSERT INTO clarice.[Anc].[ord_treatment]
           ([system_id] ,[deworming] ,[Iptp_dose],[tt_dose],[iron],[folic_acid],[itn_dose]
            ,[created_at] ,[created_by] ,[modified_at],[modified_by] ,[visit_id],[anc_visit_id],[entry_id],rowguid
      )

SELECT [system_id] ,[deworming] ,[Iptp_dose],[tt_dose],[iron],[folic_acid],[itn_dose]
       ,[created_at] ,[created_by] ,[modified_at],[modified_by] ,[visit_id],[anc_visit_id],[entry_id],rowguid
      
           
FROM opinya.[Anc].[ord_treatment] n

where NOT EXISTS (SELECT * FROM clarice.[Anc].[ord_treatment] b  where b.entry_id = n.entry_id
and  b.rowguid = n.rowguid  )

--********************************************************************[Anc].[other_conditions]*******************************************************************
INSERT INTO clarice.[Anc].[other_conditions]
           ([system_id],[condition_name] ,[created_at] ,[created_by],[modified_at],
            [modified_by],[visit_id],[anc_visit_id] ,[entry_id],rowguid  )
SELECT
       [system_id],[condition_name] ,[created_at] ,[created_by],[modified_at],
       [modified_by],[visit_id],[anc_visit_id] ,[entry_id],rowguid  
           
FROM opinya.[Anc].[other_conditions] n

where NOT EXISTS (SELECT * FROM clarice.[Anc].[other_conditions] b  where b.entry_id = n.entry_id
and  b.rowguid  = n.rowguid  )

--***********************************************************[Anc].[other_treatment] *******************************************************************

INSERT INTO clarice.[Anc].[other_treatment]
           ([system_id] ,[treatment_name],[created_at] ,[created_by]
,[modified_at] ,[modified_by],[visit_id] ,[anc_visit_id],[entry_id])
SELECT  [system_id] ,[treatment_name],[created_at] ,[created_by]
,[modified_at] ,[modified_by],[visit_id] ,[anc_visit_id],[entry_id]  

FROM opinya.[Anc].[other_treatment] n

where NOT EXISTS (SELECT * FROM clarice.[Anc].[other_treatment] b  where b.entry_id = n.entry_id )




--*******************************************************[Anc].[person_metadata]***********************************************************************

INSERT INTO clarice.[Anc].[person_metadata]
           ([system_id] ,[ANC_study_id] ,[ANC_name] ,[counselled_as_couple] ,[partner_test_result]
,[ANC_ccc_number],[ANC_village] ,[first_hiv_test] ,[second_hiv_test] ,[first_negative_test_date]
,[created_at],[created_by],[modified_at],[modified_by],[is_anc_complete]  ,[is_ccc_complete]
 ,[sample_actually_drawn] ,[visit_id] ,[anc_visit_id] ,[anc_birth_day] ,[anc_birth_month] ,[anc_birth_year],[entry_id],rowguid)
     
SELECT   [system_id] ,[ANC_study_id] ,[ANC_name] ,[counselled_as_couple] ,[partner_test_result]
,[ANC_ccc_number],[ANC_village] ,[first_hiv_test] ,[second_hiv_test] ,[first_negative_test_date]
,[created_at],[created_by],[modified_at],[modified_by],[is_anc_complete]  ,[is_ccc_complete]
 ,[sample_actually_drawn] ,[visit_id] ,[anc_visit_id] ,[anc_birth_day] ,[anc_birth_month] ,[anc_birth_year],[entry_id],rowguid
FROM opinya.[Anc].[person_metadata] n

where NOT EXISTS (SELECT * FROM clarice.[Anc].[person_metadata] b  where b.rowguid = n.rowguid 
and  b.entry_id = n.entry_id  )

--**************************************************ANC VISITS***********************************************************************************************************************
INSERT INTO clarice.[Anc].[visits]
           ([system_id] ,[visit_date] ,[created_at] ,[modified_at] ,[created_by]
,[sent_flag] ,[department_visited] ,[facility_mflcode] ,[anc_visit_id],rowguid)
SELECT     [system_id] ,[visit_date] ,[created_at] ,[modified_at] ,[created_by]
,[sent_flag] ,[department_visited] ,[facility_mflcode] ,[anc_visit_id],rowguid

FROM opinya.[Anc].[visits] n

where NOT EXISTS (SELECT * FROM clarice.[Anc].[visits] b  
--where b.rowguid = n.rowguid
where b.anc_visit_id   = n.anc_visit_id   )


--**********************************************************ANC VITALS*******************************************************************************************
INSERT INTO clarice.[Anc].[vitals]
           ([visit_id] ,[system_id] ,[gestation_weeks] ,[client_weight] ,[blood_pressure],[parity]
,[gravidae] ,[LMP],[EDD],[created_at],[created_by],[modified_at] ,[modified_by] ,[anc_visit_id] ,entry_id,rowguid
      )
     
SELECT  [visit_id] ,[system_id] ,[gestation_weeks] ,[client_weight] ,[blood_pressure],[parity]
,[gravidae] ,[LMP],[EDD],[created_at],[created_by],[modified_at] ,[modified_by] ,[anc_visit_id] ,[entry_id],rowguid
      

FROM opinya.[Anc].[vitals] n

WHERE NOT EXISTS (SELECT * FROM clarice.[Anc].[vitals] b  where b.entry_id = n.entry_id 
and  b.rowguid  = n.rowguid  )

--******************************************************ANC-CCC-Visit-Relation***********************************************************************************************************************
INSERT INTO clarice.[dbo].[anc_ccc_visit_rel]
           ([visit_relation_id] ,[system_id] ,[anc_visit_date] ,[ccc_visit_date]
 ,[created_at] ,[modified_at] ,[created_by]  ,[modified_by])
     
SELECT  [visit_relation_id] ,[system_id] ,[anc_visit_date] ,[ccc_visit_date]
 ,[created_at] ,[modified_at] ,[created_by]  ,[modified_by]

FROM opinya.[dbo].[anc_ccc_visit_rel] n

WHERE NOT EXISTS (SELECT * FROM clarice.[dbo].[anc_ccc_visit_rel] b where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and  b.visit_relation_id   = n.visit_relation_id )  


--************************************************************************REGISTRY CHECKINS*************************************************************
INSERT INTO clarice.[registry].[checkins]
           ([system_id],[visit_date] ,[created_at],[modified_at] ,[created_by],
[sent_flag],[department_visited] ,[visit_id],[facility_mflcode])

SELECT  [system_id],[visit_date] ,[created_at],[modified_at] ,[created_by],
[sent_flag],[department_visited] ,[visit_id],[facility_mflcode]
FROM  opinya.[registry].[checkins] n

WHERE NOT EXISTS (SELECT * FROM clarice.[registry].[checkins] b  where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and  b.visit_id = n.visit_id )   

---***************************************************final_test_results***************************************************************************************************************
 
INSERT INTO clarice.[registry].[final_test_result]
           ([person_id] ,[system_id]  ,[test_result],[test_type] ,[test_point]    ,[test_date] ,[created_at]
 ,[created_by] ,[modified_at] ,[modified_by] ,[rowguid]  ,[is_voided] ,[final_test_id])

SELECT [person_id] ,[system_id]  ,[test_result],[test_type] ,[test_point]    ,[test_date] ,[created_at]
 ,[created_by] ,[modified_at] ,[modified_by] ,[rowguid]  ,[is_voided] ,[final_test_id]
           
FROM  opinya.[registry].[final_test_result] n

WHERE NOT EXISTS (SELECT * FROM clarice.[registry].[final_test_result] b  where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and  b.final_test_id = n.final_test_id )   


---------*****************************hdss_search_log*****************************************************************************************************************************************
INSERT INTO clarice.[registry].[hdss_search_log]
           ([system_id] ,[search_parameters] ,[created_at] ,[involved_user],[rowguid])
SELECT   [system_id] ,[search_parameters] ,[created_at] ,[involved_user] ,[rowguid]

FROM  opinya.[registry].[hdss_search_log] n
WHERE NOT EXISTS (SELECT * FROM clarice.[registry].[hdss_search_log] b  

where b.[rowguid]  = n.[rowguid] ) 

----------***************************REGISTRY_Interviews********************************************************************************************************************************************
INSERT INTO clarice.[registry].[interviews]
           ([system_id] ,[start_time] ,[end_time] ,[date_created] ,[involved_user])

SELECT  [system_id] ,[start_time] ,[end_time] ,[date_created] ,[involved_user]

FROM opinya.[registry].[interviews] n
WHERE NOT EXISTS (SELECT * FROM clarice.[registry].[interviews] b  where b.[system_id] COLLATE database_default = n.system_id COLLATE database_default
and b.[start_time]  = n.start_time 
and b.[end_time]  = n.end_time 
and b.[date_created]  = n.date_created ) 


----*******************REGISTRY.PERSON********************************************************************************************************************************

INSERT into clarice.registry.person (
[reg_date] ,[facility_department] ,[pfile_ref_type],[pfile_ref],[firstname] ,[middlename]
 ,[lastname],[dob],[year_of_birth] ,[month_of_birth] ,[day_of_birth] ,[gender] ,[dateAtCurResidence]
,[mfname] ,[mjname] ,[mlname]  ,[ffname] ,[fjname] ,[flname],[village_name]  ,[meta_location_type]
  ,[meta_location_value] ,[date_created]  ,[created_by] ,[date_modified] ,[modified_by]  ,[mstatus] ,[sent_flag]
  ,[facility_mflcode]  ,[sent]  ,[chfname]  ,[chmname]  ,[chlname]  ,[machine_name] ,[system_id] ,[is_voided] ,[remarks])
      
SELECT [reg_date] ,[facility_department] ,[pfile_ref_type],[pfile_ref],[firstname] ,[middlename]
 ,[lastname],[dob],[year_of_birth] ,[month_of_birth] ,[day_of_birth] ,[gender] ,[dateAtCurResidence]
,[mfname] ,[mjname] ,[mlname]  ,[ffname] ,[fjname] ,[flname],[village_name]  ,[meta_location_type]
  ,[meta_location_value] ,[date_created]  ,[created_by] ,[date_modified] ,[modified_by]  ,[mstatus] ,[sent_flag]
  ,[facility_mflcode]  ,[sent]  ,[chfname]  ,[chmname]  ,[chlname]  ,[machine_name] ,[system_id] ,[is_voided] ,[remarks] 
FROM opinya.registry.person n
where NOT EXISTS (SELECT * FROM clarice.registry.person b  where b.[system_id]collate database_default = n.system_id collate database_default )

--**********************************************[registry].[person_identifier]*********************************************************************************************************

INSERT INTO clarice.[registry].[person_identifier]
           ([system_id] ,[identifier_type_id] ,[identifier] ,[visit_id]
 ,[date_created] ,[created_by] ,[modified_at] ,[modified_by],[person_identifier_id])

SELECT  [system_id] ,[identifier_type_id] ,[identifier] ,[visit_id]
 ,[date_created] ,[created_by] ,[modified_at] ,[modified_by],[person_identifier_id]

FROM opinya.[registry].[person_identifier] n 
 
where NOT EXISTS (SELECT * FROM clarice.registry.person_identifier b   where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and b.person_identifier_id   = n.person_identifier_id )  


----************************************PERSON LOCATION*************************************************************************************************************
INSERT INTO clarice.[registry].[person_location]
           ([system_id],[config_location_id],[location_value],[date_created],
[created_by] ,[date_modified] ,[modified_by] ,[person_location_id])

SELECT [system_id],[config_location_id],[location_value],[date_created],
[created_by] ,[date_modified] ,[modified_by] ,[person_location_id] 
           
FROM opinya.[registry].[person_location] n
where NOT EXISTS (SELECT * FROM clarice.[registry].[person_location] b  where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and  b.person_location_id   = n.person_location_id )  

--*******************************************PERSON MATCH************************************************************************************************************

INSERT INTO clarice.[registry].[person_match]
           ([person_id] ,[system_id] ,[HDSS_ID],[search_criteria],[date_matched]
,[match_notes],[matched_by],[match_state],[is_hdss],[rowguid],[is_voided],[match_id])

SELECT [person_id] ,[system_id] ,[HDSS_ID],[search_criteria],[date_matched]
,[match_notes],[matched_by],[match_state],[is_hdss],[rowguid],[is_voided],[match_id]

FROM opinya.[registry].[person_match] n

where NOT EXISTS (SELECT * FROM clarice.[registry].[person_match] b  where b.system_id COLLATE database_default = n.system_id COLLATE database_default 
and b.rowguid=n.rowguid )  

--***************************************REGISTRY PERSON REMARKS***********************************************************************************************************
INSERT INTO clarice.[registry].[person_remarks]
           ([system_id] ,[remarks] ,[created_at])
    
SELECT  [system_id] ,[remarks] ,[created_at]

FROM opinya.[registry].[person_remarks] n

where NOT EXISTS (SELECT * FROM clarice.[registry].[person_remarks] b  
where b.system_id COLLATE database_default = n.system_id COLLATE database_default and b.remarks COLLATE database_default = n.remarks COLLATE database_default and
b.created_at=n.created_at ) 
  
---****************************************************************REGISTRY PREGNANCY **********************************************************************
INSERT INTO clarice.[registry].[pregnancy]
           ([system_id],[pregnancy_value] ,[created_at],[created_by]
      ,[modified_at],[modified_by],[pregnancy_episode],[pregnancy_id],[rowguid])

SELECT [system_id],[pregnancy_value] ,[created_at],[created_by]
      ,[modified_at],[modified_by],[pregnancy_episode],[pregnancy_id],[rowguid]

FROM opinya.[registry].[pregnancy] n

where NOT EXISTS ( SELECT * FROM clarice.[registry].[pregnancy] b  where b.pregnancy_id  = n.pregnancy_id)

--******************************************************************REGISTRY TEST RESULT************************************************************************
INSERT INTO clarice.[registry].[test_result]
           ([person_id] ,[system_id] ,[tester] ,[lot_no] ,[test_type] ,[test_result]
,[test_point] ,[is_duplicate] ,[date_created] ,[test_date] ,[rowguid]
 ,[is_voided]  ,[created_by] ,[date_modified]  ,[modified_by] ,[entry_id])
 
 SELECT [person_id] ,[system_id] ,[tester] ,[lot_no] ,[test_type] ,[test_result]
,[test_point] ,[is_duplicate] ,[date_created] ,[test_date] ,[rowguid]
 ,[is_voided]  ,[created_by] ,[date_modified]  ,[modified_by] ,[entry_id]
        
           
 FROM  opinya.[registry].[test_result]  n 
  
where NOT EXISTS (SELECT * FROM clarice.[registry].[test_result] b  where b.[system_id] collate database_default = n.system_id collate database_default and b.rowguid=n.rowguid)

------check out***********************************************************************************************************

INSERT INTO clarice.[visit].[checkout]
           ([person_id] ,[system_id],[next_app_date],[date_created],[rowguid],[is_voided])
 
 SELECT [person_id] ,[system_id],[next_app_date],[date_created],[rowguid],[is_voided]
           
 FROM  opinya.[visit].[checkout]  n 
  
where NOT EXISTS (SELECT * FROM clarice.[visit].[checkout] b  
where b.[system_id] collate database_default = n.system_id collate database_default and b.rowguid=n.rowguid )




  