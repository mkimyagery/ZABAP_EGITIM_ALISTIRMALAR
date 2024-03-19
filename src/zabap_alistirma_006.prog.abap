*&---------------------------------------------------------------------*
*& Report ZCM_TEST_124
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_006.

DATA: gt_stravelag     TYPE TABLE OF zcm_stravelag_02,
      gs_stravelag     TYPE zcm_stravelag_02,
      gt_secilen_satir TYPE TABLE OF zcm_stravelag_02,
      gt_fieldcat      TYPE lvc_t_fcat,
      gt_fieldcat_slis TYPE slis_t_fieldcat_alv,
      gs_layout        TYPE lvc_s_layo,
      gv_satir_sayisi  TYPE n LENGTH 3,
      gv_msg           TYPE c LENGTH 80,
      gv_sayac         TYPE n LENGTH 3,
      gv_sehir         TYPE city.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_agnum FOR gs_stravelag-agencynum.
SELECTION-SCREEN END OF BLOCK a1.

PERFORM select_data.
PERFORM fcat.
PERFORM layout.
PERFORM show_alv.

FORM select_data.
  SELECT * FROM zcm_stravelag_02 INTO TABLE gt_stravelag WHERE agencynum IN so_agnum.
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
      i_callback_pf_status_set = 'TEST_124'
      i_callback_user_command  = 'UC_124'
    TABLES
      t_outtab                 = gt_stravelag
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM test_124 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_124'.
ENDFORM.

FORM uc_124 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'SATIR'.
      DESCRIBE TABLE gt_stravelag LINES gv_satir_sayisi.
      SHIFT gv_satir_sayisi LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-002 gv_satir_sayisi INTO gv_msg SEPARATED BY space.

      MESSAGE gv_msg TYPE 'I'.

    WHEN 'SEHIR'.

      SORT gt_stravelag BY city.

      LOOP AT gt_stravelag INTO gs_stravelag.

        IF sy-tabix > 1 AND gs_stravelag-city = gv_sehir.
          CONTINUE.
        ENDIF.

        gv_sehir = gs_stravelag-city.
        gv_sayac = gv_sayac + 1.
      ENDLOOP.

      SHIFT gv_sayac LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-003 gv_sayac INTO gv_msg SEPARATED BY space.

      MESSAGE gv_msg TYPE 'I'.

    WHEN 'POPUP'.

      READ TABLE gt_stravelag INTO gs_stravelag INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.
        APPEND gs_stravelag TO gt_secilen_satir.
      ENDIF.

      CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name       = 'ZCM_STRAVELAG_02'
          i_bypassing_buffer     = abap_true
        CHANGING
          ct_fieldcat            = gt_fieldcat_slis
        EXCEPTIONS
          inconsistent_interface = 1
          program_error          = 2
          OTHERS                 = 3.

      IF sy-subrc IS NOT INITIAL.
        LEAVE PROGRAM.
      ENDIF.

      CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
        EXPORTING
          i_title               = TEXT-004
          i_screen_start_column = 5
          i_screen_start_line   = 5
          i_screen_end_column   = 165
          i_screen_end_line     = 8
          i_tabname             = 'GT_SECILEN_SATIR'
          it_fieldcat           = gt_fieldcat_slis
          i_callback_program    = sy-repid
        TABLES
          t_outtab              = gt_secilen_satir
        EXCEPTIONS
          program_error         = 1
          OTHERS                = 2.

      IF sy-subrc IS NOT INITIAL.
        LEAVE PROGRAM.
      ENDIF.

      CLEAR: gt_secilen_satir.
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.

ENDFORM.
