*&---------------------------------------------------------------------*
*& Report ZCM_TEST_92
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_049.

SELECTION-SCREEN BEGIN OF BLOCK a1  WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_num    TYPE i,
               p_karesi RADIOBUTTON GROUP abc,
               p_kupu   RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_num = 0 .
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ELSE.
    IF p_kupu IS NOT INITIAL.
      PERFORM kupu.
    ELSE .
      PERFORM karesi.
    ENDIF.
  ENDIF.

FORM kupu .
  p_num = p_num * p_num * p_num.
  WRITE : p_num.
ENDFORM.

FORM karesi .
  p_num = p_num * p_num.
  WRITE : p_num.
ENDFORM.
