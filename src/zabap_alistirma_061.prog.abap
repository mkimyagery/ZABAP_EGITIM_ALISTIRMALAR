*&---------------------------------------------------------------------*
*& Report ZCM_TEST_340
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_061.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID ve 1 adet CONNID alın. Rapor
*içinde SPFLI tablosunun tamamını okuyup bir internal tablo içine kaydedin. LINE_INDEX komutunu
*kullanarak secim ekranından gelen veriler yardımıyla internal tablodaki ilgili satirin kaçıncı satir
*olduğunu bulun.

PARAMETERS: p_carrid TYPE s_carr_id,
            p_connid TYPE s_conn_id.

START-OF-SELECTION.

SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

  DATA(gv_index) = line_index( gt_spfli[ carrid = p_carrid connid = p_connid ] ).

  BREAK-POINT.

  READ TABLE gt_spfli WITH KEY carrid = p_carrid connid = p_connid TRANSPORTING NO FIELDS.


  BREAK-POINT.
