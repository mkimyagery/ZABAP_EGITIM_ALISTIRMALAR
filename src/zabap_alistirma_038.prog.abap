*&---------------------------------------------------------------------*
*& Report ZCM_TEST_68
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_038.


DATA: gs_scarr TYPE scarr, "ZCM_SCARR
      gt_scarr TYPE TABLE OF scarr. "ZCM_SCARR

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.

    INSERT zcm_scarr FROM gs_scarr.

  ENDLOOP.
