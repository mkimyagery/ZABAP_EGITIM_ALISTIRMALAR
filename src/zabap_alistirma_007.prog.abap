*&---------------------------------------------------------------------*
*& Report ZCM_TEST_125
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_007.

DATA: gt_stravelag TYPE TABLE OF zcm_stravelag_02,
      gs_stravelag TYPE zcm_stravelag_02,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_fieldcat  TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      gv_url       TYPE s_url,
      gv_answer    TYPE c LENGTH 1.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_agnnm FOR gs_stravelag-agencynum.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.

  SELECT * FROM zcm_stravelag_02 INTO TABLE gt_stravelag WHERE agencynum IN so_agnnm.

ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_STRAVELAG_02'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    CASE gs_fieldcat-fieldname.
      WHEN 'URL'.
        gs_fieldcat-hotspot = abap_true.

        MODIFY gt_fieldcat FROM gs_fieldcat TRANSPORTING hotspot WHERE fieldname = gs_fieldcat-fieldname.
*    	WHEN .
*    	WHEN OTHERS.
    ENDCASE.

  ENDLOOP.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.

FORM layout.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

ENDFORM.

FORM show_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
      i_callback_pf_status_set = 'TEST_125'
      i_callback_user_command  = 'UC_125'
    TABLES
      t_outtab                 = gt_stravelag
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM test_125 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_125'.
ENDFORM.

FORM uc_125 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'URL'.
        CALL FUNCTION 'ZCM_POPUP_GET_NEW_URL'
          IMPORTING
            ev_url    = gv_url
            ev_answer = gv_answer.

        IF gv_answer IS INITIAL. "IF gv_answer = 0.
          IF gv_url IS NOT INITIAL.

            SELECT SINGLE * FROM zcm_stravelag_02 INTO gs_stravelag WHERE url = ls_selfield-value.

            gs_stravelag-eski_url = gs_stravelag-url.
            gs_stravelag-url = gv_url.


            MODIFY zcm_stravelag_02 FROM gs_stravelag.


*            UPDATE zcm_stravelag_02 SET   url = gv_url
*                                    WHERE url = ls_selfield-value.
          ENDIF.
        ENDIF.

        PERFORM select_data.
        PERFORM show_alv.

      ENDIF.

  ENDCASE.

ENDFORM.
