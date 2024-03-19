*&---------------------------------------------------------------------*
*& Report ZCM_TEST_217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_021.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde bir e-mail adresi alın.
*Gelen verinin bir e-mail adresi olup olmadığını kontrol edin. (Kurallar: içerisinde “@” sembolü
*bulunacak. @ sembolünün sağı ve solu bos olmayacak. İngilizce olmayan karakter içermeyecek. Sonu
*“.com” ile bitecek.)

PARAMETERS: p_email TYPE string.

DATA: gv_sol TYPE string,
      gv_sag TYPE string.

START-OF-SELECTION.

  IF p_email NA '@'.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  IF p_email CA ' '.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  SPLIT p_email AT '@' INTO gv_sol gv_sag.

  IF gv_sag CA '@'.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  IF p_email CA 'çşığüö' OR p_email CA 'ÇŞĞÜÖ'.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  IF p_email CA '!"§$%&/()=?€'.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  IF p_email NP '*.com'.
    MESSAGE: 'Yanlis e-mail adresi.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
