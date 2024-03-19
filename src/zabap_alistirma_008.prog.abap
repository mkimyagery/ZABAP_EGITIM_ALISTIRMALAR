*&---------------------------------------------------------------------*
*& Report ZCM_TEST_126
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_008.

TYPES: BEGIN OF gty_table,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         city      TYPE city,
         country   TYPE s_country,
         telephone TYPE s_phoneno,
         url       TYPE s_url,
       END OF gty_table.

DATA: gt_table     TYPE TABLE OF gty_table,
      gs_structure TYPE gty_table,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_fieldcat  TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.
  SELECT * FROM zcm_stravelag_02 INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.

FORM fcat.

  gs_fieldcat-fieldname = 'AGENCYNUM'.
  gs_fieldcat-scrtext_m = 'Seyahat Acentesi Numarasi'.
  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'NAME'.
  gs_fieldcat-scrtext_m = 'Seyahat Acentesi Ismi'.
*  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'CITY'.
  gs_fieldcat-scrtext_m = 'SEHIR'.
*  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'COUNTRY'.
  gs_fieldcat-scrtext_m = 'Ülke'.
*  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'TELEPHONE'.
  gs_fieldcat-scrtext_m = 'GSM'.
*  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'URL'.
  gs_fieldcat-scrtext_m = 'Web Adresi'.
*  gs_fieldcat-key = abap_true.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

ENDFORM.

FORM layout.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

ENDFORM.

FORM show_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.


ENDFORM.
