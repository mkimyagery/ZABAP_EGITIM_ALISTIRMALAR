*&---------------------------------------------------------------------*
*& Report ZCM_TEST_146
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_012.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet sayı alın. Ayrıca 3 adet radiobutton olsun.
*Radiobuttonların isimleri sırasıyla “Üzeri 2”, “Üzeri 3” ve “Üzeri 4” olsun. Yeni bir Class oluşturun. Class
*içerisinde 3 adet metot olsun. (Tamamı Static-Public). Kullanıcının seçtiği radiobutton doğrultusunda
*gelen sayıyı kullanarak sonucu hesaplayın ve ekrana yazdırın. (Örnek: Eğer “Üzeri 2” radiobutonu
*seçildiyse, 1. metot kullanılacak ve sonuç hesaplanacak.)



PARAMETERS: p_number TYPE i,
            p_uzr_2  RADIOBUTTON GROUP abc,
            p_uzr_3  RADIOBUTTON GROUP abc,
            p_uzr_4  RADIOBUTTON GROUP abc.

DATA: gv_result TYPE int4.

START-OF-SELECTION.

  IF p_uzr_2 = abap_true.
    zalistirma_cls_03=>uzeri_2(
      EXPORTING
        iv_number = p_number
      IMPORTING
        ev_result = gv_result ).
  ELSEIF p_uzr_3 = abap_true.
    zalistirma_cls_03=>uzeri_3(
    EXPORTING
      iv_number = p_number
    IMPORTING
      ev_result = gv_result ).
  ELSE.
    zalistirma_cls_03=>uzeri_4(
    EXPORTING
      iv_number = p_number
    IMPORTING
      ev_result = gv_result ).
  ENDIF.

  WRITE: gv_result.
