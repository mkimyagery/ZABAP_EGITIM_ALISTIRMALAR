*&---------------------------------------------------------------------*
*& Report ZCM_TEST_67
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_037.


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_carrid TYPE s_carr_id.

SELECTION-SCREEN END OF BLOCK a1.
*
TYPES: BEGIN OF gty_table,
         seatsmax TYPE s_seatsmax,
         seatsocc TYPE s_seatsocc,
       END OF gty_table.

DATA: gs_str        TYPE gty_table,
      gt_table      TYPE TABLE OF gty_table,
      gv_seatsmax   TYPE i,
      gv_seatsmax_s TYPE string,
      gv_seatsocc   TYPE i,
      gv_seatsocc_s TYPE string,
      gv_msg        TYPE string.


START-OF-SELECTION.

  SELECT seatsmax, seatsocc FROM sflight INTO TABLE @gt_table WHERE carrid = @p_carrid.

  IF gt_table IS NOT INITIAL.

    LOOP AT gt_table INTO gs_str.
      gv_seatsmax = gv_seatsmax + gs_str-seatsmax.
      gv_seatsocc = gv_seatsocc + gs_str-seatsocc.
    ENDLOOP.

    gv_seatsmax_s = gv_seatsmax.
    gv_seatsocc_s = gv_seatsocc.
    gv_msg = TEXT-002.

    REPLACE ALL OCCURRENCES OF '&1' IN gv_msg WITH gv_seatsmax_s.
    REPLACE ALL OCCURRENCES OF '&2' IN gv_msg WITH gv_seatsocc_s.

    MESSAGE gv_msg TYPE 'I'.

  ELSE.

    MESSAGE TEXT-003 TYPE 'I'.

  ENDIF.
