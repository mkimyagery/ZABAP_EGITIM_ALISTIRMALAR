*&---------------------------------------------------------------------*
*& Report ZCM_TEST_149
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_014.

PARAMETERS: p_date TYPE datum.

DATA: gv_info TYPE string.

START-OF-SELECTION.

  CHECK p_date < sy-datum.

  zalistirma_cls_06=>info(
    EXPORTING
      iv_date = p_date
    IMPORTING
      ev_info = gv_info ).

  BREAK-POINT.
