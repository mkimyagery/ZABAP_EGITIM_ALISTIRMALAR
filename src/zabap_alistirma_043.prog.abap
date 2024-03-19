*&---------------------------------------------------------------------*
*& Report ZCM_TEST_86
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_043.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 3 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.
*Ancak ekrana yazdırırken önce SCARR tablosundan 1 satir yazdırın, daha sonra SPFLI tablosunda bu
*satir ile ayni CARRID bilgisine sahip olan satırları yazdırmaya başlayın. Her SPFLI satırından sonra
*SFLIGHT tablosundan bu satir ile ayni CARRID bilgisine sahip olan satırları yazdırın.

DATA: gs_scarr   TYPE scarr,
      gs_spfli   TYPE spfli,
      gs_sflight TYPE sflight,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

*DATA: gv_carrid TYPE s_carr_id. "Alternatif tanimlama.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_carr FOR gs_scarr-carrid.
*  SELECT-OPTIONS: so_carr for gv_carrid.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr WHERE carrid IN so_carr.
  SELECT * FROM spfli INTO TABLE gt_spfli WHERE carrid IN so_carr.
  SELECT * FROM sflight INTO TABLE gt_sflight WHERE carrid IN so_carr.

  LOOP AT gt_scarr INTO gs_scarr.

    WRITE: gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode, gs_scarr-url.
*    SKIP.
    ULINE.

    LOOP AT gt_spfli INTO gs_spfli WHERE carrid = gs_scarr-carrid.

      WRITE: / gs_spfli-carrid,   gs_spfli-connid,    gs_spfli-countryfr, gs_spfli-cityfrom.
      "gs_spfli-airpfrom, gs_spfli-countryto, gs_spfli-cityto,    gs_spfli-airpto,
      "gs_spfli-fltime,   gs_spfli-deptime,   gs_spfli-arrtime,   gs_spfli-distance,
      "gs_spfli-distid,   gs_spfli-fltype,    gs_spfli-period.
*      SKIP.
      ULINE.

      LOOP AT gt_sflight INTO gs_sflight WHERE carrid = gs_scarr-carrid AND connid = gs_spfli-connid.

        WRITE: / gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate, gs_sflight-price.
        "gs_sflight-currency, gs_sflight-planetype, gs_sflight-seatsmax, gs_sflight-seatsocc,
        "gs_sflight-paymentsum, gs_sflight-seatsmax_b, gs_sflight-seatsocc_b, gs_sflight-seatsmax_f,
        "gs_sflight-seatsocc_f.
        SKIP.
        ULINE.

        CLEAR: gs_sflight.
      ENDLOOP.

      CLEAR: gs_spfli.
    ENDLOOP.

    CLEAR: gs_scarr.
  ENDLOOP.
