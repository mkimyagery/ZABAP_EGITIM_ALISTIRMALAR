*&---------------------------------------------------------------------*
*& Report ZCM_TEST_72
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_042.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_carrid TYPE s_carr_id OBLIGATORY,
              p_num    TYPE i OBLIGATORY,
              p_artir  RADIOBUTTON GROUP abc,
              p_azalt  RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gs_spfli    TYPE zcm_spfli,
      gt_spfli    TYPE TABLE OF zcm_spfli,
      gv_dist_new TYPE i.

START-OF-SELECTION.

  IF p_num > 100.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  SELECT * FROM zcm_spfli INTO TABLE gt_spfli WHERE carrid = p_carrid.

    IF gt_spfli IS NOT INITIAL.

      LOOP AT gt_spfli INTO gs_spfli.

        IF p_artir IS NOT INITIAL.
          gv_dist_new = gs_spfli-distance + p_num.
        ELSEIF p_azalt IS NOT INITIAL.
          gv_dist_new = gs_spfli-distance - p_num.
        ENDIF.

        UPDATE zcm_spfli SET distance = gv_dist_new WHERE carrid = gs_spfli-carrid AND
                                                          connid = gs_spfli-connid.
        CLEAR: gv_dist_new.
      ENDLOOP.

    ELSE.

      MESSAGE text-003 TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.





*        gs_spfli-distance = gs_spfli-distance + p_num.
*        gs_spfli-distance = gs_spfli-distance - p_num.

*        UPDATE zcm_spfli SET distance = gs_spfli-distance WHERE carrid = gs_spfli-carrid AND
*                                                                connid = gs_spfli-connid.
