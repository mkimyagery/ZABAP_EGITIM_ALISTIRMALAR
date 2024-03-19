*&---------------------------------------------------------------------*
*& Report ZCM_TEST_88
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_045.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (1 adet CARRID, 2 adet
*tarih). Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options
*yapılarına aktarın. Elde ettiğiniz Select-Options yapılarını kullanarak SFLIGHT tablosundan uygun
*satırları okuyun ve ekrana yazdırın.



INCLUDE zcm_test_88_top.
INCLUDE zcm_test_88_f01.

START-OF-SELECTION.

PERFORM selopt.
PERFORM write.
