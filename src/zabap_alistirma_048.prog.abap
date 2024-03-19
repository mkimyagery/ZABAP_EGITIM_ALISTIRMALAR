*&---------------------------------------------------------------------*
*& Report ZCM_TEST_91
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_048.


PARAMETERS: p_ad    TYPE c LENGTH 20,
            p_soyad TYPE c LENGTH 20.

DATA: gv_ad_soyad TYPE c LENGTH 50,
      gv_num TYPE i.

START-OF-SELECTION.

PERFORM birlestir.
PERFORM yaz.



FORM birlestir.
  CONCATENATE p_ad p_soyad INTO gv_ad_soyad SEPARATED BY space.

  DO 10 TIMES.
    gv_num = gv_num + 1.
  ENDDO.
ENDFORM.


FORM yaz.
  WRITE: gv_ad_soyad.
ENDFORM.
