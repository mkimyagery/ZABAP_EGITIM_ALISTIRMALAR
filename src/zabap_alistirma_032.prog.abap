*&---------------------------------------------------------------------*
*& Report ZCM_TEST_62
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_032.

DATA: gs_scarr TYPE scarr,
      gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    WRITE: / gs_scarr-carrid,
             gs_scarr-carrname,
             gs_scarr-currcode,
             gs_scarr-url.
    SKIP.
    CLEAR: gs_scarr.
  ENDLOOP.
