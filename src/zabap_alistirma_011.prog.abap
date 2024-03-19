*&---------------------------------------------------------------------*
*& Report ZCM_TEST_146
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_011.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet sayı alin. Ayrıca 3 adet radiobutton olsun.
*Radiobuttonların isimleri sırasıyla “Üzeri 2”, “Üzeri 3” ve “Üzeri 4” olsun. Yeni bir Class oluşturun. Class
*içerisinde 3 adet metot olsun. (Tamamı Instance-Public). Kullanıcının seçtiği radiobutton
*doğrultusunda gelen sayıyı kullanarak sonucu hesaplayın ve ekrana yazdırın. (Örnek: Eğer “Üzeri 2”
*radiobutonu seçildiyse, 1. metot kullanılacak ve sonuç hesaplanacak.)


PARAMETERS: p_number TYPE i,
            p_uzr_2  RADIOBUTTON GROUP abc,
            p_uzr_3  RADIOBUTTON GROUP abc,
            p_uzr_4  RADIOBUTTON GROUP abc.

DATA: go_class  TYPE REF TO zalistirma_cls_02,
      gv_result TYPE int4.

START-OF-SELECTION.

  CREATE OBJECT go_class.

  IF p_uzr_2 = abap_true.
    go_class->uzeri_2(
      EXPORTING
        iv_number = p_number
      IMPORTING
        ev_result = gv_result ).
  ELSEIF p_uzr_3 = abap_true.
    go_class->uzeri_3(
    EXPORTING
      iv_number = p_number
    IMPORTING
      ev_result = gv_result ).
  ELSE.
    go_class->uzeri_4(
    EXPORTING
      iv_number = p_number
    IMPORTING
      ev_result = gv_result ).
  ENDIF.

  WRITE: gv_result.
