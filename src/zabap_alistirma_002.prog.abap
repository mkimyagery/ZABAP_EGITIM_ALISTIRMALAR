*&---------------------------------------------------------------------*
*& Report ZABAP_CM_030
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_002.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id AS LISTBOX VISIBLE LENGTH 15.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME NO INTERVALS.
  PARAMETERS: p_carr   TYPE c LENGTH 3,
              p_carrnm TYPE zcm_de_test_001,
              p_cur    TYPE s_currcode,
              p_url    TYPE s_carrurl.
SELECTION-SCREEN END OF BLOCK a2.

DATA: gv_fname  TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gt_scarr  TYPE TABLE OF scarr,
      gs_scarr  TYPE scarr.

INITIALIZATION.

  gv_fname = 'P_CARRID'.

  SELECT * FROM zcm_scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    gs_value-key  = gs_scarr-carrid.
    gs_value-text = gs_scarr-carrname.
    APPEND gs_value TO gt_values.
    CLEAR: gs_value.
  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_fname
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

AT SELECTION-SCREEN.

  READ TABLE gt_values INTO gs_value WITH KEY key = p_carr.
  IF p_carr IS NOT INITIAL AND sy-subrc IS NOT INITIAL.
    gs_scarr-carrid   = p_carr.
    gs_scarr-carrname = p_carrnm.
    gs_scarr-currcode = p_cur.
    gs_scarr-url      = p_url.

    INSERT zcm_scarr FROM gs_scarr.

    IF sy-subrc IS INITIAL.
      MESSAGE 'Kayit basariyla olusturuldu' TYPE 'S'.
      CLEAR: p_carrid.
    ENDIF.
  ELSE.
    SELECT SINGLE * FROM zcm_scarr INTO gs_scarr WHERE carrid = p_carrid.

    p_carr   = gs_scarr-carrid.
    p_carrnm = gs_scarr-carrname.
    p_cur    = gs_scarr-currcode.
    p_url    = gs_scarr-url.
    CLEAR: gs_scarr.
  ENDIF.
