*&---------------------------------------------------------------------*
*& Report ZCM_TEST_342
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_063.

*Alıştırma – 8: Yeni bir rapor oluşturun. Raporda 1 adet tip tanımlaması yapın ve tip içerisinde
*STRAVELAG tablosundaki bütün kolonlar bulunsun. Bu tip tanımlamasını kullanarak bir table type
*tanımlayın. Öncelikle STRAVELAG tablosundaki tüm satırları okuyun ve bir internal tabloya kaydedin.
*Daha sonra rapor içinde inline declaration kullanarak yeni bir internal tablo tanımlayın ve VALUE-FOR
*IN komutları yardımıyla yeni internal tabloyu tanımlandığı yerde doldurun.

TYPES: BEGIN OF gty_table.
        INCLUDE TYPE stravelag.
TYPES: END OF gty_table.

TYPES: gtt_table TYPE TABLE OF gty_table WITH NON-UNIQUE KEY agencynum.

START-OF-SELECTION.

SELECT * FROM stravelag INTO TABLE @DATA(gt_stravelag).

  DATA(gt_table) = VALUE gtt_table( FOR gs_stravelag
                                    IN gt_stravelag
                                    WHERE ( agencynum > 120 ) ( gs_stravelag ) ).

  BREAK-POINT.
