*&---------------------------------------------------------------------*
*& Report ZCM_TEST_68
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_040.


DATA: gs_sflight TYPE zcm_sflight,
      gt_sflight TYPE TABLE OF zcm_sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.

    INSERT zcm_sflight FROM gs_sflight.

  ENDLOOP.
