*&---------------------------------------------------------------------*
*& Report ZCM_TEST_337
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_058.

*Alıştırma – 3: Yeni bir rapor oluşturun. Raporda 5 hücreli bir internal tablo tanımlayın. (Örnek:
*PROJE_ID, PROJE_AD, PROJE_SORUMLUSU, PROJE_PLAN_GUN, PROJE_DEPARTMAN). APPEND
*INITIAL LINE TO komutunu kullanarak bu internal tabloya 5 adet yeni satir ekleyin. Daha sonra internal
*tabloda loop edin ve PROJE_PLAN_GUN kolonundaki her hücreye 5 ekleyin. Raporda inline declaration
*ile tanımlanmış field sembol kullanın.

TYPES: BEGIN OF gty_table,
         proje_id        TYPE c LENGTH 6,
         proje_ad        TYPE c LENGTH 25,
         proje_sor       TYPE c LENGTH 40,
         proje_plan_gun  TYPE i,
         proje_departman TYPE c LENGTH 25,
       END OF gty_table.

DATA: gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

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

BREAK-POINT.
