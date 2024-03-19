*&---------------------------------------------------------------------*
*& Report ZCM_TEST_339
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_060.
*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan sadece 1 sayı alın. Rapor içinde SPFLI
*tablosundan bütün satırları okuyun. Elde edilen internal tabloda bulunan ve kullanıcının girdiği sayı ile
*ayni index numarasına sahip satiri okuyun ve ekrana yazdırın. Bunu yaparken Abap 7.40 ile gelen yeni
*internal tablo okuma yöntemini kullanın.


PARAMETERS: p_sayi TYPE i.

START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

  TRY.
      DATA(gs_spfli) = gt_spfli[ p_sayi ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Girdiginiz index no ile satir bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
  ENDTRY.

  WRITE: gs_spfli-carrid, gs_spfli-connid.

  READ TABLE gt_spfli INTO DATA(gs_spfli_2) INDEX p_sayi.
  IF sy-subrc IS NOT INITIAL.

  ENDIF.
