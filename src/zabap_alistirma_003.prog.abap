*&---------------------------------------------------------------------*
*& Report ZCM_TEST_121
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_003.

*Alıştırma – 1: Yeni bir database tablosu oluşturun. (Örneğin ZCM_STRAVELAG) Satir yapısı STRAVELAG
*database tablosu ile tamamen ayni olsun. Daha sonra yeni bir rapor oluşturun ve STRAVELAG
*tablosundaki bütün bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin.

DATA: gt_stravelag TYPE TABLE OF stravelag,
      gs_stravelag TYPE zcm_stravelag_02.

START-OF-SELECTION.

SELECT * FROM stravelag INTO TABLE gt_stravelag.

  LOOP AT gt_stravelag INTO gs_stravelag.
    INSERT zcm_stravelag_02 FROM gs_stravelag.
  ENDLOOP.
