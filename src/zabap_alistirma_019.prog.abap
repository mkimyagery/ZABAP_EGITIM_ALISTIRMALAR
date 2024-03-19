*&---------------------------------------------------------------------*
*& Report ZCM_TEST_162
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_019.

DATA: go_cont_sflight   TYPE REF TO cl_gui_custom_container,
      go_grid_sflight   TYPE REF TO cl_gui_alv_grid,
      gt_fcat_sflight   TYPE lvc_t_fcat,
      gs_fcat_sflight   TYPE lvc_s_fcat,
      gs_layout_sflight TYPE lvc_s_layo,
      gt_sflight        TYPE TABLE OF sflight,
      gv_field          TYPE lvc_fname,
      gv_color          TYPE c LENGTH 4..

START-OF-SELECTION.

  CALL SCREEN 0500.
*&---------------------------------------------------------------------*
*& Module STATUS_0500 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0500 OUTPUT.
  SET PF-STATUS 'STATUS_162'.
* SET TITLEBAR 'xxx'.

  PERFORM layout.
  PERFORM select_data.
  PERFORM fcat.
  PERFORM show_alv.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0500  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0500 INPUT.



  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'RED'.
      gv_color = 'C610'.
      PERFORM kolon_renklendir.
    WHEN 'GREEN'.
      gv_color = 'C510'.
      PERFORM kolon_renklendir.
    WHEN 'YELLOW'.
      gv_color = 'C310'.
      PERFORM kolon_renklendir.
*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM layout .
  gs_layout_sflight-zebra = abap_true.
  gs_layout_sflight-cwidth_opt = abap_true.
  gs_layout_sflight-sel_mode = 'A'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM select_data .

  SELECT * FROM sflight INTO TABLE gt_sflight.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fcat .

  IF gt_fcat_sflight IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SFLIGHT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat_sflight
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form show_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv .
  IF go_grid_sflight IS INITIAL.

    CREATE OBJECT go_cont_sflight
      EXPORTING
        container_name              = 'CC_SFLIGHT'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    CREATE OBJECT go_grid_sflight
      EXPORTING
        i_parent          = go_cont_sflight
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    go_grid_sflight->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout_sflight
      CHANGING
        it_outtab                     = gt_sflight
        it_fieldcatalog               = gt_fcat_sflight
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ELSE.

    go_grid_sflight->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat_sflight ).

    go_grid_sflight->set_frontend_layout( is_layout = gs_layout_sflight ).

    go_grid_sflight->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form kolon_renklendir
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM kolon_renklendir .
  READ TABLE gt_fcat_sflight INTO gs_fcat_sflight WITH KEY fieldname = gv_field.
  IF sy-subrc IS INITIAL.
    gs_fcat_sflight-emphasize = gv_color.
    MODIFY gt_fcat_sflight
      FROM gs_fcat_sflight
      TRANSPORTING emphasize
      WHERE fieldname = gs_fcat_sflight-fieldname.
  ENDIF.

ENDFORM.
