*&---------------------------------------------------------------------*
*& Report ZCM_TEST_90
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_047.

PARAMETERS: p_cf_1 TYPE land1,
            p_cf_2 TYPE land1,
            p_cf_3 TYPE land1.

DATA: gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.


  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE countryfr = p_cf_1 OR
          countryfr = p_cf_2 OR
          countryfr = p_cf_3.

  SELECT * FROM sflight
    INTO TABLE gt_sflight
    FOR ALL ENTRIES IN gt_spfli
    WHERE connid = gt_spfli-connid.


  BREAK-POINT.
