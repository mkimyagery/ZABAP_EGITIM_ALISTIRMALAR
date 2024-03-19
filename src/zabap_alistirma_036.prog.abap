*&---------------------------------------------------------------------*
*& Report ZCM_TEST_66
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_036.

SELECTION-SCREEN BEGIN OF BLOCK x1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_carrid TYPE s_carr_id.

SELECTION-SCREEN END OF BLOCK x1.

DATA: gs_spfli    TYPE spfli,
      gt_spfli    TYPE TABLE OF spfli,
      gv_no_lines TYPE n LENGTH 3,
      gv_msg      TYPE string.

START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE gt_spfli WHERE carrid = p_carrid.

  DESCRIBE TABLE gt_spfli LINES gv_no_lines.

  IF gv_no_lines > 0.
    gv_msg = TEXT-002.

    REPLACE ALL OCCURRENCES OF '&1' IN gv_msg WITH p_carrid.
    REPLACE ALL OCCURRENCES OF '&2' IN gv_msg WITH gv_no_lines.

    MESSAGE gv_msg TYPE 'I'.
  ELSE.
    MESSAGE TEXT-003 TYPE 'I'.
  ENDIF.



*  IF gt_spfli IS NOT INITIAL.
*
*    LOOP AT gt_spfli INTO gs_spfli.
*
*      gv_no_lines = gv_no_lines + 1.
*
*    ENDLOOP.
*
*    gv_msg = TEXT-002.
*
*    REPLACE ALL OCCURRENCES OF '&1' IN gv_msg WITH p_carrid.
*    REPLACE ALL OCCURRENCES OF '&2' IN gv_msg WITH gv_no_lines.
*
*    MESSAGE gv_msg TYPE 'I'.
*
*  ELSE.
*
*    MESSAGE TEXT-003 TYPE 'I'.
*
*  ENDIF.
