*&---------------------------------------------------------------------*
*& Report ZCM_TEST_336
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_057.

*Alıştırma – 2: Yeni bir rapor oluşturun ve ZCM_TABLO_1 ile ZCM_TABLO_2 database tablolarından
*bütün verileri çekin. Daha sonra ikinci tablodan gelen veri ile loop ederek izinlerin bitiş tarihlerini 1’er
*gün arttırın. Bunu yaparken birinci tablodaki izin hakkini da kontrol edin. Yani bu işlemi sadece yeni
*değerin birinci tablodaki izin hakkini geçmediği durumlarda gerçekleştirin. Raporda inline declaration
*ile tanımlanmış değişkenler kullanın.

TYPES: BEGIN OF gty_table,
         id       TYPE zcm_de_id,
         yil      TYPE c LENGTH 4,
         kul_izin TYPE int1,
       END OF gty_table.

DATA: gt_izin    TYPE TABLE OF gty_table,
      gv_is_gunu TYPE i,
      gv_date    TYPE datum.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_1 INTO TABLE @DATA(gt_tablo_1).
  SELECT * FROM zcm_tablo_2 INTO TABLE @DATA(gt_tablo_2).

  LOOP AT gt_tablo_2 INTO DATA(gs_tablo_2).

    READ TABLE gt_izin ASSIGNING FIELD-SYMBOL(<fs_izin>) WITH KEY id = gs_tablo_2-id yil = gs_tablo_2-yil.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO gt_izin ASSIGNING <fs_izin>.
      <fs_izin>-id       = gs_tablo_2-id.
      <fs_izin>-yil      = gs_tablo_2-yil.
      <fs_izin>-kul_izin = gs_tablo_2-kul_izin.
    ELSE.
      <fs_izin>-kul_izin = <fs_izin>-kul_izin + gs_tablo_2-kul_izin.
    ENDIF.

  ENDLOOP.

  SORT gt_izin BY id.

  LOOP AT gt_tablo_2 ASSIGNING FIELD-SYMBOL(<fs_2>).

    READ TABLE gt_tablo_1 INTO DATA(gs_tablo_1) WITH KEY id = <fs_2>-id.
    IF sy-subrc IS INITIAL.

      READ TABLE gt_izin ASSIGNING <fs_izin> WITH KEY id = <fs_2>-id yil = <fs_2>-yil.
      IF sy-subrc IS INITIAL.

        IF <fs_izin>-kul_izin < gs_tablo_1-izin_hakki.

          gv_date = <fs_2>-izin_bitis + 1.

          CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
            EXPORTING
              begda   = gv_date
              endda   = gv_date
              mofid   = '08'
            CHANGING
              wrkdays = gv_is_gunu.

          IF gv_is_gunu = 1.
            <fs_2>-izin_bitis  = gv_date.
            <fs_2>-kul_izin    = <fs_2>-kul_izin + 1.
            <fs_izin>-kul_izin = <fs_izin>-kul_izin + 1.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDLOOP.

  BREAK-POINT.
