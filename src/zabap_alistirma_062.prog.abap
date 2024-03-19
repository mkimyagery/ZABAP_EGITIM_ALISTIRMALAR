*&---------------------------------------------------------------------*
*& Report ZCM_TEST_341
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_062.

*Alıştırma – 7: Yeni bir rapor oluşturun. Raporda 1 adet tip tanımlaması yapın ve tip içerisinde
*STRAVELAG tablosundan herhangi 5 kolon bulunsun. Inline declaration kullanarak bu tip tanımlaması
*ve VALUE komutu yardımıyla bir structure tanımlayın ve içerisini istediğiniz değerlerle doldurun. Ayni
*tip tanımlamasını kullanarak bir table type tanımlayın. Inline declaration kullanarak table type ve
*VALUE komutu yardımıyla yeni bir internal tablo oluşturun ve içine 3 adet satır ekleyin.

TYPES: BEGIN OF gty_table,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         city      TYPE city,
         country   TYPE s_country,
       END OF gty_table.

TYPES: gtt_table TYPE TABLE OF gty_table WITH NON-UNIQUE KEY agencynum.

START-OF-SELECTION.

DATA(gs_stravelag) = VALUE gty_table( agencynum = '123'
                                      name      = 'Acente 1'
                                      street    = 'Ilkbahar Caddesi'
                                      city      = 'Istanbul'
                                      country   = 'TR' ).

DATA(gt_stravelag) = VALUE gtt_table( ( agencynum = '234' name = 'Acente 2' street = 'Sonbahar Caddesi' city = 'Izmir' country = 'TR' )
                                      ( agencynum = '235' name = 'Acente 3' street = 'Sonbahar Caddesi' city = 'Izmir' country = 'TR' )
                                      ( agencynum = '236' name = 'Acente 4' street = 'Sonbahar Caddesi' city = 'Izmir' country = 'TR' ) ).

BREAK-POINT.
