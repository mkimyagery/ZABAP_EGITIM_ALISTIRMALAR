*&---------------------------------------------------------------------*
*& Report ZCM_TEST_127
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_009.

"Scarr tablosunun ALV'sini hazirla.
"Scarr ID'sini Hotspot yap.
"SPFLI tablosunun ALV'sini hazirla.
"SPFLI ID'sini Hotspot yap.
"Sflight tablosunun ALV'sini hazirla.

INCLUDE zcm_test_127_top.
INCLUDE zcm_test_127_f01.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.
