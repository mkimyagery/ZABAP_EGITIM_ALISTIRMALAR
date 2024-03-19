*&---------------------------------------------------------------------*
*& Report ZCM_TEST_337
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_059.

*Alıştırma – 4: Bir önceki alıştırmada manuel olarak hazırlanmış internal tablo için manuel olarak field
*Catalog oluşturun ve Container ALV hazırlayın. Field Catalog tablosunu hazırlarken inline declaration
*ile tanımlanmış field sembol kullanın.


TYPES: BEGIN OF gty_table,
         proje_id        TYPE c LENGTH 6,
         proje_ad        TYPE c LENGTH 25,
         proje_sor       TYPE c LENGTH 40,
         proje_plan_gun  TYPE i,
         proje_departman TYPE c LENGTH 25,
       END OF gty_table.

DATA: gt_table     TYPE TABLE OF gty_table,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_alv_grid  TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

START-OF-SELECTION.

  CALL SCREEN 0200.


MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_338'.
* SET TITLEBAR 'xxx'.

  PERFORM data_hazirla.
  PERFORM fcat.
  PERFORM layout.
  PERFORM alv.
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
*	WHEN .
*	WHEN OTHERS.
  ENDCASE.
ENDMODULE.

FORM data_hazirla .
  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<fs_str>).
  <fs_str>-proje_id        = 'PRJ-1'.
  <fs_str>-proje_ad        = 'Depo Yönetimi'.
  <fs_str>-proje_sor       = 'Mehmet Akman'.
  <fs_str>-proje_plan_gun  = 20.
  <fs_str>-proje_departman = 'SAP Uygulamalari Dept.'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <fs_str>.
  <fs_str>-proje_id        = 'PRJ-2'.
  <fs_str>-proje_ad        = 'Kalan ürün yönetimi'.
  <fs_str>-proje_sor       = 'Mehmet Akman'.
  <fs_str>-proje_plan_gun  = 25.
  <fs_str>-proje_departman = 'SAP Uygulamalari Dept.'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <fs_str>.
  <fs_str>-proje_id        = 'PRJ-3'.
  <fs_str>-proje_ad        = 'Kampanya Yönetimi'.
  <fs_str>-proje_sor       = 'Mehmet Akman'.
  <fs_str>-proje_plan_gun  = 15.
  <fs_str>-proje_departman = 'SAP Uygulamalari Dept.'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <fs_str>.
  <fs_str>-proje_id        = 'PRJ-4'.
  <fs_str>-proje_ad        = 'Ulasim Yönetimi'.
  <fs_str>-proje_sor       = 'Mehmet Akman'.
  <fs_str>-proje_plan_gun  = 25.
  <fs_str>-proje_departman = 'SAP Uygulamalari Dept.'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <fs_str>.
  <fs_str>-proje_id        = 'PRJ-5'.
  <fs_str>-proje_ad        = 'Satis Yönetimi'.
  <fs_str>-proje_sor       = 'Mehmet Akman'.
  <fs_str>-proje_plan_gun  = 30.
  <fs_str>-proje_departman = 'SAP Uygulamalari Dept.'.

  LOOP AT gt_table ASSIGNING <fs_str>.
    <fs_str>-proje_plan_gun = <fs_str>-proje_plan_gun + 5.
  ENDLOOP.
ENDFORM.

FORM fcat.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING FIELD-SYMBOL(<fs_fcat>).
  <fs_fcat>-fieldname = 'PROJE_ID'.
  <fs_fcat>-reptext = 'PROJE ID'.


  APPEND INITIAL LINE TO gt_fcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PROJE_AD'.
  <fs_fcat>-reptext = 'PROJE AD'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PROJE_SOR'.
  <fs_fcat>-reptext = 'PROJE SORUMLUSU'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PROJE_PLAN_GUN'.
  <fs_fcat>-reptext = 'PROJE PLANLANAN GÜN'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PROJE_DEPARTMAN'.
  <fs_fcat>-reptext = 'PROJE DEPARTMANI'.

ENDFORM.

FORM layout.
  gs_layout-zebra = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode = 'A'.
ENDFORM.

FORM alv .
  IF go_alv_grid IS INITIAL
    .
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

    IF sy-subrc <> 0.
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

    IF sy-subrc <> 0.
      LEAVE PROGRAM.
    ENDIF.

    go_alv_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc <> 0.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF.
ENDFORM.
