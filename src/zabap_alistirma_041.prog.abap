*&---------------------------------------------------------------------*
*& Report ZCM_TEST_71
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_041.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_carrid TYPE s_carr_id,
              p_curr   TYPE s_currcode.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_curr IS INITIAL.
    MESSAGE TEXT-004 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  UPDATE zcm_scarr SET currcode = p_curr WHERE carrid = p_carrid.

  IF sy-subrc IS INITIAL.
    MESSAGE TEXT-002 TYPE 'S'.
  ELSE.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
