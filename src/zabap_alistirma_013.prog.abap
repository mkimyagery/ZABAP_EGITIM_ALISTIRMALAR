*&---------------------------------------------------------------------*
*& Report ZCM_TEST_148
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_013.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan select-options yardımıyla 1 adet CARRID alin.
*Ayrıca 3 adet checkbox olsun. Checkboxların isimleri sırasıyla “Scarr”, “Spfli” ve “Sflight” olsun. Yeni
*bir Class oluşturun. Class içerisinde 4 adet metot olsun. Birinci metot (Instance-Public), kullanıcının
*verdiği CARRID bilgisini ve seçilen checkbox bilgisini import etsin. Hangi checkboxlar seçildiyse o
*tablodan veri çeksin ve kullanıcıya export etsin. Her tablodan veri çekmek için ayrı (Instance-Protected)
*metotlar oluşturun ve ilk metot içerisinde kullanın.
*
*Alıştırma – 5: Dördüncü alıştırmanın aynisini yapın ancak birinci metot, istenen tablolardan veri
*çektikten sonra bu tabloları export etmesin. Bu veriyi Class içerisinde oluşturulacak instance-public
*attributelar içerisine kaydetsin. Program içerisinde bu attributeları kullanarak veriyi ekrana yazdırın.


DATA: gv_carrid   TYPE s_carr_id,
      go_class_04 TYPE REF TO zalistirma_cls_04.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.

  SELECT-OPTIONS: so_carr FOR gv_carrid.

  PARAMETERS: cb_scarr AS CHECKBOX,
              cb_spfli AS CHECKBOX,
              cb_sflgt AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  CREATE OBJECT go_class_04.

  go_class_04->gt_carrid_selopt = so_carr[].

  go_class_04->get_tables(
    EXPORTING
      iv_select_scarr   = cb_scarr
      iv_select_spfli   = cb_spfli
      iv_select_sflight = cb_sflgt ).


  BREAK-POINT.
