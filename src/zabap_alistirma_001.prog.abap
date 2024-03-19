*&---------------------------------------------------------------------*
*& Report ZABAP_CM_029
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_001.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrid TYPE s_carr_id AS LISTBOX VISIBLE LENGTH 15,
              p_connid TYPE s_conn_id AS LISTBOX VISIBLE LENGTH 4.
SELECTION-SCREEN END OF BLOCK a2.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_carr   TYPE s_carr_id,
              p_conn   TYPE s_conn_id,
              p_cntfr  TYPE land1,
              p_cityfr TYPE s_from_cit.
*              p_AIRPFR TYPE s_fromairp,
*              p_CNTTO  TYPE land1,
*              p_CITYTO TYPE s_to_city,
*              p_AIRPTO TYPE s_toairp,
*              p_FLTIME TYPE s_fltime,
*              p_DEPT   TYPE s_dep_time,
*              p_ARRT   TYPE s_arr_time,
*              p_DIST   TYPE s_distance,
*              p_DISTID TYPE s_distid,
*              p_FLTYPE TYPE s_fltype,
*              p_PERIOD TYPE s_period.


SELECTION-SCREEN END OF BLOCK a1.



DATA: gv_fname  TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gt_scarr  TYPE TABLE OF scarr,
      gs_scarr  TYPE scarr,
      gt_spfli  TYPE TABLE OF spfli,
      gs_spfli  TYPE spfli.

INITIALIZATION.

  gv_fname = 'P_CARRID'.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    gs_value-key = gs_scarr-carrid.
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

  gv_fname = 'P_CONNID'.
  CLEAR: gt_values.

  SELECT * FROM spfli INTO TABLE gt_spfli.

  LOOP AT gt_spfli INTO gs_spfli.
    gs_value-key = gs_spfli-connid.
    gs_value-text = gs_spfli-connid.
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

  SELECT SINGLE * FROM spfli INTO gs_spfli WHERE carrid = p_carrid AND connid = p_connid.

  IF sy-subrc IS INITIAL.
    p_carr   = gs_spfli-carrid.
    p_conn   = gs_spfli-connid.
    p_cntfr  = gs_spfli-countryfr.
    p_cityfr = gs_spfli-cityfrom.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_CARR IS INITIAL.
      IF screen-name = 'P_CARR' OR screen-name = '%_P_CARR_%_APP_%-TEXT'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_CARR'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF p_conn IS INITIAL.
      IF screen-name = 'P_CONN' OR screen-name = '%_P_CONN_%_APP_%-TEXT'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_CONN'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF p_cntfr IS INITIAL.
      IF screen-name = 'P_CNTFR' OR screen-name = '%_P_CNTFR_%_APP_%-TEXT'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_CNTFR'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF p_cityfr IS INITIAL.
      IF screen-name = 'P_CITYFR' OR screen-name = '%_P_CITYFR_%_APP_%-TEXT'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_CITYFR'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
