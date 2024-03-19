*&---------------------------------------------------------------------*
*& Report ZCM_TEST_61
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_031.


DATA: gs_structure TYPE zcm_table_phone,
      gt_table     TYPE TABLE OF zcm_table_phone.

START-OF-SELECTION.

  SELECT * FROM zcm_table_phone INTO TABLE gt_table.

  LOOP AT gt_table INTO gs_structure.
    WRITE: / gs_structure-phone_brand,
             gs_structure-phone_model,
             gs_structure-phone_color,
             gs_structure-phone_opr_system,
             gs_structure-phone_memory,
             gs_structure-phone_screen,
             gs_structure-phone_price,
             gs_structure-phone_curr,
             gs_structure-phone_dbl_sim,
             gs_structure-phone_weight,
             gs_structure-phone_wuom.
    CLEAR: gs_structure.
  ENDLOOP.
