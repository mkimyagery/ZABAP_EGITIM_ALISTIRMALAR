*&---------------------------------------------------------------------*
*& Report ZCM_TEST_49
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_027.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_ayeri  TYPE c LENGTH 30,
              p_urun   TYPE c LENGTH 10,
              p_miktar TYPE p DECIMALS 2,
              p_birim  TYPE c LENGTH 3,
              p_tarih  TYPE datum,
              p_saat   TYPE uzeit.
SELECTION-SCREEN END OF BLOCK a1.

TYPES: BEGIN OF gty_structure,
         ayeri  TYPE c LENGTH 20,
         urun   TYPE c LENGTH 10,
         miktar TYPE p DECIMALS 2,
         birim  TYPE c LENGTH 3,
         tarih  TYPE datum,
         saat   TYPE uzeit,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure.

START-OF-SELECTION.

  gs_structure-ayeri  = p_ayeri.
  gs_structure-urun   = p_urun.
  gs_structure-miktar = p_miktar.
  gs_structure-birim  = p_birim.
  gs_structure-tarih  = p_tarih.
  gs_structure-saat   = p_saat.

  DO 10 TIMES.
    APPEND gs_structure TO gt_table.

    gs_structure-tarih = gs_structure-tarih + 1.
    gs_structure-miktar = gs_structure-miktar + '0.50'.

  ENDDO.

  CLEAR: gs_structure.

  LOOP AT gt_table INTO gs_structure.
    WRITE: gs_structure-ayeri,
           gs_structure-urun,
           gs_structure-miktar,
           gs_structure-birim,
           gs_structure-tarih,
           gs_structure-saat.
    CLEAR: gs_structure.
    SKIP.
  ENDLOOP.
