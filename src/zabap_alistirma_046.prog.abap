*&---------------------------------------------------------------------*
*& Report ZCM_TEST_89
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_046.
*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan 4 adet parametre alin. (2 adet BOOKID (SBOOK
*tablosu BOOKID kolonu), 1 adet Radiobutton (Eşittir isminde), 1 adet Radiobutton (Arasında isminde)).
*Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options yapılarına
*aktarın ve SBOOK tablosundan satırları okuyarak ekrana yazdırın.

INCLUDE zcm_test_89_top.
INCLUDE zcm_test_89_f01.

START-OF-SELECTION.

PERFORM check.
PERFORM select.
