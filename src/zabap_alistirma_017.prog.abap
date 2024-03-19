*&---------------------------------------------------------------------*
*& Report ZCM_TEST_160
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_017.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid  TYPE REF TO cl_gui_alv_grid,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      gv_red       TYPE c LENGTH 1,
      gv_green     TYPE c LENGTH 1,
      gv_yellow    TYPE c LENGTH 1,
      gv_color     TYPE c LENGTH 4,
      gv_text      TYPE string VALUE 'Satirlari istenilen renk ile renklendirebilirsiniz.'.

TYPES: BEGIN OF gty_scarr.
         INCLUDE STRUCTURE scarr.
TYPES:   row_color TYPE c LENGTH 4.
TYPES: END OF gty_scarr.

DATA: gt_scarr TYPE TABLE OF gty_scarr,
      gs_scarr TYPE gty_scarr.

START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_160'.
  SET TITLEBAR 'SCARR Satir Renklendirme'.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'TEK'.

      IF gv_red IS NOT INITIAL.
        gv_color = 'C610'.
      ELSEIF gv_green IS NOT INITIAL.
        gv_color = 'C510'.
      ELSEIF gv_yellow IS NOT INITIAL.
        gv_color = 'C310'.
      ENDIF.

      LOOP AT gt_scarr INTO gs_scarr.
        IF sy-tabix MOD 2 = 1.
          gs_scarr-row_color = gv_color.
        ELSE.
          CLEAR: gs_scarr-row_color.
        ENDIF.

        MODIFY gt_scarr
          FROM gs_scarr
          TRANSPORTING row_color
          WHERE carrid = gs_scarr-carrid.
      ENDLOOP.
    WHEN 'CIFT'.
      IF gv_red IS NOT INITIAL.
        gv_color = 'C610'.
      ELSEIF gv_green IS NOT INITIAL.
        gv_color = 'C510'.
      ELSEIF gv_yellow IS NOT INITIAL.
        gv_color = 'C310'.
      ENDIF.

      LOOP AT gt_scarr INTO gs_scarr.
        IF sy-tabix MOD 2 = 0.
          gs_scarr-row_color = gv_color.
        ELSE.
          CLEAR: gs_scarr-row_color.
        ENDIF.

        MODIFY gt_scarr
          FROM gs_scarr
          TRANSPORTING row_color
          WHERE carrid = gs_scarr-carrid.
      ENDLOOP.
*  	WHEN OTHERS.
  ENDCASE.
ENDMODULE.

FORM select_data.
  IF gt_scarr IS INITIAL.
    SELECT * FROM scarr INTO TABLE gt_scarr.
  ENDIF.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
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
  gs_layout-info_fname = 'ROW_COLOR'.
ENDFORM.

FORM show_alv.

  IF go_alv_grid IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CC_ALV'
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

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    go_alv_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_scarr
        it_fieldcatalog               = gt_fieldcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ELSE.
    go_alv_grid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ENDIF.
ENDFORM.
