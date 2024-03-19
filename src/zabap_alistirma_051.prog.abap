*&---------------------------------------------------------------------*
*& Report ZCM_TEST_86
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_051.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 3 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.
*Ancak ekrana yazdırırken önce SCARR tablosundan 1 satir yazdırın, daha sonra SPFLI tablosunda bu
*satir ile ayni CARRID bilgisine sahip olan satırları yazdırmaya başlayın. Her SPFLI satırından sonra
*SFLIGHT tablosundan bu satir ile ayni CARRID bilgisine sahip olan satırları yazdırın.



INCLUDE zcm_test_96_top.
INCLUDE zcm_test_96_f01.

START-OF-SELECTION.

  PERFORM select_tables.
*PERFORM write_tables.
